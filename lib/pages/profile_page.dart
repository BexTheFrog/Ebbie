import 'package:ebbie/services/database.dart';
import 'package:ebbie/services/user_service.dart';
import 'package:ebbie/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
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
      }
    }
  }

  Future<void> _loadStats() async {
    if (userId != null) {
      final stats = await dbHelper.getUserStats(userId!);
      setState(() {
        userStats = stats;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(coinCount: 15),
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
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Color(0xFFED6A5A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
        ),
        Positioned(
          top: -35,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromARGB(255, 223, 213, 213),
              border: Border.all(color: const Color(0xFFED6A5A), width: 10),
            ),
            child: const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/avatar.jpg"),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserName() {
    return Text(
      userData != null ? userData!['nome'] ?? 'Usuário' : 'Não encontrado',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: "CerebriSansPro",
        fontSize: 18,
        color: Color(0xFF5D576B),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 2, width: 350, color: const Color(0xFFF4F1BB));
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat(
            "REALIZOU",
            userStats != null ? "${userStats!['realizou']}" : "0",
            "REVISÕES",
            const Color(0xFFED6A5A),
            const Color(0xFF9BC1BC),
          ),
          _buildStat(
            "PULOU",
            userStats != null ? "${userStats!['pulou']}" : "0",
            "REVISÕES",
            Colors.orange.shade700,
            const Color(0xFF9BC1BC),
          ),
          _buildStat(
            "MEMORIZOU",
            userStats != null ? "${userStats!['memorizou']}" : "0",
            "TÓPICOS",
            Colors.orange.shade700,
            const Color(0xFF9BC1BC),
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
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
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
