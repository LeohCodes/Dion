# **Dion** - O Seu Guia de Eventos em Ribeirão Preto

> **Projeto Dion** 
> Desenvolvido por: **Jéssica Bianchi** e **Leonardo Araujo**

---

## Sobre o Projeto

O **Dion** é uma plataforma tecnológica (Mobile/Web) desenvolvida para unificar e centralizar a divulgação de eventos, cultura, vida noturna e lazer na cidade de Ribeirão Preto e região. 

Nascido da necessidade de combater a "fadiga de decisão" dos consumidores e a dificuldade de pequenos produtores em divulgar seus eventos orgânicamente, o aplicativo nasce como um facilitador. Ele conecta o público ideal aos eventos certos por meio de filtros personalizados, algoritmos de recomendação baseados em interesses e ferramentas utilitárias nativas (compra de ingressos, carteira digital, mapa geolocalizado e notificações push).

## Tecnologias Utilizadas

O desenvolvimento prático da aplicação foi inteiramente construído utilizando:

*   **Front-end Mobile:** Flutter & Dart
*   **Design & Prototipação:** Figma
*   **Gerenciamento de Assets:** Configuração via `pubspec.yaml` para imagens locais e ícones nativos (Material Icons).

---

## Arquitetura e Padrões de Desenvolvimento

O projeto esta sendo estruturado utilizando o padrão de arquitetura **MVC (Model-View-Controller)** para garantir escalabilidade, organização e facilidade de manutenção por uma equipe reduzida.

### 1. Camada de Views (`/view`)
Responsável exclusivamente pela interface visual (UI) e interação do usuário (UX).
*   Interfaces construídas com `Scaffold`, `SingleChildScrollView` e `Stack` para permitir designs modernos com imagens de fundo sobrepostas.
*   Widgets isolados e modulares para componentes repetitivos (ex: `_buildTagChip`, `_buildInfoCard`).
*   Navegação gerenciada internamente pela View através do `Navigator.push` e `BottomNavigationBar`.

### 2. Camada de Controllers (`/controller`)
Responsável pelas regras de negócio, fornecimento de dados e validações.
*   **Padrão Singleton:** Implementado em controllers críticos (como o `PerfilController`) para manter a persistência de estado do usuário ao longo da navegação, impedindo a perda de dados entre a transição de telas sem a necessidade inicial de pacotes complexos de gerência de estado.
*   **Validações:** Métodos centralizados para validação de formulários (ex: mínimo de caracteres para edição de nome, máscara de inputs para datas e horários via `TextInputFormatter`).

### 3. Modelos de Dados (Models)
Estruturas de classes definidas para representar as entidades do banco de dados no front-end, como `EventModel`, `UsuarioModel` e `CupomModel`.

---

## Telas Desenvolvidas e Protótipos

Abaixo estão algumas telas desenvolvidas no front-end, baseadas na alta fidelidade do protótipo UI/UX.

### 1. Criar Perfil (Cadastro de Usuário)
A interface de cadastro foi projetada para viabilizar a entrada de novos usuários no sistema, diferenciando o público desde o primeiro contato. O grande destaque arquitetônico desta tela é o **seletor dinâmico de perfil** (Toggle Switch). Ao alternar entre "Sou Cliente" e "Sou Organizador", o formulário reage em tempo real, renderizando ou ocultando campos específicos (como a obrigatoriedade de CNPJ e a flag de "Artista Independente" para produtores), garantindo uma coleta de dados precisa e customizada sem precisar recarregar a página.

![Protótipo - Tela de Cadastro](dion/assets/screenshots/CriarConta.jpg)

### 2. Home (Descoberta de Eventos)
A tela inicial atua como o principal motor de descoberta exploratória, contendo Scroll View horizontal e vertical dinâmicos divididos entre "Eventos em Destaque", "Eventos Próximos" e "Atrações Favoritas".

![Protótipo - Tela Home](https://github.com/LeohCodes/Dion/tree/main/dion/assets/screenshots/Home.jpg)

### 3. Detalhes do Evento (EventoInfoView)
Página de conversão da plataforma. Estruturada com uma imagem de topo (Header) fixada no fundo, scroll sobreposto de informações, seção de atrações, mapa integrado e uma "Sticky Bottom Bar" fixa para compra de ingressos.

![Protótipo - Detalhes do Evento](https://github.com/LeohCodes/Dion/tree/main/assets/screenshots/EventoInfo.jpg)

### 4. Perfil do Usuário
Painel de controle do consumidor e gerenciamento de identidade. O desenvolvimento contou com a lógica condicional de um **"Modo de Edição"**, permitindo que a view alterne organicamente entre a visualização das estatísticas/interesses e o formulário de atualização de dados, sem a necessidade de criar uma nova tela.

![Protótipo - Perfil do Usuário](dion/assets/screenshots/Perfil.jpg)

---

## 🛠️ Como executar este projeto localmente

Siga os passos abaixo para rodar a aplicação Flutter na sua máquina:

1. **Clone o repositório:**
   ```bash
   git clone [https://github.com/SEU_USUARIO/dion-app.git](https://github.com/SEU_USUARIO/dion-app.git)
