import 'package:ebbie/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

class CalendarExample extends StatefulWidget {
  @override
  _CalendarExampleState createState() => _CalendarExampleState();
}

class _CalendarExampleState extends State<CalendarExample> {
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          setState(() => _currentDate = date);
        },
        daysTextStyle: TextStyle(
          fontFamily: 'CerebriSansPro',
          color: Color(0xFF78624D),
        ),
        weekdayTextStyle: TextStyle(fontFamily: 'CerebriSansPro'),
        weekendTextStyle: TextStyle(
          color: AppColors.coral,
          fontFamily: 'CerebriSansPro',
        ),

        weekFormat: false,
        height: 420.0,
        selectedDayButtonColor: AppColors.tealBlue,
        selectedDateTime: _currentDate,
        minSelectedDate: _currentDate,
        selectedDayBorderColor: AppColors.tealBlue,
        daysHaveCircularBorder: true,
        daysBorderRadius: BorderRadius.all(Radius.circular(-2)),
        showOnlyCurrentMonthDate: true,
        headerTextStyle: TextStyle(
          fontFamily: 'CerebriSansPro',
          color: AppColors.darkSlate,
          fontSize: 36,
        ),
        rightButtonIcon: Icon(
          Icons.arrow_circle_right_rounded,
          weight: 6,
          size: 36,
          color: AppColors.darkSlate,
        ),
        leftButtonIcon: Icon(
          Icons.arrow_circle_left_rounded,
          weight: 6,
          size: 36,
          color: AppColors.darkSlate,
        ),
      ),
    );
  }
}
