import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/widgets/custom_appbar.dart';
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
  DateTime _diaAtual = DateTime.now();
  DateTime? _diaSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(coinCount: 15),
      backgroundColor: const Color(0xFFF7EDE2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
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
                      locale: 'pt_BR',
                      focusedDay: _diaAtual,
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _diaSelecionado = selectedDay;
                        });
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
                          if (day.endsWith('.'))
                            day = day.substring(0, day.length - 1);
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_left_rounded,
                        size: 60,
                        color: AppColors.darkSlate,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "HOJE",
                        style: TextStyle(
                          fontFamily: 'CerebriSansPro',
                          fontSize: 35,
                          color: AppColors.darkSlate,
                          height: 1,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_right_rounded,
                        size: 60,
                        color: AppColors.darkSlate,
                      ),
                    ),
                  ],
                ),
                CustomReviewCard(),
                CustomReviewCard(),
                CustomReviewCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
