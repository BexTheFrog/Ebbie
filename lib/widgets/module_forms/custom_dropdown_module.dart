import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class DropdownModulos extends StatefulWidget {
  final List<String> lista; // lista de módulos
  final Function(String?) onChanged;
  final String hintText;

  const DropdownModulos({
    super.key,
    required this.hintText,
    required this.lista,
    required this.onChanged,
  });

  @override
  State<DropdownModulos> createState() => _DropdownModulosState();
}

class _DropdownModulosState extends State<DropdownModulos> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: theme.formReviewColor, width: 3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            icon: Icon(LucideIcons.circleArrowDown, color: theme.formReviewColor),
            dropdownColor: AppColors.pastelBeige,
            borderRadius: BorderRadius.circular(12),
            isExpanded: true,
            value: selectedItem,
            hint: Text(
              widget.hintText,
              style: TextStyle(
                fontFamily: 'CerebriSansPro',
                color: theme.formReviewColor,
              ),
            ),
            underline: const SizedBox(), // remove a linha padrão
            items: widget.lista.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    color: theme.formReviewColor,
                    fontFamily: 'CerebriSansPro',
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedItem = value;
              });
              widget.onChanged(value);
            },
          ),
        ),
      ],
    );
  }
}
