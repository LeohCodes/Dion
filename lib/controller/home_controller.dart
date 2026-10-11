import 'package:flutter/material.dart';

// Modelo de dados para um Evento
class EventModel {
  final String title;
  final String date;
  final String price;
  final String location;
  final String badgeText;
  final List<String> tags;
  final bool isFavorite;
  final String imagePath; // Caminho para a imagem (ex: 'assets/joao_rock.png')

  EventModel({
    required this.title,
    required this.date,
    required this.price,
    required this.location,
    required this.badgeText,
    required this.tags,
    this.isFavorite = false,
    required this.imagePath,
  });
}

class HomeController {
  // Lista de eventos em destaque simulada (No futuro virá de uma API/Banco de Dados)
  List<EventModel> getFeaturedEvents() {
    return [
      EventModel(
        title: 'João Rock 2026',
        date: 'Hoje, 13:10',
        price: 'A partir de R\$ 200',
        location: 'Parque Permanente de Exposições',
        badgeText: 'Em alta',
        tags: ['Festival', 'Rock'],
        imagePath: 'assets/joao_rock.png', 
      ),
      EventModel(
        title: 'Baile da Favorita',
        date: 'Sáb, 22:00',
        price: 'A partir de R\$ 150',
        location: 'Espaço Sul',
        badgeText: 'Novidade',
        tags: ['Funk', 'Festa'],
        imagePath: 'assets/baile_favorita.png',
      ),
       EventModel(
        title: 'Stand Up Comedy - Especial',
        date: 'Sex, 20:30',
        price: 'A partir de R\$ 80',
        location: 'Theatro Pedro II',
        badgeText: 'Últimos',
        tags: ['Comédia', 'Teatro'],
        imagePath: 'assets/stand_up.png',
      ),
    ];
  }

  // Lista de eventos próximos simulada
  List<EventModel> getUpcomingEvents() {
    return [
      EventModel(
        title: 'Vivo Música em Ribeirão Preto',
        date: 'AMANHÃ',
        price: 'Gratuito',
        location: 'Parque Dr. Luis Carlos Raya',
        badgeText: '', 
        tags: ['Ao ar livre', 'Pet-friendly'],
        imagePath: 'assets/vivo_musica.png',
      ),
      EventModel(
        title: 'Anime Con 2026',
        date: '21 DE JUL',
        price: 'A partir de R\$ 65',
        location: 'Club Jerome',
        badgeText: '',
        tags: ['Geek', 'K-pop', 'Animes'],
        imagePath: 'assets/anime_con.png',
      ),
    ];
  }

   // Lista de eventos favoritos simulada
  List<EventModel> getFavoriteEvents() {
    return [
      EventModel(
        title: 'Iron Maiden',
        date: 'Turnê Mundial',
        price: 'A partir de R\$ 125',
        location: 'Arena Eurobike',
        badgeText: 'Favorito',
        isFavorite: true,
        tags: ['Show', 'Rock'],
        imagePath: 'assets/evento/IronMaiden.jpg',
      ),
       EventModel(
        title: 'Vintage Culture',
        date: 'Agenda',
        price: 'A partir de R\$ 180',
        location: 'Taipei',
        badgeText: 'Favorito',
        isFavorite: true,
        tags: ['DJ Set', 'Eletrônica'],
        imagePath: 'assets/vintage.png',
      ),
    ];
  }
}