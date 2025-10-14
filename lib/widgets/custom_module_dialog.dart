import 'package:flutter/material.dart';

class CustomModuleDialog extends StatelessWidget {
  final String title;
  final String buttonText;
  final String? initialModuleName;
  final String? initialDescription;
  final Function(String, String)? onConfirm;

  const CustomModuleDialog({
    super.key,
    required this.title,
    required this.buttonText,
    this.initialModuleName,
    this.initialDescription,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final moduleController = TextEditingController(text: initialModuleName ?? '');
    final descriptionController = TextEditingController(text: initialDescription ?? '');

    return Dialog(
      backgroundColor: const Color(0xFFF7EDE2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Cabeçalho verde-azulado
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF9BC1B7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7EDE2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.close,
                        color: Color(0xFF9BC1B7),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Campo nome do módulo
                TextField(
                  controller: moduleController,
                  decoration: InputDecoration(
                    hintText: 'Módulo...',
                    hintStyle: const TextStyle(
                      color: Color(0xFF9BC1B7),
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color(0xFF9BC1B7),
                        width: 3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color(0xFF9BC1B7),
                        width: 3,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color(0xFF9BC1B7),
                        width: 3,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Campo descrição
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Descrição...',
                    hintStyle: const TextStyle(
                      color: Color(0xFF9BC1B7),
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFF9BC1B7),
                        width: 3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFF9BC1B7),
                        width: 3,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFF9BC1B7),
                        width: 3,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Botão Ok
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF9BC1B7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        color: Color(0xFF9BC1B7),
                        width: 3,
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (onConfirm != null) {
                      onConfirm!(moduleController.text, descriptionController.text);
                    }
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}