import 'package:flutter/material.dart';

class RecuperarSenhaView extends StatefulWidget {
  const RecuperarSenhaView({super.key});

  @override
  State<RecuperarSenhaView> createState() => _RecuperarSenhaViewState();
}

class _RecuperarSenhaViewState extends State<RecuperarSenhaView> {
  @override
  Widget build(BuildContext context) {
return Scaffold(
      // Fundo em gradiente base
      body: Container(
        width: double.infinity, // Garante que o fundo ocupe toda a largura
        height: double.infinity, // Garante que o fundo ocupe toda a altura
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 227, 196, 245), 
              Color.fromARGB(255, 248, 246, 249), // Tom quase branco do meio
              Color.fromARGB(255, 251, 217, 247), 
            ],
          ),
        ),
        child: SafeArea(
          // Codigo da tela aqui
          child: Column(
            children: [
              // Substituir esta Column e adicionar o conteúdo da nova tela
            ],
          ),
        ),
      ),
    );
  }
}