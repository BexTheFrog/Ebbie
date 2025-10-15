import 'package:flutter/material.dart';

class DropdownModulos extends StatefulWidget {
  final List<String> modulos; // lista de módulos
  final Function(String?) onChanged;

  const DropdownModulos({
    super.key,
    required this.modulos,
    required this.onChanged,
  });

  @override
  State<DropdownModulos> createState() => _DropdownModulosState();
}

class _DropdownModulosState extends State<DropdownModulos> {
  String? selectedModulo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título
        Row(
          children: const [
            Icon(Icons.menu_book, color: Colors.blue),
            SizedBox(width: 8),
            Text(
              'Módulos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            value: selectedModulo,
            hint: const Text("Selecione um módulo"),
            underline: const SizedBox(), // remove a linha padrão
            items: widget.modulos.map((modulo) {
              return DropdownMenuItem<String>(
                value: modulo,
                child: Text(modulo),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedModulo = value;
              });
              widget.onChanged(value);
            },
          ),
        ),
      ],
    );
  }
}
