import 'package:flutter/material.dart';

class ModuleProfile extends StatelessWidget {
  const ModuleProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título
        const Padding(
          padding: EdgeInsets.only(left: 8.0, bottom: 12),
          child: Text(
            "MEUS MÓDULOS",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFED6A5A),
            ),
          ),
        ),

        // Scroll horizontal de módulos
        SizedBox(
          height: 130, // altura fixa pros cards ficarem alinhados
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 8),
                _buildModuleCard(
                  title: "Desenvolvimento Web",
                  description: "Técnico em desenvolvimento Web no SENAC",
                ),
                const SizedBox(width: 12),
                _buildModuleCard(
                  title: "ENEM 2025",
                  description: "Estudos vestibular ENEM 2025",
                ),
                const SizedBox(width: 12),
                _buildModuleCard(
                  title: "Francês",
                  description: "Estudos independentes de francês",
                ),
                const SizedBox(width: 12),
                _buildAddModuleCard(),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Card de módulo padrão
  Widget _buildModuleCard({
    required String title,
    required String description,
  }) {
    return SizedBox(
      width: 200, // mesma largura para todos os cards
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFFFDF9),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho colorido
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFED6A5A),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.edit,
                    size: 16,
                    color: Colors.white,
                  )
                ],
              ),
            ),

            // Conteúdo
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF5D576B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Card para adicionar módulo
  Widget _buildAddModuleCard() {
    return SizedBox(
      width: 200, // mesma largura
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFE0E0E0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            // Cabeçalho colorido
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFED6A5A),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: const Text(
                "ADICIONAR CURSO",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),

            // Ícone "+"
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Icon(
                Icons.add_circle_outline,
                size: 40,
                color: Colors.red.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
