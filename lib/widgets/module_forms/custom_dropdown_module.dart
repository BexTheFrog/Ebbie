import 'package:ebbie/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.tealBlue, width: 3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            icon: Icon(LucideIcons.circleArrowDown, color: AppColors.tealBlue),
            dropdownColor: AppColors.pastelBeige,
            borderRadius: BorderRadius.circular(12),
            isExpanded: true,
            value: selectedItem,
            hint: Text(
              widget.hintText,
              style: TextStyle(
                fontFamily: 'CerebriSansPro',
                color: AppColors.tealBlue,
              ),
            ),
            underline: const SizedBox(), // remove a linha padrão
            items: widget.lista.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    color: AppColors.tealBlue,
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
