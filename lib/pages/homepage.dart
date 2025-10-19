import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/pages/revisionExpand.dart';
import 'package:ebbie/services/database.dart';
import 'package:ebbie/services/user_service.dart';
import 'package:ebbie/widgets/custom_appbar.dart';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:ebbie/widgets/module_forms/custom_review_form.dart';
import 'package:ebbie/widgets/module_homepage/custom_filter.dart';
import 'package:ebbie/widgets/module_homepage/custom_review_card.dart';
import 'package:flutter/material.dart';
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
  List<Map<String, dynamic>> reviews = []; // lista de reviews exibida

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    int? id = await UserService.getUserId();
    setState(() => userId = id);
    if (userId != null) _loadReviews(_periodoSelecionado);
  }

  Future<void> _loadReviews(String periodo) async {
    if (userId == null) return;
    setState(() => _periodoSelecionado = periodo);

    final db = await dbHelper.database;

    final hoje = DateTime.now();
    final formatador = DateFormat('yyyy-MM-dd');

    String sql = '''
      SELECT t.id, t.topico, t.descricao, t.dataRevisao,  t.status,
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
      reviews = result;
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
      appBar: const CustomAppBar(coinCount: 15),
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
                          _loadReviews(
                            _periodoSelecionado,
                          ); // recarrega as tarefas/reviews
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
                        materia: t['materiaNome'] ?? 'Sem matéria',
                        modulo: t['moduloNome'] ?? 'Sem módulo',
                        reviewName: t['topico'] ?? '',
                        reviewDesc: '${t['descricao']}',
                        dataReview: data,
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => CustomMsgDialog(
                              title: 'Excluindo Review',
                              content:
                                  "Deseja realmente deletar ${t['topico']}?",
                              ok: CustomOk(
                                function: () => Navigator.pop(context, true),
                              ),
                            ),
                          );

                          if (confirm == true) {
                            await dbHelper.delete('tarefa', 'id = ?', [
                              t['id'],
                            ]);
                            _loadReviews(
                              _periodoSelecionado,
                            ); // atualiza a lista
                          }
                        },
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Revisionexpand(
                                titulo: t['topico'],
                                modulo: t['moduloNome'],
                                secao: t['materiaNome'],
                                descricao: t['descricao'],
                                dataReview:
                                    DateTime.tryParse(t['dataRevisao'] ?? '') ??
                                    DateTime.now(),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
