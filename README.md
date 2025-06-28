TaskMaster

TaskMaster é um aplicativo de produtividade desenvolvido em Flutter, projetado para ajudar os usuários a organizar tarefas diárias, gerenciar hábitos, personalizar configurações de acessibilidade e manter um perfil pessoal. Com uma interface intuitiva e recursos acessíveis, o app é ideal para melhorar a rotina e a organização pessoal.

Funcionalidades
Gerenciamento de Tarefas: Adicione, edite e exclua tarefas diárias com calendário semanal e anotações.
Acompanhamento de Hábitos: Organize hábitos por categorias (Saúde, Lazer, Trabalho, etc.) e marque seu progresso.
Acessibilidade: Ajuste o tamanho da fonte e explore opções de personalização para visão e interação.
Perfil do Usuário: Edite informações pessoais (nome, idade, cidade) e avalie o progresso de hábitos com sliders.
Navegação Intuitiva: Acesse todas as funcionalidades por meio de uma barra de navegação inferior.
Menu Principal: Centralize o acesso a notificações, idioma, modo noturno e outras opções.
Login: Interface de login com design moderno (autenticação simulada).
Tela de Calendário: Visualize e gerencie tarefas com um calendário interativo.

Tecnologias Utilizadas
Flutter: Framework para desenvolvimento multiplataforma.
SharedPreferences: Persistência de dados local.
TableCalendar: Exibição de calendários nas telas de tarefas.
Intl: Formatação de datas no formato brasileiro (pt_BR).

Pré-requisitos
Flutter SDK (versão estável recomendada)
Dart
Editor de código (VS Code, Android Studio, etc.)
Emulador ou dispositivo físico para testes

Estrutura do Projeto
accessibility_screen.dart: Configurações de acessibilidade, como ajuste de tamanho de fonte.
calendar_screen.dart: Gerenciamento de tarefas diárias com calendário mensal.
habit_screen.dart: Organização e acompanhamento de hábitos por categoria.
login_screen.dart: Interface de login com design curvo.
main_navigation.dart: Navegação principal com barra inferior.
menu_screen.dart: Menu com atalhos para várias funcionalidades.
profile_screen.dart: Visualização e edição de informações do usuário.
tasks_screen.dart: Gerenciamento de tarefas com calendário semanal e anotações.
