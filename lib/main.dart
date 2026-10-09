import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:dion/view/cadastro_usuario_view.dart';
import 'package:dion/view/configuracoes_view.dart';
import 'package:dion/view/login_view.dart';
import 'package:dion/view/perfil_view.dart';
import 'package:dion/view/recuperar_senha_view.dart';
import 'package:dion/view/sobre_view.dart';
import 'package:dion/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'controller/login_controller.dart';

final g = GetIt.instance;

void main(){
  g.registerSingleton<LoginController>(LoginController());
  runApp(
    DevicePreview(
      builder: (context) => const MainApp()
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dion',

      //
      //ROTAS
      //
      initialRoute: 'login',
      routes: {
        'cadastro_usuario': (context) => const CadastroUsuarioView(),
        'login': (context) => const LoginView(),
        'perfil': (context) => const  PerfilView(),
        'recuperar_senha': (context) => const RecuperarSenhaView(),
        'configuracoes': (context) => const ConfiguracoesView(),
        'sobre': (context) => const SobreView(),
        'home': (context) => const HomeView(),
      },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => LoginView(),
        );
      },
    );
  }
}