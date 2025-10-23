import 'package:ebbie/services/database.dart';
import 'package:ebbie/services/user_service.dart';
import 'package:ebbie/widgets/custom_appbar.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/module_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final dbHelper = DatabaseHelper();
  int? userId;
  Map<String, dynamic>? userData;
  Map<String, int>? userStats;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    userId = await UserService.getUserId();
    if (userId != null) {
      final resultados = await dbHelper.query(
        'user',
        where: 'id = ?',
        whereArgs: [userId],
      );
      if (resultados.isNotEmpty) {
        setState(() {
          userData = resultados.first; // pega o primeiro usuário
        });
        await _loadStats();
      }
    }
  }

  Future<void> _loadStats() async {
    if (userId != null) {
      final result = await dbHelper.query(
        'user',
        where: 'id = ?',
        whereArgs: [userId],
      );

      if (result.isNotEmpty) {
        final user = result.first;
        setState(() {
          userStats = {
            'realizou': user['totalEstudadas'] ?? 0,
            'pulou': user['totalPuladas'] ?? 0,
            'memorizou': user['totalMemorizadas'] ?? 0,
          };
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFFF7EDE2),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                const SizedBox(height: 50),
                _buildProfileContainer(),
                const SizedBox(height: 50),
                // Só exibe ModuleProfile quando userId estiver carregado
                if (userId != null) ModuleProfile(userId: userId!),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContainer() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFFFFCF4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 40),
          _buildUserName(),
          const SizedBox(height: 8),
          _buildDivider(),
          const SizedBox(height: 16),
          _buildStatsRow(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    final theme = context.watch<ThemeController>();
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: theme.profileColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
        ),
        Positioned(
          top: -35,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 223, 213, 213),
              border: Border.all(color: theme.profileColor, width: 10),
            ),
            child: const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/avatar.png"),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserName() {
    final theme = context.watch<ThemeController>();
    return Text(
      userData != null ? userData!['nome'] ?? 'Usuário' : 'Não encontrado',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: "CerebriSansPro",
        fontSize: 18,
        color: theme.dadosProfileColor,
      ),
    );
  }

  Widget _buildDivider() {
    final theme = context.watch<ThemeController>();
    return Container(height: 2, width: 350, color: theme.lineDividerColor);
  }

  Widget _buildStatsRow() {
    final theme = context.watch<ThemeController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat(
            "REALIZOU",
            userStats != null ? "${userStats!['realizou']}" : "0",
            "REVISÕES",
            theme.metaSelectProfileColor,
            theme.revisaoMetaProfileColor,
          ),
          _buildStat(
            "PULOU",
            userStats != null ? "${userStats!['pulou']}" : "0",
            "REVISÕES",
            theme.metasProfileColor,
            theme.revisaoMetaProfileColor,
          ),
          _buildStat(
            "MEMORIZOU",
            userStats != null ? "${userStats!['memorizou']}" : "0",
            "TÓPICOS",
            theme.metasProfileColor,
            theme.revisaoMetaProfileColor,
          ),
        ],
      ),
    );
  }

  Widget _buildStat(
    String title,
    String value,
    String subtitle,
    Color titleColor,
    Color subtitleColor,
  ) {
    final theme = context.watch<ThemeController>();
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: titleColor,
            fontSize: 12,
            fontFamily: 'CerebriSansPro',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: theme.dadosProfileColor,
            fontFamily: 'CerebriSansPro',
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: TextStyle(
            color: subtitleColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'CerebriSansPro',
          ),
        ),
      ],
    );
  }
}
