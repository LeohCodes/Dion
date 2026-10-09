import 'package:flutter/material.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Faz o corpo (gradiente) ir até o topo, por trás do AppBar
      extendBodyBehindAppBar: true,

      // Cria um AppBar invisível, mas que vai renderizar a setinha de voltar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Fundo transparente
        elevation: 0, // Remove a sombra
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
            child: Column(
              children: [
                const SizedBox(height: 12),

                // --- Avatar com Borda Gradiente e Badge ---
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 54,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage('https://picsum.photos/300'),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFF8B5CF6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // --- Nome e @Username ---
                const Text(
                  'João Silva',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '@joaosilva',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 12),

                // --- Badge Premium ---
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E8FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Color(0xFF8B5CF6), size: 14),
                      SizedBox(width: 6),
                      Text(
                        'Premium Member',
                        style: TextStyle(
                          color: Color(0xFF8B5CF6),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // --- Botão Configurações ---
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, 'configuracoes');
                  },
                  icon: const Icon(Icons.settings, color: Color(0xFF64748B), size: 18),
                  label: const Text(
                    'Configurações',
                    style: TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.8),
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                const SizedBox(height: 24),

                // --- Grid de Atividades (Eventos e Conexões) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          value: '12',
                          label: 'Eventos Famosos',
                          color: const Color(0xFF8B5CF6),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoCard(
                          value: '45',
                          label: 'Conexões Feitas',
                          color: const Color(0xFFEC4899),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- Seção: Meus Interesses ---
                _buildSectionHeader('Meus Interesses'),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildInterestChip(label: 'Rock'),
                      _buildInterestChip(label: 'Geek', isSelected: true),
                      _buildInterestChip(label: 'Pet-friendly'),
                      _buildInterestChip(label: 'Festas'),
                      _buildInterestChip(label: 'Ao Ar Livre', isHighlight: true),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.8),
                            border: Border.all(color: Colors.grey.shade400),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, size: 20, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- Seção: Cupons de Desconto ---
                _buildSectionHeader('Cupons de Desconto'),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildCouponCard(
                        title: '20% OFF Liquid Nightlife',
                        subtitle: 'Válido até 30 Nov',
                        icon: Icons.confirmation_number_outlined,
                        iconBgColor: const Color(0xFFF3E8FF),
                        iconColor: const Color(0xFF8B5CF6),
                        btnColor: const Color(0xFF8B5CF6),
                      ),
                      const SizedBox(height: 12),
                      _buildCouponCard(
                        title: 'R\$50 BÔNUS VIP',
                        subtitle: 'Primeira Compra',
                        icon: Icons.card_giftcard,
                        iconBgColor: const Color(0xFFFCE7F3),
                        iconColor: const Color(0xFFEC4899),
                        btnColor: const Color(0xFFEC4899),
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

  // --- Widgets Auxiliares ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String value, required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestChip({required String label, bool isSelected = false, bool isHighlight = false}) {
    Color bgColor = Colors.white.withValues(alpha: 0.9);
    Color textColor = const Color(0xFF475569);
    BorderSide border = BorderSide(color: Colors.grey.shade300);

    if (isSelected) {
      bgColor = const Color(0xFFF3E8FF);
      textColor = const Color(0xFF8B5CF6);
      border = const BorderSide(color: Colors.transparent);
    } else if (isHighlight) {
      bgColor = const Color(0xFFFCE7F3);
      textColor = const Color(0xFFEC4899);
      border = const BorderSide(color: Colors.transparent);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.fromBorderSide(border),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildCouponCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required Color btnColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: btnColor,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'USAR',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}