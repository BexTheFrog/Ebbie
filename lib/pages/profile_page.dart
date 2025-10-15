import 'package:ebbie/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import '../widgets/module_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APPBAR
      appBar: const CustomAppBar(coinCount: 15),
      backgroundColor: const Color(0xFFF7EDE2),

      // BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                SizedBox(height: 50),
                _buildProfileContainer(context),
                // SizedBox(height: 30),
                // AchievementsProfile(), SE A BEATRIZ ALGUM DIA TOCAR NO PROJETO DE NOVO TA AQUI - Que gracinha esse Lucas
                SizedBox(height: 50),
                ModuleProfile(),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Container do perfil
  Widget _buildProfileContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          16,
        ), // 👈 bordas arredondadas em cima e embaixo
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
          _buildProfileHeader(context),
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

  /// Cabeçalho com barra colorida, avatar e botão editar
  Widget _buildProfileHeader(BuildContext context) {
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

  /// Nome do usuário
  Widget _buildUserName() {
    return const Text(
      "Eu",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: "CerebriSansPro",
        fontSize: 18,
        color: Color(0xFF5D576B),
      ),
    );
  }

  /// Linha separadora
  Widget _buildDivider() {
    return Container(height: 2, width: 350, color: const Color(0xFFF4F1BB));
  }

  /// Linha de estatísticas
  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat(
            "REALIZOU",
            "36",
            "REVISÕES",
            const Color(0xFFED6A5A),
            const Color(0xFF9BC1BC),
          ),
          _buildStat(
            "PULOU",
            "15",
            "REVISÕES",
            Colors.orange.shade700,
            const Color(0xFF9BC1BC),
          ),
          _buildStat(
            "MEMORIZOU",
            "6",
            "TÓPICOS",
            Colors.orange.shade700,
            const Color(0xFF9BC1BC),
          ),
        ],
      ),
    );
  }

  /// Widget de estatística individual
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
