import 'package:ebbie/pages/subject_page.dart';
import 'package:ebbie/services/database.dart';
import 'package:ebbie/widgets/module_forms/custom_dialog_add_module.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

final dbHelper = DatabaseHelper();

class ModuleProfile extends StatefulWidget {
  final int userId;
  const ModuleProfile({super.key, required this.userId});

  @override
  State<ModuleProfile> createState() => _ModuleProfileState();
}

class _ModuleProfileState extends State<ModuleProfile> {
  List<Map<String, dynamic>> modules = [];

  @override
  void initState() {
    super.initState();
    _loadModules();
  }

  Future<void> _loadModules() async {
    final data = await dbHelper.query(
      'modulo',
      where: 'idUsuario = ?',
      whereArgs: [widget.userId],
    );
    setState(() {
      modules = data;
    });
  }

  Future<void> _addOrEditModule({Map<String, dynamic>? module}) async {
    // Abre o dialog e espera até fechar
    await showDialog(context: context, builder: (_) => CustomDialogAddModule());
    // Recarrega os módulos
    _loadModules();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0, bottom: 12),
          child: Text(
            "MEUS MÓDULOS",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFED6A5A),
              fontFamily: 'CerebriSansPro',
            ),
          ),
        ),
        SizedBox(
          height: 130,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Row(
              children: [
                const SizedBox(width: 8),
                ...modules.map((mod) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _buildModuleCard(
                      context,
                      title: mod['nome'],
                      description: 'Estudos do módulo',
                      onEdit: () => _addOrEditModule(module: mod),
                    ),
                  );
                }).toList(),
                _buildAddModuleCard(context),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModuleCard(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback onEdit,
  }) {
    return SizedBox(
      width: 200,
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
            Container(
              height: 50,
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
                        fontFamily: 'CerebriSansPro',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onEdit,
                    child: const Icon(
                      LucideIcons.squarePen,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF5D576B),
                  fontFamily: 'CerebriSansPro',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddModuleCard(BuildContext context) {
    return SizedBox(
      width: 200,
      child: GestureDetector(
        onTap: () => _addOrEditModule(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
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
                    fontFamily: 'CerebriSansPro',
                  ),
                ),
              ),
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
      ),
    );
  }
}
