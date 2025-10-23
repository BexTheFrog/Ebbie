import 'package:ebbie/widgets/custom_appbar_no_icon.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  // Lista de integrantes
  final List<Map<String, String>> members = const [
    {
      'name': 'Beatriz',
      'role': 'Desenvolvedora Flutter',
      'image': 'https://avatars.githubusercontent.com/u/105830447?v=4',
      'github': 'https://github.com/BexTheFrog',
    },
    {
      'name': 'Lucas',
      'role': 'UI/UX Designer',
      'image': 'https://avatars.githubusercontent.com/u/182137149?v=4',
      'github': 'https://github.com/lcsvaa',
    },
    {
      'name': 'Ryan',
      'role': 'Backend Developer',
      'image': 'https://avatars.githubusercontent.com/u/182137086?v=4',
      'github': 'https://github.com/Ryanslx',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    return Scaffold(
      appBar: CustomAppbarNoIcon(segment: 'Sobre Nós'),
      backgroundColor: const Color(0xFFF7EDE2),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Descrição do projeto
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.aboutPageColor, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                'Este aplicativo foi criado por Beatriz, Lucas e Ryan como projeto integrador do curso de Informática para Internet do Senac Lapa Tito, representando a aplicação prática dos conhecimentos adquiridos durante o o módulo de Desenvolvimento Mobile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.btnAboutPageColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Lista de membros
            Expanded(
              child: ListView.separated(
                itemCount: members.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) =>
                    _buildMemberCard(context, members[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberCard(BuildContext context, Map<String, String> member) {
    final theme = context.watch<ThemeController>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.aboutPageColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Avatar com NetworkImage
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(member['image']!),
            ),
            const SizedBox(width: 12),
            // Nome e função
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member['name']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: theme.btnAboutPageColor,
                    ),
                  ),
                  Text(
                    member['role']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.aboutPageColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Botão GitHub com ícone do GitHub
            GestureDetector(
              onTap: () => _launchGithubUrl(context, member['github']!),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.btnAboutPageColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.code, color: Colors.white, size: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchGithubUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      _showErrorSnackbar(context);
    }
  }

  void _showErrorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Não foi possível abrir o link')),
    );
  }
}
