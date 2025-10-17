import 'package:date_field/date_field.dart';
import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/widgets/module_forms/custom_description.dart';
import 'package:ebbie/widgets/module_forms/custom_dropdown_module.dart';
import 'package:ebbie/widgets/module_forms/custom_form_task.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CustomDialogRevieweForm extends StatefulWidget {
  final DateTime dataReview;

  const CustomDialogRevieweForm({super.key, required this.dataReview});

  @override
  State<CustomDialogRevieweForm> createState() =>
      _CustomDialogRevieweFormState();
}

class _CustomDialogRevieweFormState extends State<CustomDialogRevieweForm> {
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
              // Cabeçalho com título e botão fechar
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Adicionando Review',
                      style: const TextStyle(
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
                    CustomFormFieldTask(hintText: "Tópico"),
                    const SizedBox(height: 12),
                    Row(
                      spacing: 30,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DropdownModulos(
                            hintText: 'Módulos',
                            lista: ['Item 1', 'Item 2', 'Item 3'],
                            onChanged: (val) {},
                          ),
                        ),
                        Expanded(
                          child: DropdownModulos(
                            hintText: 'Materias',
                            lista: ['Item 1', 'Item 2', 'Item 3'],
                            onChanged: (val) {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    CustomDescription(),
                    const SizedBox(height: 16),
                    Row(
                      spacing: 50,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.tealBlue,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 180,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            child: DateTimeFormField(
                              canClear: false,
                              decoration: const InputDecoration(
                                hintText: 'Data',
                                hintStyle: TextStyle(
                                  fontFamily: 'CerebriSansPro',
                                  color: AppColors.tealBlue,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 0,
                                ),
                                suffixIcon: Icon(
                                  LucideIcons.calendar,
                                  color: AppColors.tealBlue,
                                  size: 20,
                                ),
                                suffixIconConstraints: BoxConstraints(
                                  minHeight: 24,
                                  minWidth: 24,
                                ),
                              ),
                              style: const TextStyle(
                                color: AppColors
                                    .tealBlue, // cor da data selecionada
                                fontFamily: 'CerebriSansPro',
                                fontSize: 15,
                              ),

                              mode: DateTimeFieldPickerMode.date,
                              dateFormat: DateFormat('dd/MM/yyyy'),
                              initialValue: DateTime(
                                widget.dataReview.year,
                                widget.dataReview.month,
                                widget.dataReview.day,
                              ),
                              firstDate: DateTime.now(),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomOk(
                            function: () {
                              Navigator.pop(context);
                            },
                          ),
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
