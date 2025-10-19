import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/pages/revisionExpand.dart';
import 'package:ebbie/services/database.dart';
import 'package:ebbie/services/user_service.dart';
import 'package:ebbie/widgets/custom_appbar.dart';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_edit_form.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:ebbie/widgets/module_forms/custom_review_form.dart';
import 'package:ebbie/widgets/module_forms/custom_review_mood.dart';
import 'package:ebbie/widgets/module_homepage/custom_filter.dart';
import 'package:ebbie/widgets/module_homepage/custom_review_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:ebbie/services/wallet.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbHelper = DatabaseHelper();
  final DateTime _diaAtual = DateTime.now();
  DateTime? _diaSelecionado;
  int? userId;
  bool _loading = false;
  String _periodoSelecionado = 'HOJE';
  List<Map<String, dynamic>> reviews = []; // lista de reviews exibida
  List<Map<String, dynamic>> dados = [];

  @override
  void initState() {
    super.initState();
    _loadUserId();
    atualizarTarefasPuladas();
  }

  Future<void> atualizarTarefasPuladas() async {
    final db = await dbHelper.database;
    DateTime hoje = DateTime.now();
    DateTime somenteHoje = DateTime(hoje.year, hoje.month, hoje.day);

    final tarefas = await db.rawQuery('SELECT * FROM tarefa');

    for (var tarefa in tarefas) {
      DateTime dataRevisao =
          DateTime.tryParse(tarefa['dataRevisao']?.toString() ?? '') ??
          DateTime.now();
      DateTime tarefaDia = DateTime(
        dataRevisao.year,
        dataRevisao.month,
        dataRevisao.day,
      );

      if (tarefaDia.isBefore(somenteHoje) && tarefa['wasReviewd'] != 1) {
        // Atualiza a tarefa para o dia atual e marca como pulada
        await dbHelper.update(
          'tarefa',
          {'dataRevisao': somenteHoje.toIso8601String(), 'wasSkipped': 1},
          'id = ?',
          [tarefa['id']],
        );
      }
    }
  }

  Future<void> _loadUserId() async {
    // Pega o id do usuário
    int? id = await UserService.getUserId();

    setState(() => userId = id);

    if (id != null) {
      // Pega os dados do usuário do banco
      final userData = await dbHelper.query(
        'user',
        where: 'id = ?',
        whereArgs: [id],
      );

      setState(() {
        dados = userData;
      });

      _loadReviews(_periodoSelecionado);
    }
  }

  Future<void> _loadReviews(String periodo) async {
    if (userId == null) return;
    setState(() => _periodoSelecionado = periodo);

    final db = await dbHelper.database;

    final hoje = DateTime.now();
    final formatador = DateFormat('yyyy-MM-dd');

    String sql = '''
      SELECT t.*,
             m.nome AS materiaNome,
             mod.nome AS moduloNome
      FROM tarefa t
      LEFT JOIN materia m ON m.id = t.idMateria
      LEFT JOIN modulo mod ON mod.id = t.idModulo
      WHERE t.idUsuario = ?
    ''';

    List<dynamic> params = [userId];

    if (periodo == 'HOJE') {
      sql += ' AND date(t.dataRevisao) = ?';
      params.add(formatador.format(hoje));
    } else if (periodo == 'SEMANA') {
      final inicio = hoje.subtract(Duration(days: hoje.weekday - 1));
      final fim = inicio.add(Duration(days: 6));
      sql += ' AND date(t.dataRevisao) BETWEEN ? AND ?';
      params.addAll([formatador.format(inicio), formatador.format(fim)]);
    } else if (periodo == 'MÊS') {
      final inicio = DateTime(hoje.year, hoje.month, 1);
      final fim = DateTime(hoje.year, hoje.month + 1, 0);
      sql += ' AND date(t.dataRevisao) BETWEEN ? AND ?';
      params.addAll([formatador.format(inicio), formatador.format(fim)]);
    }

    sql += ' ORDER BY t.dataRevisao ASC';

    final result = await db.rawQuery(sql, params);

    setState(() {
      reviews = result.map((r) => Map<String, dynamic>.from(r)).toList();
    });
  }

  void _onPeriodoChanged(String periodo) async {
    setState(() {
      _periodoSelecionado = periodo;
      _loading = true;
    });

    await _loadReviews(periodo);

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: const Color(0xFFF7EDE2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          clipBehavior: Clip.none,
          children: [
            Column(
              spacing: 30,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //width: 335,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(36),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF78624D).withAlpha(20), // cor da sombra
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCalendar(
                      enabledDayPredicate: (day) {
                        final today = DateTime.now();
                        final onlyToday = DateTime(
                          today.year,
                          today.month,
                          today.day,
                        );
                        final onlyDay = DateTime(day.year, day.month, day.day);
                        return !onlyDay.isBefore(onlyToday);
                      },
                      locale: 'pt_BR',
                      focusedDay: _diaAtual,
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      onDaySelected: (selectedDay, focusedDay) async {
                        setState(() {
                          _diaSelecionado = selectedDay;
                        });

                        final result = await showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return CustomDialogRevieweForm(
                              dataReview: _diaSelecionado!,
                              userId: userId!,
                            );
                          },
                        );

                        if (result == true) {
                          _loadReviews(_periodoSelecionado);
                        }
                      },
                      calendarFormat: CalendarFormat.month,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        leftChevronIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 4, right: 2),
                          child: Icon(
                            Icons.arrow_left_rounded,
                            color: AppColors.darkSlate,
                            weight: 30,
                            size: 60,
                          ),
                        ),
                        rightChevronIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 4, right: 2),
                          child: Icon(
                            Icons.arrow_right_rounded,
                            color: AppColors.darkSlate,
                            size: 60,
                          ),
                        ),
                        titleTextStyle: const TextStyle(
                          fontFamily: 'CerebriSansPro',
                          color: AppColors.darkSlate,
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                          height: 1.2,
                        ),
                        titleTextFormatter: (date, locale) {
                          final DateTime now = DateTime.now();
                          final anoAtual = date.year == now.year;
                          final String nomeMes = MaterialLocalizations.of(
                            context,
                          ).formatMonthYear(date).split(' ')[0].toUpperCase();

                          return anoAtual ? nomeMes : '$nomeMes ${date.year}';
                        },
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: const TextStyle(
                          fontFamily: 'CerebriSansPro',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.darkSlate,
                        ),
                        weekendStyle: const TextStyle(
                          fontFamily: 'CerebriSansPro',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.coral,
                        ),
                        dowTextFormatter: (date, locale) {
                          String day = DateFormat.E(
                            locale,
                          ).format(date).toUpperCase();
                          // Remove ponto final
                          if (day.endsWith('.')) {
                            day = day.substring(0, day.length - 1);
                          }
                          return day;
                        },
                      ),
                      calendarStyle: CalendarStyle(
                        cellPadding: EdgeInsets.all(5),
                        tablePadding: EdgeInsets.all(8),
                        weekendDecoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          shape: BoxShape.circle,
                        ),
                        defaultTextStyle: TextStyle(
                          fontFamily: 'CerebriSansPro',
                          color: Color(0xFF78624D),
                        ),
                        weekendTextStyle: TextStyle(
                          fontFamily: 'CerebriSansPro',
                          color: Color(0xFF78624D),
                        ),
                        defaultDecoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: Color(0xFFF6BD60),
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Color(0xFF9BC1BC),
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'CerebriSansPro',
                        ),
                        todayTextStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'CerebriSansPro',
                        ),
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 5, // Espessura da linha
                        decoration: BoxDecoration(
                          color: AppColors.tealBlue,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset(
                        "assets/images/brain_icon_small.png",
                        height: 50,
                        color: AppColors.tealBlue,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 5, // Espessura da linha
                        decoration: BoxDecoration(
                          color: AppColors.tealBlue,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),

                FiltroPeriodo(
                  onPeriodoChanged: _onPeriodoChanged,
                  periodoAtual: _periodoSelecionado,
                ),
                SizedBox(height: 10),
              ],
            ),
            _loading
                ? const Center(child: CircularProgressIndicator())
                : reviews.isEmpty
                ? Center(
                    child: Text(
                      'Nenhuma review para ${_periodoSelecionado.toLowerCase()}',
                      style: TextStyle(
                        fontFamily: 'CerebriSansPro',
                        color: AppColors.darkSlate,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Column(
                    spacing: 20,
                    children: reviews.map((t) {
                      final data =
                          DateTime.tryParse(t['dataRevisao'] ?? '') ??
                          DateTime.now();
                      return CustomReviewCard(
                        materia: t['materiaNome'],
                        modulo: t['moduloNome'],
                        reviewName: t['topico'],
                        reviewDesc: '${t['descricao']}',
                        wasReviewd: t['wasReviewd'] == 1,
                        dataReview: data,
                        hasStudy: (String? selectedMood) async {
                          final tarefaId = t['id'];
                          if (userId == null) return;

                          final tarefaData = await dbHelper.query(
                            'tarefa',
                            where: 'id = ?',
                            whereArgs: [tarefaId],
                          );
                          if (tarefaData.isEmpty) return;
                          final tarefa = tarefaData[0];

                          DateTime dataRevisao =
                              DateTime.tryParse(tarefa['dataRevisao']) ??
                              DateTime.now();
                          DateTime hoje = DateTime.now();
                          DateTime tarefaDia = DateTime(
                            dataRevisao.year,
                            dataRevisao.month,
                            dataRevisao.day,
                          );
                          DateTime somenteHoje = DateTime(
                            hoje.year,
                            hoje.month,
                            hoje.day,
                          );

                          // Bloqueio para marcar fora do dia da revisão
                          if (tarefaDia != somenteHoje) {
                            if (mounted) {
                              showDialog(
                                context: context,
                                builder: (_) => CustomMsgDialog(
                                  title: 'Atenção',
                                  content:
                                      'Você só pode marcar esta revisão no dia da tarefa.',
                                  ok: CustomOk(
                                    function: () => Navigator.pop(context),
                                  ),
                                ),
                              );
                            }
                            return;
                          }

                          // Usuário fechou diálogo sem escolher mood
                          if (selectedMood == null) return;

                          // Calcula moedas com base no mood
                          int moedas = 0;
                          switch (selectedMood) {
                            case 'mal':
                              moedas = 1;
                              break;
                            case 'ok':
                              moedas = 2;
                              break;
                            case 'bem':
                              moedas = 3;
                              break;
                          }

                          // Atualiza a carteira do usuário
                          final userData = await dbHelper.query(
                            'user',
                            where: 'id = ?',
                            whereArgs: [userId],
                          );
                          if (userData.isNotEmpty) {
                            final carteiraAtual = userData[0]['carteira'] ?? 0;
                            await dbHelper.update(
                              'user',
                              {'carteira': carteiraAtual + moedas},
                              'id = ?',
                              [userId],
                            );
                            coinNotifier.value = carteiraAtual + moedas;
                          }

                          // Calcula próxima data de revisão
                          DateTime proximaData;
                          switch (selectedMood) {
                            case 'mal':
                              proximaData = dataRevisao.add(Duration(days: 1));
                              break;
                            case 'ok':
                              proximaData = dataRevisao.add(Duration(days: 3));
                              break;
                            case 'bem':
                              proximaData = dataRevisao.add(Duration(days: 7));
                              break;
                            default:
                              proximaData = dataRevisao.add(Duration(days: 1));
                          }

                          // Atualiza tarefa para próxima revisão
                          await dbHelper.update(
                            'tarefa',
                            {
                              'status': selectedMood,
                              'dataRevisao': proximaData.toIso8601String(),
                            },
                            'id = ?',
                            [tarefaId],
                          );

                          // Registra estatística da revisão
                          await dbHelper.insert('review_stats', {
                            'idUsuario': tarefa['idUsuario'],
                            'idTarefa': tarefaId,
                            'status': selectedMood,
                            'data': DateTime.now().toIso8601String(),
                          });

                          // Mostra diálogo com a próxima revisão
                          if (mounted) {
                            showDialog(
                              context: context,
                              builder: (dialogContext) => CustomMsgDialog(
                                title: 'Próxima Revisão',
                                content:
                                    'A próxima revisão de "${tarefa['topico']}" será em ${DateFormat('dd/MM/yyyy').format(proximaData)}.',
                                ok: CustomOk(
                                  function: () => Navigator.pop(dialogContext),
                                ),
                              ),
                            );
                          }

                          if (mounted) _loadReviews(_periodoSelecionado);
                        },

                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      LucideIcons.squarePen,
                                      color: AppColors.tealBlue,
                                    ),
                                    title: Text(
                                      'Editar',
                                      style: TextStyle(
                                        fontFamily: 'CerebriSansPro',
                                        color: AppColors.tealBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);

                                      showDialog(
                                        context: context,
                                        builder: (context) => CustomEditForm(
                                          dataReview:
                                              DateTime.tryParse(
                                                t['dataRevisao'] ?? '',
                                              ) ??
                                              DateTime.now(),
                                          userId: userId!,
                                          topico: t['topico'],
                                          descricao: t['descricao'],
                                          selectedModuleId: t['idModulo'],
                                          selectedSubjectId: t['idMateria'],
                                          tarefaId: t['id'],
                                        ),
                                      ).then((updated) {
                                        if (updated == true) {
                                          _loadReviews(
                                            _periodoSelecionado,
                                          ); // atualiza a lista
                                        }
                                      });
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      LucideIcons.circleX,
                                      color: Colors.red,
                                    ),
                                    title: Text(
                                      'Excluir',
                                      style: TextStyle(
                                        fontFamily: 'CerebriSansPro',
                                        color: AppColors.coral,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context); // fecha o menu
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return CustomMsgDialog(
                                            title: 'Excluindo Review',
                                            content:
                                                "Deseja realmente deletar ${t['topico']}?",
                                            ok: CustomOk(
                                              function: () => Navigator.pop(
                                                dialogContext,
                                                true,
                                              ),
                                            ),
                                          );
                                        },
                                      );

                                      if (confirm == true) {
                                        final id = t['id'];

                                        try {
                                          await dbHelper.delete(
                                            'tarefa',
                                            'id = ?',
                                            [id],
                                          );
                                          _loadReviews(_periodoSelecionado);
                                        } catch (e) {
                                          showDialog<bool>(
                                            context: context,
                                            builder:
                                                (BuildContext dialogContext) {
                                                  return CustomMsgDialog(
                                                    title: 'Erro',
                                                    content:
                                                        "Erro ao deletar: $e",
                                                    ok: CustomOk(
                                                      function: () =>
                                                          Navigator.pop(
                                                            dialogContext,
                                                          ),
                                                    ),
                                                  );
                                                },
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        function: () {},
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
