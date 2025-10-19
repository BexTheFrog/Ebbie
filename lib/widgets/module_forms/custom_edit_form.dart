import 'package:date_field/date_field.dart';
import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/services/database.dart';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_description.dart';
import 'package:ebbie/widgets/module_forms/custom_form_task.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CustomEditForm extends StatefulWidget {
  final int tarefaId;
  final int userId;
  final DateTime dataReview;
  final String topico;
  final String descricao;
  final int selectedModuleId;
  final int selectedSubjectId;

  const CustomEditForm({
    super.key,
    required this.tarefaId,
    required this.userId,
    required this.dataReview,
    required this.topico,
    required this.descricao,
    required this.selectedModuleId,
    required this.selectedSubjectId,
  });

  @override
  State<CustomEditForm> createState() => _CustomEditFormState();
}

class _CustomEditFormState extends State<CustomEditForm> {
  final dbHelper = DatabaseHelper();
  late TextEditingController _topicoController;
  late TextEditingController _descricaoController;

  late int selectedModuleId;
  late int selectedSubjectId;
  late DateTime selectedDate;
  final DateTime _diaAtual = DateTime.now();

  List<Map<String, dynamic>> modules = [];
  List<Map<String, dynamic>> subjects = [];

  @override
  void initState() {
    super.initState();
    _topicoController = TextEditingController(text: widget.topico);
    _descricaoController = TextEditingController(text: widget.descricao);
    selectedModuleId = widget.selectedModuleId ?? modules.first['id'];
    selectedSubjectId = widget.selectedSubjectId ?? subjects.first['id'];
    selectedDate = widget.dataReview;
    _loadModules();
    _loadSubjects(selectedModuleId);
  }

  @override
  void dispose() {
    _topicoController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  Future<void> _loadModules() async {
    final data = await dbHelper.query(
      'modulo',
      where: 'idUsuario = ?',
      whereArgs: [widget.userId],
    );
    setState(() => modules = data);
  }

  Future<void> _loadSubjects(int moduleId) async {
    final data = await dbHelper.query(
      'materia',
      where: 'moduloId = ? AND idUsuario = ?',
      whereArgs: [moduleId, widget.userId],
    );
    setState(() => subjects = data);
  }

  Future<void> _saveReview() async {
    await dbHelper.update(
      'tarefa',
      {
        'idModulo': selectedModuleId,
        'idMateria': selectedSubjectId,
        'topico': _topicoController.text.trim(),
        'descricao': _descricaoController.text.trim(),
        'dataRevisao': DateFormat('yyyy-MM-dd').format(selectedDate),
      },
      'id = ?',
      [widget.tarefaId],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFF7EDE2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Cabeçalho
              Container(
                decoration: BoxDecoration(
                  color: AppColors.tealBlue,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Editando Review',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'CerebriSansPro',
                        fontWeight: FontWeight.bold,
                        color: AppColors.pastelYellow,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        LucideIcons.squareX,
                        color: AppColors.pastelYellow,
                        size: 30,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    CustomFormFieldTask(
                      hintText: "Tópico",
                      controller: _topicoController,
                    ),
                    const SizedBox(height: 12),
                    // Dropdown Módulos
                    DropdownButtonFormField<int>(
                      value: selectedModuleId,
                      items: modules
                          .map(
                            (m) => DropdownMenuItem<int>(
                              value: m['id'] as int,
                              child: Text(m['nome']),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedModuleId = val!;
                          _loadSubjects(val);
                        });
                      },
                      decoration: InputDecoration(
                        label: Text(
                          'Módulo',
                          style: TextStyle(
                            color: AppColors.tealBlue,
                            fontFamily: 'CerebriSansPro',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.tealBlue,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.tealBlue,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.tealBlue,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Dropdown Matérias
                    DropdownButtonFormField<int>(
                      value: selectedSubjectId,
                      items: subjects
                          .map(
                            (s) => DropdownMenuItem<int>(
                              value: s['id'] as int,
                              child: Text(s['nome']),
                            ),
                          )
                          .toList(),
                      onChanged: (val) =>
                          setState(() => selectedSubjectId = val!),
                      decoration: InputDecoration(
                        label: Text(
                          'Matéria',
                          style: TextStyle(
                            color: AppColors.tealBlue,
                            fontFamily: 'CerebriSansPro',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.tealBlue,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.tealBlue,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.tealBlue,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomDescription(controller: _descricaoController),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DateTimeFormField(
                            style: TextStyle(
                              color: AppColors.tealBlue,
                              fontFamily: 'CerebriSansPro',
                            ),
                            canClear: false,
                            initialValue: selectedDate,
                            mode: DateTimeFieldPickerMode.date,
                            dateFormat: DateFormat('dd/MM/yyyy'),
                            onChanged: (date) => selectedDate = date!,
                            decoration: InputDecoration(
                              focusColor: AppColors.tealBlue,
                              suffixIcon: Icon(LucideIcons.calendar),
                              suffixIconColor: AppColors.tealBlue,
                              labelText: 'Data da revisão',
                              labelStyle: TextStyle(
                                fontFamily: 'CerebriSansPro',
                                color: AppColors.tealBlue,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.tealBlue,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.tealBlue,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),
                        CustomOk(
                          function: () async {
                            await _saveReview();
                            Navigator.pop(
                              context,
                              true,
                            ); // retorna true se salvou
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
