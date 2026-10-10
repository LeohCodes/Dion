import 'package:flutter/material.dart';
import 'package:dion/controller/home_controller.dart'; 
// 1. IMPORTANTE: Importe a tela de destino (ajuste o caminho se necessário)
import 'package:dion/view/evento_info_view.dart'; 

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Instanciamos o Controller aqui
  final HomeController _controller = HomeController();
  
  // Controle de qual aba está selecionada na Barra de Navegação
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Buscamos as listas do Controller para renderizar na tela
    final featuredEvents = _controller.getFeaturedEvents();
    final upcomingEvents = _controller.getUpcomingEvents();
    final favoriteEvents = _controller.getFavoriteEvents();

    return Scaffold(
      backgroundColor: Colors.white,
      
      // =========================================================
      //  BARRA DE NAVEGAÇÃO INFERIOR (BOTTOM NAVIGATION BAR)
      // =========================================================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            // [SUBSTITUIR] adicionar a navegação para outras telas
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF9C27B0), // Roxo do Dion
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number_outlined), label: 'Ingressos'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
      
      body: SafeArea(
        // LISTVIEW PRINCIPAL DA TELA
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          children: [
            // 1. BARRA DE PESQUISA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5), // Cinza bem clarinho
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Encontre a sua próxima noite...',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // 2. SEÇÃO: EVENTOS EM DESTAQUE (Scroll Horizontal)
            const _SectionTitle(title: 'Eventos em Destaque'),
            const SizedBox(height: 16),
            SizedBox(
              height: 320, 
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: featuredEvents.length, // Dinâmico com base no Controller
                itemBuilder: (context, index) {
                  final event = featuredEvents[index];
                  
                  // ENVOLVEMOS O CARD COM GESTURE DETECTOR
                  return GestureDetector(
                    onTap: () {
                      // NAVEGAÇÃO PARA A TELA DE DETALHES
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EventoInfoView(),
                        ),
                      );
                    },
                    child: _FeaturedEventCard(
                      title: event.title,
                      date: event.date,
                      price: event.price,
                      badgeText: event.badgeText,
                      tags: event.tags,
                      isFavoriteCard: event.isFavorite,
                      imagePath: event.imagePath,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),

            // 3. SEÇÃO: EVENTOS PRÓXIMOS (Lista Vertical)
            const _SectionTitle(title: 'Eventos Próximos', actionText: 'Ver todos'),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: upcomingEvents.length, // Dinâmico com base no Controller
              itemBuilder: (context, index) {
                final event = upcomingEvents[index];

                // NAVEGAÇÃO
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EventoInfoView()),
                    );
                  },
                  child: _UpcomingEventCard(
                    title: event.title,
                    dateInfo: event.date,
                    location: event.location,
                    tags: event.tags,
                    imagePath: event.imagePath,
                  ),
                );
              },
            ),
            const SizedBox(height: 32),

            // 4. SEÇÃO: SUAS ATRAÇÕES FAVORITAS (Scroll Horizontal)
            const _SectionTitle(title: 'Suas atrações favoritas', actionText: 'Ver todas'),
            const SizedBox(height: 16),
            SizedBox(
              height: 320,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: favoriteEvents.length, // Dinâmico com base no Controller
                itemBuilder: (context, index) {
                  final event = favoriteEvents[index];

                  // NAVEGAÇÃO
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EventoInfoView()),
                      );
                    },
                    child: _FeaturedEventCard(
                      title: event.title,
                      date: event.date,
                      price: event.price,
                      badgeText: event.badgeText,
                      isFavoriteCard: event.isFavorite,
                      tags: event.tags,
                      imagePath: event.imagePath,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// WIDGETS AUXILIARES
// ============================================================================

/// Título das seções (Ex: "Eventos em Destaque")
class _SectionTitle extends StatelessWidget {
  final String title;
  final String? actionText;

  const _SectionTitle({required this.title, this.actionText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E1E24)),
          ),
          if (actionText != null)
            TextButton(
              onPressed: () {
                // [SUBSTITUIR] Ação de ver todos
              },
              child: Text(
                actionText!,
                style: const TextStyle(color: Color(0xFF9C27B0), fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}

/// Card de Eventos em Destaque e Favoritos (Horizontal)
class _FeaturedEventCard extends StatelessWidget {
  final String title;
  final String date;
  final String price;
  final String badgeText;
  final List<String> tags;
  final bool isFavoriteCard;
  final String imagePath; // Novo campo para receber do Controller

  const _FeaturedEventCard({
    required this.title,
    required this.date,
    required this.price,
    required this.badgeText,
    required this.tags,
    this.isFavoriteCard = false,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: 16.0, bottom: 8.0, top: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Atenção: com o Flutter mais novo use withOpacity no lugar de withValues(alpha: ...) se der erro
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Metade superior: Imagem e Tag (Tamanho Fixo)
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: Container(
                  height: 120, 
                  width: double.infinity,
                  color: Colors.grey[300],
                  // Se as imagens existirem na sua pasta assets, você pode descomentar a linha abaixo:
                  // child: Image.asset(imagePath, fit: BoxFit.cover),
                  child: Center(child: Text(imagePath, style: const TextStyle(color: Colors.grey, fontSize: 10))),
                ),
              ),
              if (badgeText.isNotEmpty) // Só desenha a tag se tiver texto
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isFavoriteCard ? Icons.favorite_border : Icons.local_fire_department,
                          size: 14,
                          color: const Color(0xFFE5208C),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          badgeText,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          
          // Metade inferior: Informações (Tamanho Flexível com Expanded)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title, 
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 2, 
                        overflow: TextOverflow.ellipsis, 
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap( 
                        spacing: 6,
                        runSpacing: 6,
                        children: tags.map((tag) => _buildTag(tag)).toList(),
                      ),
                    ],
                  ),
                  
                  // Bloco Inferior 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          color: Color(0xFF9C27B0),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF9C27B0).withOpacity(0.1),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(Icons.arrow_forward, size: 16, color: Color(0xFF9C27B0)),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// Card de Eventos Próximos (Vertical com imagem circular)
class _UpcomingEventCard extends StatelessWidget {
  final String title;
  final String dateInfo;
  final String location;
  final List<String> tags;
  final String imagePath; // Novo campo para receber do Controller

  const _UpcomingEventCard({
    required this.title,
    required this.dateInfo,
    required this.location,
    required this.tags,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem Circular à esquerda
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Container(
              width: 80,
              height: 80,
              color: Colors.grey[300], 
              // Descomente quando tiver as imagens:
              // child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 16),
          // Conteúdo à direita
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateInfo,
                      style: const TextStyle(color: Color(0xFF9C27B0), fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    const Icon(Icons.favorite_border, size: 20, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: tags.map((tag) {
                    bool isPink = tag == 'Pet-friendly' || tag == 'Geek'; 
                    return _buildTag(
                      tag,
                      bgColor: isPink ? const Color(0xFFE5208C).withOpacity(0.1) : null,
                      textColor: isPink ? const Color(0xFFE5208C) : null,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Função utilitária para desenhar as tags
Widget _buildTag(String text, {Color? bgColor, Color? textColor}) {
  return Container(
    margin: const EdgeInsets.only(right: 6),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: bgColor ?? const Color(0xFFF3E5F5), 
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: textColor ?? const Color(0xFF9C27B0),
      ),
    ),
  );
}