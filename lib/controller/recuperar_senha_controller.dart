
import 'package:flutter/material.dart';

class RecuperarSenhaController extends ChangeNotifier {

  Future<bool> recuperarSenha(String email) async {
    // Por enquanto não temos API.
    // Futuramente a chamada para o backend ficará aqui.

    // print('Solicitação de recuperação para: $email');

    // Simulando que deu certo
    return true;
  }
  
}