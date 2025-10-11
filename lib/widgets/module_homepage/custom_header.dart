import 'package:ebbie/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarHeader extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime>? onMonthChanged;

  const CalendarHeader({
    super.key,
    required this.initialDate,
    this.onMonthChanged,
  });

  @override
  State<CalendarHeader> createState() => _CalendarHeaderState();
}

class _CalendarHeaderState extends State<CalendarHeader> {
  late DateTime _focusedDate;

  @override
  void initState() {
    super.initState();
    _focusedDate = widget.initialDate;
  }

  void _previousMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1);
    });
    widget.onMonthChanged?.call(_focusedDate);
  }

  void _nextMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1);
    });
    widget.onMonthChanged?.call(_focusedDate);
  }

  String _getFormattedTitle() {
    final now = DateTime.now();
    final monthName = DateFormat.MMMM('pt_BR').format(_focusedDate);

    if (_focusedDate.year != now.year) {
      return '${_capitalize(monthName)} ${_focusedDate.year}';
    }

    return _capitalize(monthName);
  }

  String _capitalize(String text) {
    return text.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _previousMonth,
          child: Padding(
            padding: const EdgeInsets.only(right: 12, bottom: 3),
            child: Icon(
              Icons.arrow_left_rounded,
              size: 60,
              color: AppColors.darkSlate,
            ),
          ),
        ),
        Text(
          _getFormattedTitle(),
          style: const TextStyle(
            fontFamily: 'CerebriSansPro',
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: AppColors.darkSlate,
          ),
        ),
        GestureDetector(
          onTap: _nextMonth,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 3),
            child: Icon(
              Icons.arrow_right_rounded,
              size: 60,
              color: AppColors.darkSlate,
            ),
          ),
        ),
      ],
    );
  }
}
