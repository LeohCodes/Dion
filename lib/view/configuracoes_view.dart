import 'package:dion/view/enderecos_view.dart';
import 'package:dion/view/preferencias_view.dart';
import 'package:dion/view/sobre_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Para não esquecer, usar o comando no terminal: flutter pub add url_launcher

class ConfiguracoesView extends StatefulWidget {
  const ConfiguracoesView({super.key});

  @override
  State<ConfiguracoesView> createState() => _ConfiguracoesViewState();
}

class _ConfiguracoesViewState extends State<ConfiguracoesView> {
  // Função para abrir links externos (Central de Ajuda)
  Future<void> _abrirCentralDeAjuda() async {
    final Uri url = Uri.parse('https://youtu.be/dQw4w9WgXcQ');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível abrir o link da Central de Ajuda.')),
        );
      }
    }
  }

  // Modal de confirmação para Sair (Logout)
  void _confirmarSair() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Sair do Aplicativo'),
          content: const Text('Tem certeza que deseja encerrar sua sessão?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCELAR', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context); // Fecha o popup de confirmação
                if (mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context, 
                    'login', (route) => false); //Para remover as telas da memoria
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9C27B0),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('SAIR'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Faz o corpo (gradiente) ir até o topo, por trás do AppBar
      extendBodyBehindAppBar: true,

      // Cria um AppBar invisível, mas que vai renderizar a setinha de voltar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Fundo transparente
        elevation: 0, // Remove a sombra
        title: const Text(
          'Configurações',
          style: TextStyle(
            color: Color(0xFF1E1E24),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF1E1E24), // Cor da setinha de voltar
        ),
      ),

      // Fundo gradiente
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 227, 196, 245),
              Color.fromARGB(255, 248, 246, 249),
              Color.fromARGB(255, 251, 217, 247),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
              
                // --- Lista de Opções de Configuração ---
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildOptionTile(
                        icon: Icons.tune_rounded,
                        title: 'Preferências',
                        subtitle: 'Estilos, categorias e filtros',
                        onTap: () {
                          
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PreferenciasView()));
                        },
                      ),
                      _buildDivider(),
                      _buildOptionTile(
                        icon: Icons.location_on_outlined,
                        title: 'Endereços',
                        subtitle: 'Locais salvos para eventos e notificações',
                        onTap: () {

                          Navigator.push(context, MaterialPageRoute(builder: (context) => const EnderecosView()));
                        },
                      ),
                      _buildDivider(),
                      _buildOptionTile(
                        icon: Icons.help_outline_rounded,
                        title: 'Central de Ajuda',
                        subtitle: 'Dúvidas frequentes e suporte',
                        onTap: _abrirCentralDeAjuda,
                      ),
                      _buildDivider(),
                      _buildOptionTile(
                        icon: Icons.info_outline_rounded,
                        title: 'Sobre',
                        subtitle: 'Termos de uso, privacidade e versão',
                        onTap: () {
                        
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SobreView()));
                        },
                      ),
                      _buildDivider(),
                      _buildOptionTile(
                        icon: Icons.logout_rounded,
                        title: 'Sair',
                        titleColor: const Color(0xFFE5208C),
                        iconColor: const Color(0xFFE5208C),
                        showChevron: false,
                        onTap: _confirmarSair,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  // ==========================================
  // WIDGETS AUXILIARES E COMPONENTES DE UI
  // ==========================================
  
  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    Color titleColor = const Color(0xFF1E1E24),
    Color iconColor = const Color(0xFF8B5CF6),
    bool showChevron = true,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: titleColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
              ),
            )
          : null,
      trailing: showChevron
          ? const Icon(Icons.chevron_right_rounded, color: Color(0xFF9CA3AF))
          : null,
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
      color: Color(0xFFF3F4F6),
    );
  }
}