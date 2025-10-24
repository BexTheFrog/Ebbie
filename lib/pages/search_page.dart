import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/services/database.dart';
import 'package:ebbie/services/user_service.dart';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:ebbie/widgets/module_homepage/custom_review_card.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_dropdown_menu.dart';
import '../widgets/empty_search_state.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final dbHelper = DatabaseHelper();
  int? userId;
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> tarefas = [];
  List<Map<String, dynamic>> filteredTarefas = [];

  @override
  void initState() {
    super.initState();
    _loadUserId();
    fetchTarefas();
  }

  Future<void> _loadUserId() async {
    int? id = await UserService.getUserId();
    setState(() => userId = id);
  }

  Future<void> fetchTarefas() async {
    final result = await dbHelper.rawQuery('''
      SELECT 
        t.*, 
        m.nome AS nomeModulo,
        ma.nome AS nomeMateria
      FROM tarefa t
      INNER JOIN modulo m ON t.idModulo = m.id
      INNER JOIN materia ma ON t.idMateria = ma.id
      ORDER BY t.dataRevisao
      LIMIT 3
    ''');

    setState(() {
      tarefas = result.map((t) => Map<String, dynamic>.from(t)).toList();
      filteredTarefas = List<Map<String, dynamic>>.from(tarefas);
    });
  }

  Future<void> handleStudy(String? selectedMood, Map<String, dynamic> t) async {
    if (userId == null || selectedMood == null) return;

    final tarefaId = t['id'];
    final tarefaData = await dbHelper.query(
      'tarefa',
      where: 'id = ?',
      whereArgs: [tarefaId],
    );
    if (tarefaData.isEmpty) return;

    final tarefaAtual = tarefaData[0];
    final hoje = DateTime.now();

    // Corrige o tipo para String antes de parse
    final dataRevisao =
        DateTime.tryParse((tarefaAtual['dataRevisao'] ?? '').toString()) ??
        hoje;

    final tarefaDia = DateTime(
      dataRevisao.year,
      dataRevisao.month,
      dataRevisao.day,
    );
    final somenteHoje = DateTime(hoje.year, hoje.month, hoje.day);

    if (tarefaDia != somenteHoje) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (dialogContext) => CustomMsgDialog(
          title: 'Atenção',
          content: 'Você só pode marcar esta revisão no dia da tarefa.',
          ok: CustomOk(function: () => Navigator.pop(dialogContext)),
        ),
      );
      return;
    }

    final lastReview = await dbHelper.query(
      'review_stats',
      where: 'idTarefa = ?',
      whereArgs: [tarefaId],
      orderBy: 'id DESC',
      limit: 1,
    );

    int repeticoes = 0;
    double easiness = 2.5;
    int intervalo = 1;

    if (lastReview.isNotEmpty) {
      repeticoes = lastReview[0]['repeticoes'] ?? 0;
      easiness = lastReview[0]['easiness'] ?? 2.5;
      intervalo = lastReview[0]['intervalo'] ?? 1;
    }

    final nota = selectedMood == 'mal'
        ? 1
        : selectedMood == 'ok'
        ? 3
        : 5;

    if (nota < 3) {
      repeticoes = 0;
      intervalo = 1;
      easiness = (easiness - 0.2).clamp(1.3, 2.5);
    } else {
      repeticoes++;
      intervalo = repeticoes == 1
          ? 1
          : repeticoes == 2
          ? 3
          : (intervalo * easiness).round();
      easiness = (easiness + 0.1 - (5 - nota) * (0.08 + (5 - nota) * 0.02))
          .clamp(1.3, double.infinity);
    }

    final memorizado = repeticoes >= 5 && selectedMood == 'bem';

    final userData = await dbHelper.query(
      'user',
      where: 'id = ?',
      whereArgs: [userId],
    );
    if (userData.isEmpty) return;

    final usuario = userData[0];

    if (memorizado) {
      await dbHelper.update(
        'tarefa',
        {'status': 'memorizado', 'dataRevisao': null},
        'id = ?',
        [tarefaId],
      );

      const bonus = 10;
      await dbHelper.update(
        'user',
        {
          'carteira': (usuario['carteira'] ?? 0) + bonus,
          'totalMemorizadas': (usuario['totalMemorizadas'] ?? 0) + 1,
          'totalEstudadas': (usuario['totalEstudadas'] ?? 0) + 1,
        },
        'id = ?',
        [userId],
      );

      if (!mounted) return;
      showDialog(
        context: context,
        builder: (dialogContext) => CustomMsgDialog(
          title: 'Concluído 🎉',
          content:
              'Você dominou "${tarefaAtual['topico']}"! Esta revisão foi marcada como memorizada.',
          ok: CustomOk(function: () => Navigator.pop(dialogContext)),
        ),
      );
      return;
    }

    final proximaData = hoje.add(Duration(days: intervalo));
    final moedas = nota == 1
        ? 1
        : nota == 3
        ? 2
        : 3;

    await dbHelper.update(
      'user',
      {
        'carteira': (usuario['carteira'] ?? 0) + moedas,
        'totalEstudadas': (usuario['totalEstudadas'] ?? 0) + 1,
      },
      'id = ?',
      [userId],
    );

    // Atualiza status na tarefa
    await dbHelper.update(
      'tarefa',
      {'status': 'realizado', 'dataRevisao': proximaData.toIso8601String()},
      'id = ?',
      [tarefaId],
    );

    // Insere review_stats com mood separado
    await dbHelper.insert('review_stats', {
      'idUsuario': tarefaAtual['idUsuario'],
      'idTarefa': tarefaId,
      'status': 'realizado', // apenas indica que revisou
      'mood': selectedMood, // registra como o usuário se sentiu
      'data': hoje.toIso8601String(),
      'intervalo': intervalo,
      'easiness': easiness,
      'repeticoes': repeticoes,
    });

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (dialogContext) => CustomMsgDialog(
        title: 'Próxima Revisão',
        content:
            'A próxima revisão de "${tarefaAtual['topico']}" será em ${DateFormat('dd/MM/yyyy').format(proximaData)}.',
        ok: CustomOk(function: () => Navigator.pop(dialogContext)),
      ),
    );
  }

  void filterTarefas(String query) {
    final filtered = tarefas.where((tarefa) {
      final topico = tarefa['topico'].toString().toLowerCase();
      return topico.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredTarefas = filtered;
    });
  }

  Future<void> updateTarefaStatus(
    int tarefaId,
    String selectedMood,
    DateTime proximaData,
  ) async {
    setState(() {
      tarefas = tarefas.map((t) {
        if (t['id'] == tarefaId) {
          return {
            ...t,
            'status': selectedMood,
            'dataRevisao': proximaData.toIso8601String(),
          };
        }
        return t;
      }).toList();
      filteredTarefas = tarefas
          .where(
            (t) => t['topico'].toString().toLowerCase().contains(
              searchController.text.toLowerCase(),
            ),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFFF7EDE2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: filterTarefas,
              decoration: InputDecoration(
                hintText: 'Buscar por tópico...',
                hintStyle: TextStyle(color: theme.appbarColor.withAlpha(150)),
                filled: true,
                fillColor: const Color(0xFFF7EDE2),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                suffixIcon: Icon(Icons.search, color: theme.searchColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: theme.appbarColor, width: 3),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: theme.searchColor, width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: theme.searchColor, width: 3),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: RefreshIndicator(
                onRefresh: fetchTarefas,
                color: theme.searchColor,
                backgroundColor: Colors.white,
                child: filteredTarefas.isEmpty
                    ? const EmptySearchState()
                    : ListView.builder(
                        clipBehavior: Clip.none,
                        itemCount: filteredTarefas.length,
                        itemBuilder: (context, index) {
                          final tarefa = filteredTarefas[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: CustomReviewCard(
                              key: ValueKey(tarefa['id']),
                              materia: tarefa['nomeMateria'].toString(),
                              modulo: tarefa['nomeModulo'].toString(),
                              reviewName: tarefa['topico'],
                              reviewDesc: tarefa['descricao'] ?? '',
                              dataReview: DateTime.parse(
                                tarefa['dataRevisao'] ??
                                    DateTime.now().toString(),
                              ),
                              function: () {},
                              onPressed: () {},
                              hasStudy: (String? selectedMood) async {
                                await handleStudy(selectedMood, tarefa);
                                final proximaData = DateTime.tryParse(
                                  tarefa['dataRevisao'] ?? '',
                                );
                                if (proximaData != null &&
                                    selectedMood != null) {
                                  await updateTarefaStatus(
                                    tarefa['id'],
                                    selectedMood,
                                    proximaData,
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
