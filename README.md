# Dia A Dia — Seu dia mais organizado 🚀

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

O **Dia A Dia** é um organizador de rotina inteligente desenvolvido em Flutter, projetado para ajudar usuários a gerenciarem suas tarefas e compromissos com um diferencial estratégico: a integração com dados climáticos para evitar imprevistos no planejamento diário.

---

## 🎯 Objetivos do Projeto

- **Organização Eficiente**: Planejamento de rotinas e tarefas de forma intuitiva.
- **Previsibilidade**: Integração com clima para sugerir os melhores horários para atividades externas.
- **Foco em Produtividade**: Otimização do tempo para estudantes, autônomos e profissionais.
- **Segurança**: Autenticação moderna e armazenamento seguro de dados.

## ✨ Funcionalidades Atuais (MVP V1)

- [x] **Autenticação Segura**: Login com E-mail/Senha e Social Login (Google) via Supabase.
- [x] **Gestão de Sessão**: Persistência de login e restauração automática utilizando Armazenamento Seguro.
- [x] **Interface Moderna**: UI baseada em Material Design 3, focada em simplicidade e usabilidade.
- [x] **Arquitetura Robusta**: Implementação seguindo rigorosamente os padrões de TDD (Test-Driven Development).
- [x] **Componentização**: Widgets reutilizáveis e padronizados para consistência visual.

---

## 🛠 Tecnologias Utilizadas

### Frontend
- **Framework**: [Flutter](https://flutter.dev/)
- **Gerenciamento de Estado**: [Provider](https://pub.dev/packages/provider)
- **Design System**: Material Design 3

### Backend & Serviços
- **Backend-as-a-Service**: [Supabase](https://supabase.com/) (Auth, Database, Storage)
- **API de Clima**: OpenWeather API
- **Persistência Local**: Flutter Secure Storage

---

## 🏗 Arquitetura e Padrões

O projeto segue padrões rigorosos de desenvolvimento para garantir escalabilidade e manutenção:

- **MVVM (Model-View-ViewModel)**: Separação clara entre lógica de negócio, estado da interface e visualização.
- **Repository Pattern**: Abstração da fonte de dados para facilitar testes e troca de provedores.
- **Modularização**: Organização por funcionalidade para evitar acoplamento excessivo.
- **TDD (Test-Driven Development)**: Garantia de qualidade com suítes de testes unitários e de widget cobrindo os fluxos principais.

> [!NOTE]
> Consulte o documento de [Coding Standards](docs/coding_standards.md) para detalhes sobre as diretrizes de desenvolvimento.

---

## 🧪 Estratégia de Testes

A qualidade do código é validada através de uma cobertura extensiva:

- **Widget Tests**: Validação de renderização, interação e comportamento visual dos componentes.
- **Unit Tests**: Testes de lógica de negócio em ViewModels e Repositories.
- **Mocking**: Utilização de `mocktail` para simular dependências externas com previsibilidade.

Para rodar os testes:
```bash
flutter test
```

---

## 🚀 Como Rodar o Projeto

1. **Pré-requisitos**:
   - Flutter SDK (versão estável mais recente)
   - Chaves de acesso ao Supabase e OpenWeather

2. **Instalação**:
   ```bash
   git clone https://github.com/seu-usuario/dia_a_dia.git
   cd dia_a_dia
   flutter pub get
   ```

3. **Configuração**:
   - Configure as variáveis de ambiente necessárias para o Supabase.

4. **Execução**:
   ```bash
   flutter run
   ```

---

## 📅 Roadmap (Funcionalidades Futuras)

- [ ] Sincronização em tempo real entre dispositivos.
- [ ] Sugestão de horários inteligente via IA.
- [ ] Integração com Google Agenda.
- [ ] Widgets de tela inicial para visualização rápida.
- [ ] Sistema de metas e estatísticas de produtividade.

---

© 2026 Dia A Dia. Todos os direitos reservados.
