import 'package:flutter/material.dart';

class CadastroUsuarioView extends StatefulWidget {
  const CadastroUsuarioView({super.key});

  @override
  State<CadastroUsuarioView> createState() => _CadastroUsuarioViewState();
}

class _CadastroUsuarioViewState extends State<CadastroUsuarioView> {

  // Controlar e Validar os campos de texto
  final _formKey = GlobalKey<FormState>();

  //Controlar os campos de texto
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  
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
      
      //fundo gradiente
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
             key: _formKey,
             child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                //  Logo central (esta temorariamente com o icone, mas futuramente será substituido pela logo do app)
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
                      colors: [Color(0xFF9C27B0), Color(0xFFE5208C)], // Roxo para Rosa
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
              // ... continuar aqui
               const SizedBox(height: 32),

                Text.rich(
                  TextSpan(
                    text: 'Crie sua conta: ',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E1E24), // Texto escuro principal
                    ),
                  ),
                ),

               const SizedBox(height: 16),

                // 4. Campos de preenchimento (TextFields)
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Color(0xFF9C27B0),
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 213, 32, 230),
                        width: 2.0,
                        )
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
                    final bool emailValido = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                    if (!emailValido) {
                      return 'Por favor, digite um e-mail válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                //senha
                TextFormField(
                  obscureText: true,//Ocultar senha
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                        color: Color(0xFF9C27B0)
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 213, 32, 230),
                        width: 2.0,
                        )
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
                  validator:(value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, digite sua senha';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                //Confirmar senha
                TextFormField(
                  obscureText: true,//Ocultar senha
                  decoration: InputDecoration(
                    labelText: 'Confirmar Senha',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                        color: Color(0xFF9C27B0)
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 213, 32, 230),
                        width: 2.0,
                        )
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
                  validator:(value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, digite sua senha';
                    }
                    return null;
                    //
                    //verificare se as senhas são iguais
                    //
                    if (value != _senhaController.text) {
                      return 'As senhas não coincidem';
                    }
                  },

                ),

                const SizedBox(height: 20),

                //  Card de ações (Botões entrar e criar conta)
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
                            colors: [Color(0xFF9C27B0), Color(0xFFE5208C)], // Roxo para Rosa
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Validar Campos de texto
                            if (_formKey.currentState!.validate()) {
                              String emailDigitado = _emailController.text;
                              String senhaDigitada = _senhaController.text;
                            Navigator.pushNamed(
                             context,'login'
                    );
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
                                'Criar Conta',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ]
                ),
              )
            ],
          ),
        ),
      ),
     ),
    ),
  );

  }
}