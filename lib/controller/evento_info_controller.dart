import 'package:flutter/material.dart'; // Certifique-se de ter um arquivo assets.dart com os caminhos corretos para os assets
// ==========================================
// MODELOS DE DADOS
// ==========================================

class AtracaoModel {
  final String nome;
  final String imagePath;

  AtracaoModel({required this.nome, required this.imagePath});
}

class EventoSemelhanteModel {
  final String titulo;
  final String data;
  final String imagePath;

  EventoSemelhanteModel({required this.titulo, required this.data, required this.imagePath});
}

class DetalheEventoModel {
  final String titulo;
  final String organizador;
  final String data;
  final String horario;
  final String localNome;
  final String localBairro;
  final String enderecoCompleto;
  final String descricao;
  final double precoMinimo;
  final String imagePath;
  final String mapImagePath;
  final List<String> tags;

  DetalheEventoModel({
    required this.titulo,
    required this.organizador,
    required this.data,
    required this.horario,
    required this.localNome,
    required this.localBairro,
    required this.enderecoCompleto,
    required this.descricao,
    required this.precoMinimo,
    required this.imagePath,
    required this.mapImagePath,
    required this.tags,
  });
}

// ==========================================
// CONTROLADOR
// ==========================================

class EventoInfoController {
  
  // Retorna as informações principais do evento selecionado
  DetalheEventoModel getDetalhesEvento() {
    return DetalheEventoModel(
      titulo: 'João Rock 2026',
      organizador: 'Banana Eventos',
      data: 'Ago 01, 2026',
      horario: '13:10 - 02:00',
      localNome: 'FEAPAM',
      localBairro: 'Jardim Jóquei Clube',
      enderecoCompleto: 'Av. Orestes Lopes de Camargo, 350\nJardim Jóquei Clube, Ribeirão Preto - SP',
      descricao: 'Livre pra curtir em um único dia a maior seleção da música nacional, esportes radicais e uma vibe que não tem igual.\n\nUm dia pra rasgar o roteiro, deixar rolar e conhecer o Brasil inteiro no mesmo lugar! Esse é o nosso hino: Mais que um festival, um destino.',
      precoMinimo: 200.00,
      imagePath: 'assets/joao_rock_header.png', // Substitir pelo asset do seu projeto
      mapImagePath: 'assets/mapa_feapam.png',   // Substitir pelo asset do seu projeto
      tags: ['Show', 'Rock'],
    );
  }

  // Retorna a lista de artistas/atrações
  List<AtracaoModel> getAtracoes() {
    return [
      AtracaoModel(nome: 'CPM 22', imagePath: 'assets/cpm22.png'),
      AtracaoModel(nome: 'Raimundos', imagePath: 'assets/raimundos.png'),
      AtracaoModel(nome: 'Ana Carolina', imagePath: 'assets/anacarolina.png'),
      AtracaoModel(nome: 'Lagum', imagePath: 'assets/lagum.png'),
    ];
  }

  // Retorna o histórico de eventos semelhantes
  List<EventoSemelhanteModel> getEventosSemelhantes() {
    return [
      EventoSemelhanteModel(
        titulo: 'Ribeirão Rock Series',
        data: 'Set 15, 2024',
        imagePath: 'assets/rock_series.png',
      ),
      EventoSemelhanteModel(
        titulo: 'Arena Blues Festival',
        data: 'Mar 22, 2024',
        imagePath: 'assets/arena_blues.png',
      ),
    ];
  }
}