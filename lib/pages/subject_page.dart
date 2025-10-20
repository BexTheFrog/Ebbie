import 'package:ebbie/services/database.dart';
import 'package:ebbie/services/user_service.dart';
import 'package:ebbie/widgets/custom_appbar_with_comeback.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_subject_header.dart';
import 'package:ebbie/widgets/card_grid_subject.dart';

class SubjectPage extends StatefulWidget {
  final int moduleId;
  final String moduleName;

  const SubjectPage({
    super.key,
    required this.moduleId,
    required this.moduleName,
  });

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  final dbHelper = DatabaseHelper();
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final id = await UserService.getUserId();
    if (mounted) {
      setState(() {
        userId = id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithComeback(),
      backgroundColor: const Color(0xFFFFF9E9),
      body: userId == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubjectHeader(title: widget.moduleName),
                  const SizedBox(height: 20),
                  CardGridPage(moduleId: widget.moduleId, userId: userId!),
                ],
              ),
            ),
    );
  }
}
