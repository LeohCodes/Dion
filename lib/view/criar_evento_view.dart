import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importante para usar as máscaras de input (TextInputFormatter)
import '../controller/criar_evento_controller.dart'; // Ajuste o caminho se necessário

class CriarEventoView extends StatefulWidget {
  const CriarEventoView({super.key});

  @override
  State<CriarEventoView> createState() => _CriarEventoViewState();
}

class _CriarEventoViewState extends State<CriarEventoView> {
  final CriarEventoController _controller = CriarEventoController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Fundo cinza bem claro
      
      // =========================================================
      // APP BAR
      // =========================================================
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E24)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Criar Evento',
          style: TextStyle(
            color: Color(0xFF9C27B0), // Roxo do título
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),

      // =========================================================
      // BOTÃO FIXO NO RODAPÉ (Publicar Evento)
      // =========================================================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        color: const Color(0xFFF8F9FA), 
        child: SafeArea(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF9C27B0), Color(0xFFE5208C)],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE5208C).withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                )
              ]
            ),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _controller.publicarEvento();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Evento publicado com sucesso!'), backgroundColor: Color(0xFF9C27B0)),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Publicar Evento', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Icon(Icons.send, color: Colors.white, size: 18),
                ],
              ),
            ),
          ),
        ),
      ),

      // =========================================================
      // CORPO Da TELA (Formulário de Criação de Evento)
      // =========================================================
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- SEÇÃO: UPLOAD DE IMAGENS ---
              const Text('Capa do Evento', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              const SizedBox(height: 12),
              
              _buildUploadBox(
                height: 140,
                icon: Icons.add_photo_alternate_outlined,
                title: 'Upload de Imagem de Capa',
                subtitle: 'Proporção recomendada 16:9. Formatos\nsuportados: JPG, PNG, WEBP.',
              ),
              const SizedBox(height: 12),
              
              Row(
                children: [
                  Expanded(
                    child: _buildUploadBox(
                      height: 100,
                      icon: Icons.add_photo_alternate_outlined,
                      title: 'Logo 1:1',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildUploadBox(
                      height: 100,
                      icon: Icons.add_photo_alternate_outlined,
                      title: 'Banner 3:4',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // --- SEÇÃO: FORMULÁRIO ---
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    _buildLabel('Título do Evento'),
                    _buildTextField(
                      controller: _controller.tituloController, 
                      hint: 'Ex: Music Festival'
                    ),
                    const SizedBox(height: 16),

                    // Data e Horário com Máscaras
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Data'),
                              _buildTextField(
                                controller: _controller.dataController, 
                                hint: 'dd/mm', 
                                icon: Icons.calendar_today_outlined,
                                keyboardType: TextInputType.number,
                                inputFormatters: [DataInputFormatter()], // Aplica a barra "/" automaticamente
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Horário'),
                              _buildTextField(
                                controller: _controller.horarioController, 
                                hint: '--:--', 
                                icon: Icons.access_time,
                                keyboardType: TextInputType.number,
                                inputFormatters: [HoraInputFormatter()], // Aplica os dois pontos ":" automaticamente
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Localização
                    _buildLabel('Localização'),
                    _buildTextField(
                      controller: _controller.localizacaoController, 
                      hint: 'Buscar endereço ou local...', 
                      icon: Icons.location_on_outlined
                    ),
                    const SizedBox(height: 16),

                    // Preço e Categoria
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Preço (R\$)'),
                              _buildTextField(
                                controller: _controller.precoController, 
                                hint: '0,00', 
                                icon: Icons.payments_outlined, 
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')), // Permite apenas números e vírgula
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Categoria'),
                              _buildDropdownField(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Descrição
                    _buildLabel('Descrição'),
                    TextFormField(
                      controller: _controller.descricaoController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Detalhes sobre o evento...',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                        filled: true,
                        fillColor: const Color(0xFFF8F9FA),
                        contentPadding: const EdgeInsets.all(16),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF9C27B0), width: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Tags do Evento
                    _buildLabel('Tags do evento'),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ..._controller.getTagsDisponiveis().map((tag) {
                            bool isHighlight = tag == 'Ao Ar Livre'; 
                            return _buildTagChip(tag, isHighlight: isHighlight);
                          }).toList(),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade400, style: BorderStyle.solid),
                            ),
                            child: const Icon(Icons.add, size: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Adicionar Atrações
                    _buildLabel('Adicionar Atrações:'),
                    TextFormField(
                      controller: _controller.atracoesController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.add, color: Color(0xFF9C27B0), size: 18),
                        filled: true,
                        fillColor: const Color(0xFFF8F9FA),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF9C27B0))),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // WIDGETS AUXILIARES
  // ==========================================

  Widget _buildUploadBox({required double height, required IconData icon, required String title, String? subtitle}) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF9C27B0).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF9C27B0).withValues(alpha: 0.3), width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF9C27B0), size: 32),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Color(0xFF9C27B0), fontWeight: FontWeight.bold, fontSize: 13)),
          if (subtitle != null) ...[
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 11),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFF1E293B), fontSize: 13, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Agora suporta inputFormatters e keyboardType
  Widget _buildTextField({
    required TextEditingController controller, 
    required String hint, 
    IconData? icon, 
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey, size: 20) : null,
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF9C27B0), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      isExpanded: true, // <-- CORREÇÃO DO OVERFLOW AQUI[cite: 8]
      value: _controller.categoriaSelecionada,
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.local_offer_outlined, color: Colors.grey, size: 20),
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF9C27B0), width: 1.5),
        ),
      ),
      hint: const Text('Selecione', style: TextStyle(color: Colors.grey, fontSize: 14)),
      items: _controller.categorias.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _controller.categoriaSelecionada = newValue;
        });
      },
    );
  }

  Widget _buildTagChip(String label, {bool isHighlight = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isHighlight ? const Color(0xFFFCE7F3) : Colors.white,
        border: Border.all(color: isHighlight ? Colors.transparent : const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isHighlight)
            const Padding(
              padding: EdgeInsets.only(right: 6),
              child: Icon(Icons.local_fire_department, color: Color(0xFFE5208C), size: 14),
            ),
          Text(
            label,
            style: TextStyle(
              color: isHighlight ? const Color(0xFFE5208C) : Colors.blueGrey,
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// CLASSES DE FORMATAÇÃO (MÁSCARAS NATIVAS)
// ==========================================

// Formatar para Data (Ex: 31/12)
class DataInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 4) text = text.substring(0, 4);
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && text.length > 2) buffer.write('/'); // Adiciona a barra automaticamente
    }
    var string = buffer.toString();
    return newValue.copyWith(text: string, selection: TextSelection.collapsed(offset: string.length));
  }
}

// Formatar para Horário (Ex: 23:59)
class HoraInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 4) text = text.substring(0, 4);
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && text.length > 2) buffer.write(':'); // Adiciona os dois pontos automaticamente
    }
    var string = buffer.toString();
    return newValue.copyWith(text: string, selection: TextSelection.collapsed(offset: string.length));
  }
}