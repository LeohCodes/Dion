import 'package:flutter/material.dart';
import 'package:dion/controller/perfil_controller.dart'; // Ajuste o caminho se necessário
import 'package:dion/view/home_view.dart'; // Importação para a navegação voltar para a home

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  // Instância do Controller
  final PerfilController _controller = PerfilController();
  
  // Controle da Barra de Navegação (Perfil é o índice 3)
  int _selectedIndex = 3;

  // Variáveis para o Modo de Edição
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicia o campo de texto com o nome atual do usuário do controller
    _nomeController.text = _controller.usuarioAtual.nome;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  // Função que ativa ou desativa o modo de edição
  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // Se cancelou, restaura o nome original no campo de texto
        _nomeController.text = _controller.usuarioAtual.nome; 
      }
    });
  }

  // Função que valida e salva as alterações
  void _salvarAlteracoes() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _controller.salvarNome(_nomeController.text);
        _isEditing = false;
      });
      // Mostra um aviso verde na tela de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Perfil atualizado com sucesso!'),
          backgroundColor: Color(0xFF8B5CF6),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Buscando dados do controller para renderizar
    final usuario = _controller.usuarioAtual;
    final interesses = _controller.getInteresses();
    final cupons = _controller.getCupons();

    return Scaffold(
      extendBodyBehindAppBar: true,

      // =========================================================
      // BARRA DE NAVEGAÇÃO INFERIOR
      // =========================================================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (index == 0) {
              // Navega de volta para a Home ao clicar em Início
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeView()),
              );
            }
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF9C27B0), // Roxo do Dion
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number_outlined), label: 'Ingressos'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),

      // =========================================================
      // APP BAR (Ícones do topo)
      // =========================================================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF1E1E24),
        ),
      ),

      // =========================================================
      // CORPO (GRADIENTE E CONTEÚDO)
      // =========================================================
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

                // BORDA GRADIENTE NO AVATAR
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
                        child: CircleAvatar(
                          radius: 54,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(usuario.imagePath), //Depois isso será mudado, com o usuário podendo enviar imagens ou termos pequenos icones
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

                // NOME E @USERNAME
                Text(
                  usuario.nome,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  usuario.username,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 12),

                // BADGE PREMIUM
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

                // BOTÕES
                //CONFIGURACOES (AJUSTES)
                //EDITAR PERFIL
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      // Botão Configurações
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, 'configuracoes');
                          },
                          icon: const Icon(Icons.settings, color: Color(0xFF64748B), size: 18),
                          label: const Text(
                            'Ajustes', // Simplificado para caber melhor na Row
                            style: TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white.withValues(alpha: 0.8), 
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12), // Espaço entre os botões
                      // Botão Editar/Cancelar
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _toggleEditMode,
                          icon: Icon(_isEditing ? Icons.close : Icons.edit, color: const Color(0xFF64748B), size: 18),
                          label: Text(
                            _isEditing ? 'Cancelar' : 'Editar',
                            style: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white.withValues(alpha: 0.8), 
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // =========================================================
                // LÓGICA IF/ELSE PARA EXIBIR MODO DE EDIÇÃO OU VISUALIZAÇÃO
                // =========================================================
                if (_isEditing)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: _buildEditForm(usuario.email),
                  )
                else
                  _buildProfileContent(usuario, interesses, cupons),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================
  // WIDGET: MODO DE EDIÇÃO (Formulário)
  // ==========================================
  Widget _buildEditForm(String emailUsuario) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Editar Informações', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E1E24))),
          const SizedBox(height: 16),
          
          // Campo E-mail (Apenas Visualização)
          const Text('E-mail (Não editável)', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: emailUsuario,
            enabled: false, 
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 16),

          // Campo Nome (Editável e com Validação)
          const Text('Nome Completo', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          TextFormField(
            controller: _nomeController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF8B5CF6)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Color(0xFFD6D6D6)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Color(0xFF8B5CF6), width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
            ),
            validator: _controller.validarNome,
          ),
          const SizedBox(height: 32),

          // Botão Salvar
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _salvarAlteracoes,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFF8B5CF6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Salvar Alterações', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ==========================================
  // WIDGET: MODO DE VISUALIZAÇÃO ORIGINAL
  // ==========================================
  Widget _buildProfileContent(UsuarioModel usuario, List<String> interesses, List<CupomModel> cupons) {
    return Column(
      children: [
        // --- Grid de Atividades (Eventos e Conexões) ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  value: usuario.eventosFamosos.toString(),
                  label: 'Eventos Famosos',
                  color: const Color(0xFF8B5CF6),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoCard(
                  value: usuario.conexoesFeitas.toString(),
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
               ...interesses.map((interesse) {
                bool isFeatured = interesse == 'Geek';
                bool isHighlight = interesse == 'Ao Ar Livre';
                return _buildInterestChip(label: interesse, isSelected: isFeatured, isHighlight: isHighlight);
              }).toList(),
              // Botão Adicionar (Mais)
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
            children: cupons.map((cupom) {
              return Column(
                children: [
                  _buildCouponCard(cupom),
                  const SizedBox(height: 12),
                ],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  // ==========================================
  // WIDGETS AUXILIARES E COMPONENTES DE UI
  // ==========================================

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

  Widget _buildCouponCard(CupomModel cupom) {
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
              color: cupom.iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(cupom.icone, color: cupom.iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cupom.titulo,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  cupom.subtitulo,
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
              backgroundColor: cupom.btnColor,
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