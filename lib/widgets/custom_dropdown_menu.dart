import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu({super.key});

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String? selectedValue;

  final List<String> items = [
    'Opção 1',
    'Opção 2',
    'Opção 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF9BC1BB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF9BC1BC),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          //=== DROPDOW MENU
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue,
                hint: const Text(
                  'Filtro',
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(Icons.filter_list, color: Colors.white),
                dropdownColor: const Color(0xFF9BC1BB),
                style: const TextStyle(color: Colors.white),
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),

          //== BOTAO X
          if (selectedValue != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedValue = null;
                });
              },
              child: const Icon(Icons.clear, color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }
}
