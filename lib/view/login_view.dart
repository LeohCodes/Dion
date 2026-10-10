import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ctrl = GetIt.I.get<LoginController>();

  // Controlar e Validar os campos de texto
  final _formKey = GlobalKey<FormState>();

  //Controlar os campos de texto
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() => setState(() {}));
  }

  @override
  //Descarta os controladores quando o widget é removido da árvore de widgets
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Fundo em gradiente
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 227, 196, 245), //
              Color.fromARGB(
                255,
                248,
                246,
                249,
              ), // Tom quase branco do meio do gradiente
              Color.fromARGB(255, 251, 217, 247),
            ],
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 64),
                  // Logo central (esta temorariamente com o icone, mas futuramente será substituido pela logo do app)
                  Container(
                    padding: const EdgeInsets.all(24),
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
                    //
                    // LOGO AQUI
                    //
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
                        size: 80,
                        color: Colors.white,
                      ),
                    ), // como placeholder
                    //codigo da imagem do logo VVVV
                    //Image.asset('assets/logo_ingresso.png', height: 80),
                  ),

                  const SizedBox(height: 32),

                  // 3. Título RichText
                  Text.rich(
                    TextSpan(
                      text: 'Descubra seu ',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E1E24), // Texto escuro principal
                      ),
                      children: [
                        const TextSpan(
                          text: 'próximo rolê',
                          style: TextStyle(
                            color: Color(0xFFE5208C), // Rosa vibrante do Figma
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  // 4. Campos de preenchimento (TextFields)
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Digite seu e-mail',
                      labelText: 'E-mail',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Color(0xFF9C27B0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 213, 32, 230),
                          width: 2.0,
                        ),
                      ),

                      //Bordas de Erro para o campo de email
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 0, 81),
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 0, 81),
                          width: 2.0,
                        ),
                      ),
                    ),
                    //Validator para o campo de email
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor, digite seu e-mail';
                      }
                      //vadilar se o email é valido
                      final bool emailValido = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(value);
                      if (!emailValido) {
                        return 'Por favor, digite um e-mail válido';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 10),
                  //senha
                  TextFormField(
                    obscureText: ctrl.visibilidade, //Ocultar senha
                    decoration: InputDecoration(
                      labelText: 'Senha',
                    //Visualizar ou ocultar senha ()
                      suffixIcon: IconButton(
                        splashRadius: 20,
                        icon: Icon(
                            ctrl.visibilidade ? Icons.visibility : Icons.visibility_off,
                            size: 20, // 3. Diminui o tamanho do desenho do ícone (o padrão é 24)
                            color: Colors.grey, // (Opcional) Deixar cinza para ficar mais suave
                                   ),
                                  
                        onPressed: () {
                          ctrl.alterarVisibilitade();
                        },
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Color(0xFF9C27B0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 213, 32, 230),
                          width: 2.0,
                        ),
                      ),
                      //Bordas de Erro para o campo de senha
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 0, 81),
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 0, 81),
                          width: 2.0,
                        ),
                      ),
                    ),
                    //Validator para s Senha
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor, digite sua senha';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),

                  //recuperar senha
                  Align(
                    alignment: AlignmentGeometry.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'recuperar_senha');
                      },
                      child: Text('Esqueceu a senha?'),
                    ),
                  ),
                  const SizedBox(height: 5),

                  // 5. Card de ações (Botões entrar e criar conta)
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Botão: Entrar (Com gradiente)
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF9C27B0),
                                Color(0xFFE5208C),
                              ], // Roxo para Rosa
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // Validar Campos de texto
                              if (_formKey.currentState!.validate()) {
                                String emailDigitado = _emailController.text;
                                String senhaDigitada = _senhaController.text;
                                Navigator.pushNamed(context, 'home');
                                //
                                //Chamar Login_controler Aqui
                                //
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent, // Permite ver o gradiente do Container
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
                                  'Entrar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Botão: Criar conta (Outlined)
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'cadastro_usuario');
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: const BorderSide(
                                color: Color(0xFFD6D6D6),
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Criar conta',
                              style: TextStyle(
                                color: Color(0xFF1E1E24),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // 6. Rodapé
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'criar_evento'); // Futuramente editar
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Continuar como organizador',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Colors.blueGrey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
