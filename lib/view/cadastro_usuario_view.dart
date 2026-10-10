import 'package:flutter/material.dart';

class CadastroUsuarioView extends StatefulWidget {
  const CadastroUsuarioView({super.key});

  @override
  State<CadastroUsuarioView> createState() => _CadastroUsuarioViewState();
}

class _CadastroUsuarioViewState extends State<CadastroUsuarioView> {
  // Controlar e Validar os campos de texto
  final _formKey = GlobalKey<FormState>();

  // Controladores dos campos de texto
  final _nomeController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  // Variáveis de Estado para a lógica dinâmica da tela
  bool _isOrganizador = false;
  bool _isArtistaIndependente = false;
  bool _ocultarSenha = true;

  @override
  void dispose() {
    _nomeController.dispose();
    _cnpjController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF8F9FA),
      
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E24)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      
      // ==========================================
      // CORREÇÃO: Removemos o preenchimento automático do scroll no topo
      // ==========================================
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true, // Isso faz o gradiente encostar na borda física da tela
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER COM EFEITO DE FUNDO
              Stack(
                alignment: Alignment.center,
                children: [
                  // Fundo gradiente 
                  Container(
                    height: 280,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromARGB(255, 227, 196, 245),
                          Color.fromARGB(255, 251, 217, 247),
                          Color(0xFFF8F9FA),
                        ],
                      ),
                    ),
                  ),
                  
                  // SafeArea protegendo apenas a Logo e Textos
                  SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          // LOGO
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                Color(0xFF9C27B0),
                                Color(0xFFE5208C),
                              ], 
                            ).createShader(bounds),
                            blendMode: BlendMode.srcIn,
                            child: const Icon(
                              Icons.wine_bar,
                              size: 80,
                              color: Colors.white,
                            ),
                          ), 
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Crie sua conta',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E1E24),
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                ],
              ),

              // FORMULÁRIO E ABAS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      
                      // 1. CHAVEADOR (TOGGLE) CLIENTE / ORGANIZADOR
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _isOrganizador = false),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: !_isOrganizador ? Colors.white : Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: !_isOrganizador
                                        ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)]
                                        : [],
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Sou Cliente',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: !_isOrganizador ? const Color(0xFF8A2BE2) : Colors.blueGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _isOrganizador = true),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _isOrganizador ? Colors.white : Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: _isOrganizador
                                        ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)]
                                        : [],
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Sou Organizador',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: _isOrganizador ? const Color(0xFF8A2BE2) : Colors.blueGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // CAMPO: NOME OU RAZÃO SOCIAL
                      _buildLabel(_isOrganizador ? 'Razão Social' : 'Nome Completo'),
                      TextFormField(
                        controller: _nomeController,
                        decoration: _buildInputDecoration(
                          hintText: _isOrganizador ? 'Razão social da empresa' : 'Seu nome',
                          icon: Icons.person_outline,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Por favor, preencha este campo.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // CAMPO DINÂMICO: CNPJ E CHECKBOX
                      if (_isOrganizador) ...[
                        _buildLabel('CNPJ'),
                        TextFormField(
                          controller: _cnpjController,
                          keyboardType: TextInputType.number,
                          decoration: _buildInputDecoration(
                            hintText: '00.000.000/0000-00',
                            icon: Icons.store_mall_directory_outlined,
                          ),
                          validator: (value) {
                            if (!_isArtistaIndependente && (value == null || value.trim().isEmpty)) {
                              return 'CNPJ é obrigatório para organizadores.';
                            }
                            return null;
                          },
                        ),
                        
                        Row(
                          children: [
                            Checkbox(
                              value: _isArtistaIndependente,
                              activeColor: const Color(0xFF8A2BE2),
                              onChanged: (bool? value) {
                                setState(() {
                                  _isArtistaIndependente = value ?? false;
                                });
                              },
                            ),
                            const Text(
                              'Sou um artista independente',
                              style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],

                      // CAMPO: E-MAIL
                      _buildLabel('E-mail'),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _buildInputDecoration(
                          hintText: 'seu@email.com',
                          icon: Icons.email_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Por favor, digite seu e-mail';
                          }
                          final bool emailValido = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                          if (!emailValido) {
                            return 'Por favor, digite um e-mail válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // CAMPO: SENHA
                      _buildLabel('Senha'),
                      TextFormField(
                        controller: _senhaController,
                        obscureText: _ocultarSenha,
                        decoration: InputDecoration(
                          hintText: '••••••••',
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.transparent,
                          prefixIcon: const Icon(Icons.lock_outline, color: Colors.blueGrey),
                          suffixIcon: IconButton(
                            splashRadius: 20,
                            icon: Icon(
                              _ocultarSenha ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              size: 20,
                              color: Colors.blueGrey,
                            ),
                            onPressed: () {
                              setState(() {
                                _ocultarSenha = !_ocultarSenha;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Color(0xFF9C27B0), width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.red, width: 1.5),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.red, width: 2.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, digite uma senha.';
                          }
                          if (value.length < 8) {
                            return 'A senha deve ter pelo menos 8 caracteres.';
                          }
                          if (!RegExp(r'[A-Z]').hasMatch(value)) {
                            return 'Adicione pelo menos uma letra maiúscula.';
                          }
                          if (!RegExp(r'[a-z]').hasMatch(value)) {
                            return 'Adicione pelo menos uma letra minúscula.';
                          }
                          if (!RegExp(r'[!@#\$&*~_.-]').hasMatch(value)) {
                            return 'Adicione um caractere especial (ex: @, #, !).';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),

                      // BOTÃO DE CADASTRAR
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF9C27B0), Color(0xFFE5208C)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFE5208C).withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            )
                          ]
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print("Organizador: $_isOrganizador");
                              print("Independente: $_isArtistaIndependente");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Cadastrar',
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // RODAPÉ DE LOGIN
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'login');
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'Já tem uma conta? ',
                              style: const TextStyle(color: Colors.blueGrey, fontSize: 14),
                              children: [
                                TextSpan(
                                  text: 'Entrar',
                                  style: const TextStyle(
                                    color: Color(0xFF8A2BE2),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // FUNÇÕES AUXILIARES DE DESIGN
  // ==========================================

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF4A4A4A),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({required String hintText, required IconData icon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.transparent,
      prefixIcon: Icon(icon, color: Colors.blueGrey),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Color(0xFF9C27B0), width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
    );
  }
}