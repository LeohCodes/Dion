import 'package:flutter/material.dart';

class ConfiguracoesView extends StatefulWidget {
  const ConfiguracoesView({super.key});

  @override
  State<ConfiguracoesView> createState() => _ConfiguracoesViewState();
}

class _ConfiguracoesViewState extends State<ConfiguracoesView> {
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
          //
          // Codigo da tela aqui!!!
          //
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text("Tela de configurações"),
              // ... continuar aqui
            ],
          ),
        ),
      ),
    );
  }
}