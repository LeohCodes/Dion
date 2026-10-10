import 'package:flutter/material.dart';

class CriarEventoController {
  // Controladores de texto para capturar o que o usuário digita
  final tituloController = TextEditingController();
  final dataController = TextEditingController();
  final horarioController = TextEditingController();
  final localizacaoController = TextEditingController();
  final precoController = TextEditingController();
  final descricaoController = TextEditingController();
  final atracoesController = TextEditingController();

  // Lista de categorias para o Dropdown
  final List<String> categorias = [
    'Música',
    'Tecnologia',
    'Arte',
    'Esportes',
    'Gastronomia',
    'Outros'
  ];

  // Categoria selecionada
  String? categoriaSelecionada;

  // Lista de tags padrão simuladas
  List<String> getTagsDisponiveis() {
    return ['Rock', 'Geek', 'Pet-friendly', 'Festas', 'Ao Ar Livre'];
  }

  // Método para limpar a memória quando a tela for fechada
  void dispose() {
    tituloController.dispose();
    dataController.dispose();
    horarioController.dispose();
    localizacaoController.dispose();
    precoController.dispose();
    descricaoController.dispose();
    atracoesController.dispose();
  }

  // Função simulada para salvar o evento
  bool publicarEvento() {
    // Aqui entrará a lógica de validação e envio para a API/Banco de Dados
    return true; 
  }
}