import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Controle de qual aba está selecionada na Barra de Navegação
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number_outlined), label: 'Ingressos'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
      
      // =========================================================

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
              height: 320, // Altura fixa para o ListView horizontal funcionar
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: 3, // [SUBSTITUIR] Pelo tamanho da sua lista do banco
                itemBuilder: (context, index) {
                  return const _FeaturedEventCard(
                    title: 'João Rock 2026',
                    date: 'Hoje, 13:10',
                    price: 'A partir de R\$ 200',
                    badgeText: 'Em alta',
                    tags: ['Festival', 'Rock'],
                    // [SUBSTITUIR] Passar o caminho da imagem aqui: imagePath: 'assets/joao_rock.png'
                  );
                },
              ),
            ),
            const SizedBox(height: 32),

            // 3. SEÇÃO: EVENTOS PRÓXIMOS (Lista Vertical)
            const _SectionTitle(title: 'Eventos Próximos', actionText: 'Ver todos'),
            const SizedBox(height: 16),
            // Usamos shrinkWrap: true e NeverScrollableScrollPhysics para que 
            // essa lista acompanhe o scroll do ListView principal da tela
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2, // [SUBSTITUIR] Pelo tamanho da lista
              itemBuilder: (context, index) {
                return const _UpcomingEventCard(
                  title: 'Vivo Música em Ribeirão Preto',
                  dateInfo: 'AMANHÃ',
                  location: 'Parque Dr. Luis Carlos Raya',
                  tags: ['Ao ar livre', 'Pet-friendly'],
                  // [SUBSTITUIR] imagePath: 'assets/vivo_musica.png'
                );
              },
            ),
            const SizedBox(height: 32),

            // 4. SEÇÃO: SUAS ATRAÇÕES FAVORITAS (Scroll Horizontal)
            const _SectionTitle(title: 'Suas atrações favoritas', actionText: 'Ver todas'),
            const SizedBox(height: 16),
            SizedBox(
              height: 290,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return const _FeaturedEventCard(
                    title: 'Iron Maiden',
                    date: 'Turnê Mundial',
                    price: 'A partir de R\$ 125',
                    badgeText: 'Favorito',
                    isFavoriteCard: true,
                    tags: ['Show', 'Rock'],
                    // [SUBSTITUIR] imagePath: 'assets/iron_maiden.png'
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
// WIDGETS AUXILIARES (MOVER CADA UM PARA UM ARQUIVO SEPARADO DEPOIS)!
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

  const _FeaturedEventCard({
    required this.title,
    required this.date,
    required this.price,
    required this.badgeText,
    required this.tags,
    this.isFavoriteCard = false,
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
            color: Colors.black.withOpacity(0.05),
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
                  height: 120, // Reduzi levemente a imagem para dar mais espaço ao texto
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Center(child: Text('Imagem do Evento', style: TextStyle(color: Colors.grey))),
                ),
              ),
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
              // Reduzi o padding de 16 para 12 para ganhar espaço extra
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // O spaceBetween empurra a Row do preço pro final do card!
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bloco Superior (Título, Data e Tags)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title, 
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 2, // Garante que o título não passe de 2 linhas
                        overflow: TextOverflow.ellipsis, // Coloca "..." se for muito grande
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
                      // Tags
                      Wrap( // Mudei de Row para Wrap, assim se as tags forem grandes elas quebram de linha sem dar erro
                        spacing: 6,
                        runSpacing: 6,
                        children: tags.map((tag) => _buildTag(tag)).toList(),
                      ),
                    ],
                  ),
                  
                  // Bloco Inferior (Preço e Botão colados na base)
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

  const _UpcomingEventCard({
    required this.title,
    required this.dateInfo,
    required this.location,
    required this.tags,
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
            // [SUBSTITUIR] Use Image.asset ou Image.network aqui
            child: Container(
              width: 80,
              height: 80,
              color: Colors.grey[300], // Placeholder
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
                // Tags
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: tags.map((tag) {
                    bool isPink = tag == 'Pet-friendly' || tag == 'Geek'; // Pequena lógica só pra colorir como no protótipo
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

/// Função utilitária para desenhar as tags ("Festival", "Rock", "Pet-friendly")
Widget _buildTag(String text, {Color? bgColor, Color? textColor}) {
  return Container(
    margin: const EdgeInsets.only(right: 6),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: bgColor ?? const Color(0xFFF3E5F5), // Fundo roxo bem clarinho padrão
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: textColor ?? const Color(0xFF9C27B0), // Texto roxo padrão
      ),
    ),
  );
}