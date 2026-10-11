import 'package:flutter/material.dart';

class SobreView extends StatefulWidget {
  const SobreView({super.key});

  @override
  State<SobreView> createState() => _SobreViewState();
}

class _SobreViewState extends State<SobreView> {
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
          'Sobre',
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                const SizedBox(height: 12),

                // LOGO
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color(0xFF9C27B0),
                        Color(0xFFE5208C),
                      ], // Roxo para Rosa
                    ).createShader(bounds),
                    blendMode: BlendMode.srcIn,
                    child: const Icon(
                      Icons.wine_bar,
                      size: 64, 
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // NOME DO PROJETO
                const Text(
                  'Dion',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E1E24),
                  ),
                ),
                
                const SizedBox(height: 28),

                // OBJETIVO
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _buildGradientIcon(Icons.stars_rounded),
                          const SizedBox(width: 10),
                          const Text(
                            'Nosso Objetivo',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E1E24),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'O aplicativo foi desenvolvido com a missão de facilitar a localização, descoberta e divulgação dos melhores eventos, festas, shows e encontros culturais na cidade de Ribeirão Preto e toda a região.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4B5563),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // DEVS
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _buildGradientIcon(Icons.code_rounded),
                          const SizedBox(width: 10),
                          const Text(
                            'Desenvolvedores',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E1E24),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildDeveloperTile(
                        nome: 'Jessica Bianchi',
                        funcao: 'Desenvolvimento & UI/UX & Backend',
                      ),
                      const Divider(height: 24, thickness: 0.8, color: Color(0xFFE5E7EB)),
                      _buildDeveloperTile(
                        nome: 'Leonardo Araujo',
                        funcao: 'Desenvolvimento & UI/UX & Backend',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // VERSÃO (NO RODAPÉ)
                const Text(
                  'Versão 1.0.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
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

  //icones
  Widget _buildGradientIcon(IconData icon, {double size = 22}) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Color(0xFF9C27B0), // Roxo
          Color(0xFFE5208C), // Rosa
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: Icon(icon, color: Colors.white, size: size),
    );
  }

  // para devs
  Widget _buildDeveloperTile({required String nome, required String funcao}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF9C27B0).withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: _buildGradientIcon(Icons.person_outline_rounded, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nome,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E24),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              funcao,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ],
    );
  }
}