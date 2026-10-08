
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {

  bool visibilidade = true;

  void alterarVisibilitade(){
    visibilidade =  !visibilidade;
    notifyListeners();
  }
  
}