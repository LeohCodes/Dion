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

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 227, 196, 245), // Tom quase branco do topo
              Color.fromARGB(255, 248, 246, 249), // Tom quase branco do topo
              Color.fromARGB(255, 251, 217, 247), // Rosa/Roxo muito claro da base
            ],
        ),
        ),
        child: SafeArea(
        child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: []),
        ),
      ),
      ),
      );
  }
}