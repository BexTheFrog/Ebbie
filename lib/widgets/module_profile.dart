import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/pages/subject_page.dart';
import 'package:ebbie/services/database.dart';
import 'package:ebbie/widgets/module_forms/custom_dialog_add_module.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

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
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => CustomDialogAddModule(module: module),
    );

    if (result != null) {
      if (module == null) {
        await dbHelper.insert('modulo', {
          'nome': result['nome'],
          'descricao': result['descricao'],
          'idUsuario': widget.userId,
        });
      } else {
        await dbHelper.update(
          'modulo',
          {'nome': result['nome'], 'descricao': result['descricao']},
          'id= ?',
          [module['id']],
        );
      }

      _loadModules(); // recarrega lista
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0, bottom: 12),
          child: Text(
            "MEUS MÓDULOS",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.profileColor,
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
              spacing: 10,
              children: [
                ...modules.map((mod) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _buildModuleCard(
                      context,
                      title: mod['nome'],
                      description: mod['descricao'],
                      onEdit: () => _addOrEditModule(module: mod),
                      moduleId: mod['id'],
                      onDelete: _loadModules,
                    ),
                  );
                }),
                _buildAddModuleCard(context),
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
    required int moduleId,
    required VoidCallback onDelete,
  }) {
    final theme = context.watch<ThemeController>();
    return SizedBox(
      width: 200,
      child: GestureDetector(
        onLongPress: () async {
          final confirm = await showDialog<bool>(
            context: context, // contexto do widget pai
            builder: (BuildContext dialogContext) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: AppColors.pastelBeige,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.profileColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Excluir $title?',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'CerebriSansPro',
                              fontWeight: FontWeight.bold,
                              color: AppColors.pastelYellow,
                            ),
                          ),
                          Expanded(child: SizedBox(width: 10)),
                          IconButton(
                            icon: Icon(
                              LucideIcons.squareX,
                              color: AppColors.pastelYellow,
                              size: 30,
                            ),
                            onPressed: () => Navigator.pop(dialogContext),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Deseja realmente excluir "$title"?',
                        style: const TextStyle(
                          color: AppColors.pastelYellow,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(width: 16),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              side: const BorderSide(
                                color: AppColors.pastelYellow,
                                width: 3,
                              ),
                            ),
                            onPressed: () => Navigator.pop(dialogContext, true),
                            child: const Text(
                              'Excluir',
                              style: TextStyle(
                                color: AppColors.pastelYellow,
                                fontFamily: 'CerebriSansPro',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );

          if (confirm == true) {
            await dbHelper.delete('modulo', 'id = ?', [moduleId]);
            onDelete(); // callback para recarregar
          }
        },

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  SubjectPage(moduleId: moduleId, moduleName: title),
            ),
          );
        },
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
                decoration: BoxDecoration(
                  color: theme.profileColor,
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
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: theme.dadosProfileColor,
                    fontFamily: 'CerebriSansPro',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddModuleCard(BuildContext context) {
    final theme = context.watch<ThemeController>();
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
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.appbarColor,
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
                  color: theme.profileColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
