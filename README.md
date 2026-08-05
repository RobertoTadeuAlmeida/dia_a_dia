# Dia A Dia — Seu dia mais organizado 🚀

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white" alt="Supabase" />
  <img src="https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge" alt="License" />
</p>

---

## 📱 Sobre o projeto

O **Dia A Dia** é um organizador de rotina inteligente projetado para transformar a maneira como você gerencia seu tempo. Através de uma interface intuitiva e moderna, o aplicativo permite que você planeje suas tarefas diárias com um diferencial estratégico: a integração com dados meteorológicos, ajudando a evitar imprevistos e otimizando atividades ao ar livre ou compromissos externos.

A proposta é oferecer clareza, previsibilidade e produtividade para estudantes, profissionais e qualquer pessoa que busque uma rotina mais estruturada.

---

## ✨ Funcionalidades

### Autenticação e Segurança
- [x] **Login Seguro**: Autenticação via E-mail e Senha integrados ao Supabase.
- [x] **Gestão de Cadastro**: Criação de novos usuários com validação de dados em tempo real.
- [x] **Persistência de Sessão**: Restauração automática de login utilizando armazenamento seguro no dispositivo.
- [ ] **Login Social**: Autenticação via Google (Em desenvolvimento).

### Organização (Roadmap)
- [ ] **Dashboard Principal**: Visualização rápida do dia e progresso das tarefas (Interface em andamento).
- [ ] **Gerenciamento de Tarefas**: Criação, edição e categorização de atividades.
- [ ] **Integração climática**: consulta à previsão do tempo.

---

## 🛠️ Tecnologias

O projeto utiliza uma stack focada em simplicidade e manutenibilidade:

| Tecnologia | Utilização |
|---|---|
| **Flutter** | Framework para desenvolvimento do aplicativo |
| **Dart** | Linguagem de programação principal |
| **Supabase Auth** | Serviço de autenticação e gestão de usuários |
| **Provider** | Gerenciamento de estado reativo |
| **Flutter Secure Storage** | Armazenamento seguro de tokens de sessão |
| **Google Fonts** | Integração da família tipográfica **Manrope** |
| **Mocktail** | Biblioteca para mocking em testes automatizados |

---

## 🚧 Status

O projeto encontra-se atualmente em fase de **MVP (Minimum Viable Product)**. As funcionalidades de autenticação e as bases de identidade visual estão em desenvolvimento/consolidação, com o desenvolvimento focado agora nas funcionalidades core de gerenciamento de tarefas.

---

## 📚 Documentação

Nossa documentação é organizada para facilitar tanto o entendimento do produto quanto a manutenção técnica.

### 🎨 Design e Identidade
- [Paleta de Cores](docs/design/ui/paleta_cores.md)
- [Tipografia](docs/design/brand/tipografia.md)
- [Logo e Branding](docs/design/ui/logo.md)

### ⚙️ Desenvolvimento
- [Padrões de Código (Coding Standards)](docs/coding_standards.md)

### 🚀 Funcionalidades (Features)
- **Auth (FN0001)**: [Especificação Funcional](docs/features/auth/FN0001_autenticar_usuario.md) | [UX/UI](docs/features/auth/ux-ui.md)
- **Signup (FN0002)**: [Especificação Funcional](docs/features/signup/FN0002_gerenciar_usuario.md) | [UX/UI](docs/features/signup/ux-ui.md)

---

## 🏗️ Estrutura do Projeto

```text
lib/
├── core/             # Componentes, constantes, temas e utilitários globais
├── modules/          # Funcionalidades divididas por módulos (features)
│   ├── login/        # Lógica e UI de Autenticação e Cadastro
│   ├── home/         # Dashboard e telas principais
│   ├── task/         # Gerenciamento de tarefas
│   └── weather/      # Integração com API de clima
└── shared/           # Widgets e modelos compartilhados entre módulos
```

---

## 🚀 Como executar

1.  **Pré-requisitos**: Ter o Flutter SDK instalado e configurado em sua máquina.
2.  **Clonar e Instalar**:
    ```bash
    git clone https://github.com/RobertoTadeuAlmeida/dia_a_dia.git
    cd dia_a_dia
    flutter pub get
    ```
3.  **Configuração**: O projeto depende de chaves do Supabase. Verifique os arquivos em `lib/core/config/` para as definições necessárias.
4.  **Executar**:
    ```bash
    flutter run
    ```

---

## 🧪 Testes

A qualidade do código é garantida através de suítes de testes unitários e de widget.

Para executar todos os testes:
```bash
flutter test
```

---

## 📄 Licença

Este projeto está sob a licença **MIT**. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

Developed by **Roberto Tadeu**
