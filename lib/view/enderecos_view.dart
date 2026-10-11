import 'package:flutter/material.dart';

class EnderecosView extends StatefulWidget {
  const EnderecosView({super.key});

  @override
  State<EnderecosView> createState() => _EnderecosViewState();
}

class _EnderecosViewState extends State<EnderecosView> {
  final _formKey = GlobalKey<FormState>();

  // Controllers para os campos de texto
  final _cepController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _numeroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _complementoController = TextEditingController();
  final _cidadeController = TextEditingController();

  // Estado selecionado no Dropdown
  String? _estadoSelecionado;

  final List<String> _estados = [
    'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA',
    'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN',
    'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
  ];

  @override
  void dispose() {
    _cepController.dispose();
    _enderecoController.dispose();
    _numeroController.dispose();
    _bairroController.dispose();
    _complementoController.dispose();
    _cidadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Faz o corpo (gradiente) ir até o topo, por trás do AppBar
      extendBodyBehindAppBar: true,

      // Cria um AppBar invisível, mas que vai renderizar a setinha de voltar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Fundo transparente
        elevation: 0, // Remove a sombra
        title: const Text(
          'Endereço',
          style: TextStyle(
            color: Color(0xFF1E1E24),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF1E1E24), // Cor da setinha de voltar
        ),
      ),

      // Fundo gradiente
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 227, 196, 245),
              Color.fromARGB(255, 248, 246, 249),
              Color.fromARGB(255, 251, 217, 247),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // Título principal e subtítulo
                  const Text(
                    'Endereço',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E1E24),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // FORMULÁRIO ENDEREÇO
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // CEP
                        _buildCampoTexto(
                          controller: _cepController,
                          label: 'CEP',
                          hint: '00000-000',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Por favor, digite o CEP';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),

                        // Endereço / Logradouro
                        _buildCampoTexto(
                          controller: _enderecoController,
                          label: 'Endereço',
                          hint: 'Rua, Avenida, Alameda...',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Por favor, digite seu endereço';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),

                        // Número e Bairro 
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: _buildCampoTexto(
                                controller: _numeroController,
                                label: 'Número',
                                hint: '123',
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Informe o número';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 3,
                              child: _buildCampoTexto(
                                controller: _bairroController,
                                label: 'Bairro',
                                hint: 'Seu bairro',
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Informe o bairro';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Complemento (Opcional)
                        _buildCampoTexto(
                          controller: _complementoController,
                          label: 'Complemento',
                          hint: 'Apto, Bloco, Casa (Opcional)',
                        ),
                        const SizedBox(height: 14),

                        // Cidade e Estado
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: _buildCampoTexto(
                                controller: _cidadeController,
                                label: 'Cidade',
                                hint: 'Ribeirão Preto',
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Informe a cidade';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<String>(
                                initialValue: _estadoSelecionado,
                                decoration: _estiloInputDecoration(label: 'Estado'),
                                hint: const Text('UF', style: TextStyle(color: Colors.grey)),
                                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF9C27B0)),
                                items: _estados.map((String uf) {
                                  return DropdownMenuItem<String>(
                                    value: uf,
                                    child: Text(uf),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _estadoSelecionado = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Selecione';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // BOTÃO SALVAR/ATUALIZAR
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF9C27B0), // Roxo
                          Color(0xFFE5208C), // Rosa
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Endereço atualizado com sucesso!')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Atualizar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================
  // WIDGETS AUXILIARES E COMPONENTES DE UI
  // ==========================================
  //BLOQUINHOS DE ESCRITA
  InputDecoration _estiloInputDecoration({required String label, String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: Color(0xFF6B7280)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16), 
        borderSide: const BorderSide(color: Color(0xFF9C27B0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 213, 32, 230),
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 255, 0, 81),
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 255, 0, 81),
          width: 2.0,
        ),
      ),
    );
  }

  // ==========================================
  // WIDGETS AUXILIARES E COMPONENTES DE UI
  // ==========================================
  //TEXTO
  Widget _buildCampoTexto({
    required TextEditingController controller,
    required String label,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _estiloInputDecoration(label: label, hint: hint),
      validator: validator,
    );
  }
}