import 'package:flutter/material.dart';
import 'package:dion/controller/evento_info_controller.dart';

class EventoInfoView extends StatefulWidget {
  const EventoInfoView({super.key});

  @override
  State<EventoInfoView> createState() => _EventoInfoViewState();
}

class _EventoInfoViewState extends State<EventoInfoView> {
  final EventoInfoController _controller = EventoInfoController();

  @override
  Widget build(BuildContext context) {
    // Carregando dados do controller
    final evento = _controller.getDetalhesEvento();
    final atracoes = _controller.getAtracoes();
    final eventosSemelhantes = _controller.getEventosSemelhantes();

    return Scaffold(
      backgroundColor: Colors.white,
      
      // ==========================================
      // BARRA INFERIOR FIXA (Comprar Ingresso)
      // ==========================================
      
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Preço
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('A partir de', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(
                    'R\$ ${evento.precoMinimo.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E1E24)),
                  ),
                ],
              ),

              //
              // Botão Comprar
              //
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF9C27B0), Color(0xFFE5208C)], // Gradiente roxo-rosa
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE5208C).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ]
                ),
                child: ElevatedButton(
                  onPressed: () {
                    //
                    // Ação de comprar ingresso
                    //
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Row(
                    children: const [
                      Text('Comprar Ingresso', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Icon(Icons.confirmation_number_outlined, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
      // ==========================================
      // CORPO DA TELA COM SCROLL
      // ==========================================

      body: SingleChildScrollView(
        child: Stack(
          children: [
            // 1. IMAGEM DE CABEÇALHO (Fica no fundo)
            Container(
              height: 380,
              width: double.infinity,
              color: const Color(0xFFE8F5E9), // Cor de fundo placeholder enquanto a imagem não carrega

              // child: Image.asset(evento.imagePath, fit: BoxFit.cover), // Descomentar quando tiver a imagem

              // Gradiente escuro no topo para os botões brancos aparecerem bem
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [Colors.black.withValues(alpha: 0.4), Colors.transparent],
                ),
              ),
            ),

            // 2. BOTÕES DO TOPO (Voltar e Compartilhar)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTopButton(Icons.arrow_back, () => Navigator.pop(context)),
                    _buildTopButton(Icons.share_outlined, () {}),
                  ],
                ),
              ),
            ),

            // 3. CONTEÚDO PRINCIPAL (Fundo branco arredondado sobrepondo a imagem)
            Container(
              margin: const EdgeInsets.only(top: 320), // Define onde o conteúdo branco começa a sobrepor a imagem
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    // --- TAGS FLUTUANTES ---

                    Transform.translate(
                      offset: const Offset(0, -45), // Joga as tags para cima, ficando metade na imagem, metade no branco
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: const Icon(Icons.favorite_border, size: 20, color: Color(0xFF1E1E24)),
                          ),
                          const SizedBox(width: 8),
                          _buildTag(evento.tags[0], isPurple: true),
                          const SizedBox(width: 8),
                          _buildTag(evento.tags[1], isPurple: false),
                        ],
                      ),
                    ),
                    
                    // Ajuste de espaçamento compensando o Transform das tags
                    const SizedBox(height: -20), //estava -20 mas dava erro

                    // --- TÍTULO E ORGANIZADOR ---

                    Text(evento.titulo, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF1E1E24))),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 24, height: 24,
                          decoration: BoxDecoration(color: Colors.amber[200], shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 8),
                        const Text('Organizado por ', style: TextStyle(color: Colors.grey, fontSize: 14)),
                        Text(evento.organizador, style: const TextStyle(color: Color(0xFF9C27B0), fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // --- CARDS DE DATA E LOCAL ---
                    Row(
                      children: [
                        Expanded(child: _buildInfoCard(Icons.calendar_today_outlined, evento.data, evento.horario)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildInfoCard(Icons.location_on_outlined, evento.localNome, evento.localBairro)),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // --- SOBRE O EVENTO ---
                    const Text('Sobre o Evento', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E1E24))),
                    const SizedBox(height: 12),
                    Text(
                      evento.descricao,
                      style: const TextStyle(color: Colors.blueGrey, fontSize: 14, height: 1.5),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {},
                      child: const Text('Ver mais', style: TextStyle(color: Color(0xFF9C27B0), fontWeight: FontWeight.bold, fontSize: 14)),
                    ),
                    const SizedBox(height: 32),

                    // --- ATRAÇÕES ---
                    const Text('Atrações', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E1E24))),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: atracoes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.grey[300],
                                  //
                                  // backgroundImage: AssetImage(atracoes[index].imagePath), // Descomentar para usar
                                  //
                                ),
                                const SizedBox(height: 8),
                                Text(atracoes[index].nome, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),

                    // --- LOCALIZAÇÃO E MAPA ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Localização', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E1E24))),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: const [
                              Text('Abrir Mapa', style: TextStyle(color: Color(0xFF9C27B0), fontWeight: FontWeight.bold, fontSize: 14)),
                              Icon(Icons.chevron_right, color: Color(0xFF9C27B0), size: 18),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(16),
                        //
                        // image: DecorationImage(image: AssetImage(evento.mapImagePath), fit: BoxFit.cover), // Descomentar para usar
                        //

                      ),
                      child: Center(
                        child: Icon(Icons.location_on, color: const Color(0xFFE5208C).withValues(alpha: 0.5), size: 40),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      evento.enderecoCompleto,
                      style: const TextStyle(color: Colors.blueGrey, fontSize: 14, height: 1.5),
                    ),
                    const SizedBox(height: 32),

                    // --- EVENTOS ANTERIORES SEMELHANTES ---
                    const Text('Eventos anteriores semelhantes:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E1E24))),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: eventosSemelhantes.length,
                        itemBuilder: (context, index) {
                          final evtSemelhante = eventosSemelhantes[index];
                          return Container(
                            width: 140,
                            margin: const EdgeInsets.only(right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(16),
                                    // image: DecorationImage(image: AssetImage(evtSemelhante.imagePath), fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  evtSemelhante.titulo,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E1E24)),
                                  maxLines: 1, overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  evtSemelhante.data,
                                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // WIDGETS AUXILIARES
  // ==========================================

  Widget _buildTopButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.8),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFF1E1E24)),
      ),
    );
  }

  Widget _buildTag(String text, {required bool isPurple}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isPurple ? const Color(0xFF9C27B0) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isPurple ? Colors.white : const Color(0xFF9C27B0),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFCEBF2), // Fundo rosinha claro
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFFE5208C), size: 20),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1E1E24))),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}