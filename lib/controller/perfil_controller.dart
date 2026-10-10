import 'package:flutter/material.dart';

// ==========================================
// MODELOS DE DADOS
// ==========================================

class UsuarioModel {
  String nome;
  final String email;
  final String username;
  final String imagePath;
  final int eventosFamosos;
  final int conexoesFeitas;

  UsuarioModel({
    required this.nome,
    required this.email,
    required this.username,
    required this.imagePath,
    required this.eventosFamosos,
    required this.conexoesFeitas,
  });
}

class CupomModel {
  final String titulo;
  final String subtitulo;
  final IconData icone;
  final Color iconBgColor;
  final Color iconColor;
  final Color btnColor;

  CupomModel({
    required this.titulo,
    required this.subtitulo,
    required this.icone,
    required this.iconBgColor,
    required this.iconColor,
    required this.btnColor,
  });
}

// ==========================================
// CONTROLADOR (Com padrão Singleton aplicado)
// ==========================================

class PerfilController {
  // 1. Cria uma instância única e secreta na memória do aplicativo
  static final PerfilController _instancia = PerfilController._interno();

  // 2. Sempre que alguma tela "chamar" o PerfilController(), ele devolve a mesma memória salva
  factory PerfilController() {
    return _instancia;
  }

  // 3. Construtor interno para a primeira vez que o app rodar
  PerfilController._interno();


  // Simulação dos dados do usuário logado (Agora isso fica salvo na memória global!)
  UsuarioModel usuarioAtual = UsuarioModel(
    nome: 'João Silva',
    email: 'joao.silva@email.com',
    username: '@joaosilva',
    imagePath: 'https://picsum.photos/300', 
    eventosFamosos: 12,
    conexoesFeitas: 45,
  );

  // Validação do novo nome (mínimo de 3 caracteres)
  String? validarNome(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'O nome não pode estar vazio.';
    }
    if (valor.trim().length < 3) {
      return 'O nome deve ter pelo menos 3 caracteres.';
    }
    return null;
  }

  // Função para salvar o nome
  void salvarNome(String novoNome) {
    usuarioAtual.nome = novoNome;
  }

  // Dados dos Interesses
  List<String> getInteresses() {
    return ['Rock', 'Geek', 'Pet-friendly', 'Festas', 'Ao Ar Livre'];
  }

  // Dados dos Cupons 
  List<CupomModel> getCupons() {
    return [
      CupomModel(
        titulo: '20% OFF Liquid Nightlife',
        subtitulo: 'Válido até 30 Nov',
        icone: Icons.confirmation_number_outlined,
        iconBgColor: const Color(0xFFF3E8FF),
        iconColor: const Color(0xFF8B5CF6),
        btnColor: const Color(0xFF8B5CF6),
      ),
      CupomModel(
        titulo: 'R\$50 BÔNUS VIP',
        subtitulo: 'Primeira Compra',
        icone: Icons.card_giftcard,
        iconBgColor: const Color(0xFFFCE7F3),
        iconColor: const Color(0xFFEC4899),
        btnColor: const Color(0xFFEC4899),
      ),
    ];
  }
}