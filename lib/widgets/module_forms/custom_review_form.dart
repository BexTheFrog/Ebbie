import 'package:date_field/date_field.dart';
import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/services/database.dart';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_description.dart';
import 'package:ebbie/widgets/module_forms/custom_form_task.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class CustomDialogRevieweForm extends StatefulWidget {
  final int userId;
  final DateTime dataReview;

  const CustomDialogRevieweForm({
    super.key,
    required this.userId,
    required this.dataReview,
  });

  @override
  State<CustomDialogRevieweForm> createState() =>
      _CustomDialogRevieweFormState();
}

class _CustomDialogRevieweFormState extends State<CustomDialogRevieweForm> {
  final dbHelper = DatabaseHelper();
  final TextEditingController _topicoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  int? selectedModuleId;
  int? selectedSubjectId;

  DateTime? selectedDate;
  final DateTime _diaAtual = DateTime.now();

  List<Map<String, dynamic>> modules = [];
  List<Map<String, dynamic>> subjects = [];

  @override
  void initState() {
    super.initState();
    selectedDate = widget.dataReview;
    _loadModules();
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
    setState(() {
      modules = data;
    });
  }

  Future<void> _loadSubjects(int moduleId) async {
    final data = await dbHelper.query(
      'materia',
      where: 'moduloId = ? AND idUsuario = ?',
      whereArgs: [moduleId, widget.userId],
    );
    setState(() {
      subjects = data;
      selectedSubjectId = null;
    });
  }

  Future<bool> _saveReview() async {
    final topico = _topicoController.text.trim();
    final descricao = _descricaoController.text.trim();
    if (topico.isEmpty ||
        selectedModuleId == null ||
        selectedSubjectId == null ||
        descricao.isEmpty) {
      await showDialog(
        context: context,
        builder: (_) => CustomMsgDialog(
          title: "Campos vazios",
          content: "Preencha todos os campos antes de salvar.",
          ok: CustomOk(function: () => Navigator.pop(context)),
        ),
      );
      return false;
    }

    await dbHelper.insert('tarefa', {
      'idUsuario': widget.userId,
      'idModulo': selectedModuleId,
      'idMateria': selectedSubjectId,
      'topico': topico,
      'descricao': descricao,
      'dataRevisao': DateFormat('yyyy-MM-dd').format(selectedDate!),
      'status': 'pendente',
    });

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
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
                  color: theme.msgDialogColor,
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
                      'Adicionando Review',
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
                      disabledHint: Text(
                        'Você não tem módulos',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'CerebriSansPro',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      hint: Text(
                        'Selecione um módulo',
                        style: TextStyle(
                          color: theme.msgDialogColor,
                          fontFamily: 'CerebriSansPro',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: Icon(
                        LucideIcons.circleArrowDown,
                        color: theme.msgDialogColor,
                      ),
                      value: selectedModuleId,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 3, 36, 31),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: theme.msgDialogColor,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: theme.msgDialogColor,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: AppColors.pastelBeige,
                      ),
                      items: modules.map((m) {
                        return DropdownMenuItem<int>(
                          value: m['id'] as int,
                          child: Text(m['nome']),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedModuleId = val;
                          _loadSubjects(val!);
                        });
                      },
                    ),
                    const SizedBox(height: 12),

                    DropdownButtonFormField<int>(
                      disabledHint: Text(
                        'Selecione um módulo primeiro',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'CerebriSansPro',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      hint: Text(
                        'Selecione a matéria',
                        style: TextStyle(
                          color: AppColors.tealBlue,
                          fontFamily: 'CerebriSansPro',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: Icon(LucideIcons.circleArrowDown),
                      iconEnabledColor: AppColors.tealBlue,
                      iconDisabledColor: Colors.grey,
                      value: selectedSubjectId,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.tealBlue,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 3),
                          borderRadius: BorderRadius.circular(20),
                        ),

                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.tealBlue,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: AppColors.pastelBeige,
                      ),
                      items: subjects.map((s) {
                        return DropdownMenuItem<int>(
                          value: s['id'] as int,
                          child: Text(s['nome']),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedSubjectId = val;
                        });
                      },
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
                            firstDate: _diaAtual,
                            initialValue: selectedDate,
                            mode: DateTimeFieldPickerMode.date,
                            dateFormat: DateFormat('dd/MM/yyyy'),
                            decoration: const InputDecoration(
                              focusColor: AppColors.tealBlue,
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
                            onChanged: (date) => selectedDate = date,
                          ),
                        ),
                        const SizedBox(width: 12),
                        CustomOk(
                          function: () async {
                            final success = await _saveReview(); // await aqui
                            if (success) {
                              Navigator.pop(
                                context,
                                true,
                              ); // retorna true só se salvou
                            }
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
