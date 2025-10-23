import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/services/database.dart';
import 'package:ebbie/services/user_service.dart';
import 'package:ebbie/services/wallet.dart';
import 'package:ebbie/widgets/custom_appbar.dart';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_edit_form.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:ebbie/widgets/module_forms/custom_review_form.dart';
import 'package:ebbie/widgets/module_homepage/custom_filter.dart';
import 'package:ebbie/widgets/module_homepage/custom_review_card.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

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
  List<Map<String, dynamic>> reviews = [];
  List<Map<String, dynamic>> dados = [];
  Map<String, dynamic>? userData;
  Map<String, int>? userStats;

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

      if (tarefaDia.isBefore(somenteHoje) && tarefa['status'] != 'memorizado') {
        await dbHelper.update(
          'tarefa',
          {'dataRevisao': somenteHoje.toIso8601String(), 'status': 'pulada'},
          'id = ?',
          [tarefa['id']],
        );

        final userData = await dbHelper.query(
          'user',
          where: 'id = ?',
          whereArgs: [tarefa['idUsuario']],
        );

        if (userData.isNotEmpty) {
          final usuario = userData[0];
          await dbHelper.update(
            'user',
            {'totalPuladas': (usuario['totalPuladas'] ?? 0) + 1},
            'id = ?',
            [tarefa['idUsuario']],
          );
        }
      }
    }
  }

  Future<void> _loadUserId() async {
    int? id = await UserService.getUserId();
    setState(() => userId = id);

    if (id != null) {
      final userData = await dbHelper.query(
        'user',
        where: 'id = ?',
        whereArgs: [id],
      );

      setState(() {
        dados = userData;
      });

      _loadReviews(_periodoSelecionado);
      _loadUser();
      _loadStats();
    }
  }

  Future<void> _loadUser() async {
    if (userId != null) {
      final resultados = await dbHelper.query(
        'user',
        where: 'id = ?',
        whereArgs: [userId],
      );
      if (resultados.isNotEmpty) {
        setState(() {
          userData = resultados.first;
        });
      }
    }
  }

  Future<void> _loadStats() async {
    if (userId != null) {
      final result = await dbHelper.query(
        'user',
        where: 'id = ?',
        whereArgs: [userId],
      );

      if (result.isNotEmpty) {
        final user = result.first;
        setState(() {
          userStats = {
            'realizou': user['totalEstudadas'] ?? 0,
            'pulou': user['totalPuladas'] ?? 0,
            'memorizou': user['totalMemorizadas'] ?? 0,
          };
        });
      }
    }
  }

  Future<void> _loadReviews(String periodo) async {
    if (userId == null) return;
    setState(() {
      _periodoSelecionado = periodo;
      _loading = true;
    });

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
      _loading = false;
    });
  }

  void _onPeriodoChanged(String periodo) async {
    await _loadReviews(periodo);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFFF7EDE2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(36),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF78624D).withAlpha(20),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: const Offset(3, 3),
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

                        final modulos = await dbHelper.query(
                          'modulo',
                          where: 'idUsuario = ?',
                          whereArgs: [userId],
                        );

                        if (modulos.isEmpty) {
                          if (mounted) {
                            showDialog(
                              context: context,
                              builder: (context) => CustomMsgDialog(
                                title: 'Ops!',
                                content:
                                    'Você ainda não cadastrou nenhum módulo. Crie um módulo antes de adicionar revisões.',
                                ok: CustomOk(
                                  function: () => Navigator.pop(context),
                                ),
                              ),
                            );
                          }
                          return;
                        }

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
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        leftChevronIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 4, right: 2),
                          child: Icon(
                            Icons.arrow_left_rounded,
                            color: theme.tableCalendarColor,
                            size: 60,
                          ),
                        ),
                        rightChevronIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 4, right: 2),
                          child: Icon(
                            Icons.arrow_right_rounded,
                            color: theme.tableCalendarColor,
                            size: 60,
                          ),
                        ),
                        titleTextStyle: TextStyle(
                          fontFamily: 'CerebriSansPro',
                          color: theme.tableCalendarColor,
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
                        weekdayStyle: TextStyle(
                          fontFamily: 'CerebriSansPro',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: theme.tableCalendarColor,
                        ),
                        weekendStyle: TextStyle(
                          fontFamily: 'CerebriSansPro',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: theme.calendarFimSemanaColor,
                        ),
                        dowTextFormatter: (date, locale) {
                          String day = DateFormat.E(
                            locale,
                          ).format(date).toUpperCase();
                          if (day.endsWith('.')) {
                            day = day.substring(0, day.length - 1);
                          }
                          return day;
                        },
                      ),
                      calendarStyle: CalendarStyle(
                        cellPadding: const EdgeInsets.all(5),
                        tablePadding: const EdgeInsets.all(8),
                        weekendDecoration: BoxDecoration(
                          color: const Color(0xFFF2F2F2),
                          shape: BoxShape.circle,
                        ),
                        defaultTextStyle: const TextStyle(
                          fontFamily: 'CerebriSansPro',
                          color: Color(0xFF78624D),
                        ),
                        weekendTextStyle: const TextStyle(
                          fontFamily: 'CerebriSansPro',
                          color: Color(0xFF78624D),
                        ),
                        defaultDecoration: BoxDecoration(
                          color: const Color(0xFFF2F2F2),
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: theme.calendarDayColor,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: const BoxDecoration(
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

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 5,
                        decoration: BoxDecoration(
                          color: theme.cerebroLineColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset(
                        "assets/images/brain_icon_small.png",
                        height: 50,
                        color: theme.cerebroLineColor,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 5,
                        decoration: BoxDecoration(
                          color: theme.cerebroLineColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                FiltroPeriodo(
                  onPeriodoChanged: _onPeriodoChanged,
                  periodoAtual: _periodoSelecionado,
                ),
                const SizedBox(height: 10),
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
                        color: theme.tableCalendarColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      const SizedBox(height: 20),
                      ...reviews.map((t) {
                        final data =
                            DateTime.tryParse(t['dataRevisao'] ?? '') ??
                            DateTime.now();
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: CustomReviewCard(
                            materia: t['materiaNome'],
                            modulo: t['moduloNome'],
                            reviewName: t['topico'],
                            reviewDesc: '${t['descricao']}',
                            dataReview: data,
                            hasStudy: (String? selectedMood) async {
                              final tarefaId = t['id'];
                              if (userId == null || selectedMood == null)
                                return;

                              final tarefaData = await dbHelper.query(
                                'tarefa',
                                where: 'id = ?',
                                whereArgs: [tarefaId],
                              );
                              if (tarefaData.isEmpty) return;
                              final tarefa = tarefaData[0];

                              DateTime dataRevisao =
                                  DateTime.tryParse(
                                    tarefa['dataRevisao'] ?? '',
                                  ) ??
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

                              int nota = 3;
                              switch (selectedMood) {
                                case 'mal':
                                  nota = 1;
                                  break;
                                case 'ok':
                                  nota = 3;
                                  break;
                                case 'bem':
                                  nota = 5;
                                  break;
                              }

                              if (nota < 3) {
                                repeticoes = 0;
                                intervalo = 1;
                                easiness = (easiness - 0.2).clamp(1.3, 2.5);
                              } else {
                                repeticoes++;
                                if (repeticoes == 1)
                                  intervalo = 1;
                                else if (repeticoes == 2)
                                  intervalo = 3;
                                else
                                  intervalo = (intervalo * easiness).round();

                                easiness =
                                    easiness +
                                    0.1 -
                                    (5 - nota) * (0.08 + (5 - nota) * 0.02);
                                if (easiness < 1.3) easiness = 1.3;
                              }

                              bool memorizado =
                                  repeticoes >= 5 && selectedMood == 'bem';

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

                                final carteiraAtual = usuario['carteira'] ?? 0;
                                final bonus = 10;

                                await dbHelper.update(
                                  'user',
                                  {
                                    'carteira': carteiraAtual + bonus,
                                    'totalMemorizadas':
                                        (usuario['totalMemorizadas'] ?? 0) + 1,
                                    'totalEstudadas':
                                        (usuario['totalEstudadas'] ?? 0) + 1,
                                  },
                                  'id = ?',
                                  [userId],
                                );
                                if (coinNotifier != null) {
                                  coinNotifier.value = carteiraAtual + bonus;
                                }

                                if (mounted) {
                                  showDialog(
                                    context: context,
                                    builder: (dialogContext) => CustomMsgDialog(
                                      title: 'Concluído 🎉',
                                      content:
                                          'Você dominou "${tarefa['topico']}"! Esta revisão foi marcada como memorizada.',
                                      ok: CustomOk(
                                        function: () =>
                                            Navigator.pop(dialogContext),
                                      ),
                                    ),
                                  );
                                }

                                if (mounted) {
                                  _loadReviews(_periodoSelecionado);
                                  _loadStats();
                                }
                                return;
                              }

                              final proximaData = hoje.add(
                                Duration(days: intervalo),
                              );
                              int moedas = selectedMood == 'mal'
                                  ? 1
                                  : selectedMood == 'ok'
                                  ? 2
                                  : 3;

                              await dbHelper.update(
                                'user',
                                {
                                  'carteira':
                                      (usuario['carteira'] ?? 0) + moedas,
                                  'totalEstudadas':
                                      (usuario['totalEstudadas'] ?? 0) + 1,
                                },
                                'id = ?',
                                [userId],
                              );
                              if (coinNotifier != null) {
                                coinNotifier.value =
                                    (usuario['carteira'] ?? 0) + moedas;
                              }

                              await dbHelper.update(
                                'tarefa',
                                {
                                  'status': selectedMood,
                                  'dataRevisao': proximaData.toIso8601String(),
                                },
                                'id = ?',
                                [tarefaId],
                              );

                              await dbHelper.insert('review_stats', {
                                'idUsuario': tarefa['idUsuario'],
                                'idTarefa': tarefaId,
                                'status': selectedMood,
                                'data': hoje.toIso8601String(),
                                'intervalo': intervalo,
                                'easiness': easiness,
                                'repeticoes': repeticoes,
                              });

                              if (mounted) {
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) => CustomMsgDialog(
                                    title: 'Próxima Revisão',
                                    content:
                                        'A próxima revisão de "${tarefa['topico']}" será em ${DateFormat('dd/MM/yyyy').format(proximaData)}.',
                                    ok: CustomOk(
                                      function: () =>
                                          Navigator.pop(dialogContext),
                                    ),
                                  ),
                                );
                              }

                              if (mounted) {
                                _loadReviews(_periodoSelecionado);
                                _loadStats();
                              }
                            },
                            onPressed: () {
                              // ✅ CORREÇÃO: BottomSheet COLADO na navbar
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled:
                                    true, // ✅ Mantém o controle da altura
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return Container(
                                    // ✅ REMOVIDO: margin - Agora fica colado na navbar
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF7EDE2),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // ✅ Header do BottomSheet
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF7EDE2),
                                            borderRadius:
                                                const BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.more_vert,
                                                color: theme.tableCalendarColor,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                'Opções da Review',
                                                style: TextStyle(
                                                  fontFamily: 'CerebriSansPro',
                                                  color:
                                                      theme.tableCalendarColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // ✅ Opções
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
                                              builder: (context) =>
                                                  CustomEditForm(
                                                    dataReview:
                                                        DateTime.tryParse(
                                                          t['dataRevisao'] ??
                                                              '',
                                                        ) ??
                                                        DateTime.now(),
                                                    userId: userId!,
                                                    topico: t['topico'],
                                                    descricao: t['descricao'],
                                                    selectedModuleId:
                                                        t['idModulo'],
                                                    selectedSubjectId:
                                                        t['idMateria'],
                                                    tarefaId: t['id'],
                                                  ),
                                            ).then((updated) {
                                              if (updated == true) {
                                                _loadReviews(
                                                  _periodoSelecionado,
                                                );
                                              }
                                            });
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            LucideIcons.circleX,
                                            color: AppColors.coral,
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
                                            Navigator.pop(context);
                                            final confirm = await showDialog<bool>(
                                              context: context,
                                              builder:
                                                  (BuildContext dialogContext) {
                                                    return CustomMsgDialog(
                                                      title: 'Excluindo Review',
                                                      content:
                                                          "Deseja realmente deletar ${t['topico']}?",
                                                      ok: CustomOk(
                                                        function: () =>
                                                            Navigator.pop(
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
                                                _loadReviews(
                                                  _periodoSelecionado,
                                                );
                                              } catch (e) {
                                                if (mounted) {
                                                  showDialog<bool>(
                                                    context: context,
                                                    builder:
                                                        (
                                                          BuildContext
                                                          dialogContext,
                                                        ) {
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
                                            }
                                          },
                                        ),
                                        // ✅ ESPAÇO EXTRA para não ficar colado demais
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            function: () {},
                          ),
                        );
                      }).toList(),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
