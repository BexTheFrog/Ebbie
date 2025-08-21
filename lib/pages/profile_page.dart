import 'package:flutter/material.dart';


import '../widgets/module_intropage/module_profile.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    ),
  );
}

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF9E9),

      // APP BAR
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          backgroundColor: Color(0xFF5D576B),
          centerTitle: true,
          title: Image.asset(
            'assets/images/logo.png',
            height: 50,
          ),
        ),
      ),

      // BODY PRINCIPAL COM SCROLL
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: 50),

                // CONTAINER DO PERFIL
                _buildProfileContainer(context),

                SizedBox(height: 30),

                // TÍTULO MÓDULOS
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'MEUS MÓDULOS',
                    style: TextStyle(
                      color: Color(0xFFED6A5A),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),

                SizedBox(height: 12),

                // LISTA DE MÓDULOS + BOTÃO ADICIONAR
                _buildModulesSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Widget que monta o container do perfil com avatar, nome e estatísticas
  Widget _buildProfileContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Color(0xFFFFFCF4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // BARRA COLORIDA TOPO + AVATAR + ÍCONE EDITAR
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Barra colorida topo
              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Color(0xFFED6A5A),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
              ),

              // Avatar circular com borda
              Positioned(
                top: -35,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xFFED6A5A),
                      width: 10,
                    ),
                  ),
                  child: Semantics(
                    label: 'User avatar',
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/avatar.png"),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),

              // Ícone de editar perfil clicável
              Positioned(
                right: 12,
                top: 20,
                child: InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Editar perfil clicado!'),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.edit_square,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 40),

          // Nome do usuário
          Text(
            "USER NAME",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF5D576B),
            ),
          ),

          SizedBox(height: 8),

          // Linha separadora
          Container(
            height: 2,
            width: 350,
            color: Color.fromARGB(255, 255, 255, 255),
          ),

          SizedBox(height: 16),

          // Estatísticas do usuário (realizou, pulou, memorizou)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat(
                  "REALIZOU",
                  "36",
                  "REVISÕES",
                  Color(0xFFED6A5A),
                  Color(0xFF9BC1BC),
                ),
                _buildStat(
                  "PULOU",
                  "15",
                  "REVISÕES",
                  Colors.orange.shade700,
                  Color(0xFF9BC1BC),
                ),
                _buildStat(
                  "MEMORIZOU",
                  "6",
                  "TÓPICOS",
                  Colors.orange.shade700,
                  Color(0xFF9BC1BC),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Widget que monta cada estatística
  static Widget _buildStat(
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
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 2),
        Text(
          subtitle,
          style: TextStyle(
            color: subtitleColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// Widget que monta a seção de módulos com módulos listados e botão de adicionar
  Widget _buildModulesSection(BuildContext context) {
    return ModuleProfile();
        
  }
}
