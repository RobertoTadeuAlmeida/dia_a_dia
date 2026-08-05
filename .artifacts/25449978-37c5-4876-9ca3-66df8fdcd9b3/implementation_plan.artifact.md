# Plano de Refatoração do README.md — Projeto Dia A Dia

Este plano detalha a reestruturação do `README.md` raiz para torná-lo uma porta de entrada profissional, organizada e informativa, baseada inteiramente no estado real do projeto.

## User Review Required

> [!IMPORTANT]
> O status das funcionalidades e as tecnologias foram validados diretamente no código e diretórios do projeto:
> - **Módulos Task e Weather**: Possuem estrutura de pastas, mas ViewModels vazias. Estão marcados corretamente como "Planejado" ou "Em desenvolvimento".
> - **Módulo Home**: Contém apenas interface visual sem lógica. Marcado como "Em desenvolvimento".
> - **Autenticação e Cadastro**: Totalmente implementados e integrados com Supabase.
> - **Licença**: Confirmada como MIT no arquivo `LICENSE`.

## Mudanças Propostas

### [Geral: Apresentação Visual]

#### [MODIFY] [README.md](file:///home/rtadeu/Dev/FlutterProject/dia_a_dia/README.md)

1.  **Header Profissional**:
    - Centralizar o título e o slogan: **Seu dia mais organizado**.
    - Organizar badges existentes: Flutter, Dart, Supabase, License.
2.  **Sobre o Projeto**:
    - Explicar o Dia A Dia como um organizador de rotina inteligente com integração climática.
3.  **Funcionalidades**:
    - [x] Autenticação segura (E-mail/Senha e Google via Supabase).
    - [x] Cadastro de novos usuários.
    - [x] Gestão de sessão com armazenamento seguro.
    - [ ] Dashboard principal (Interface visual em andamento).
    - [ ] Gerenciamento de tarefas (Planejado).
    - [ ] Integração com clima (Planejado).
4.  **Tecnologias**:
    - Flutter, Dart, Supabase, Provider, Flutter Secure Storage, Google Fonts, Mocktail.
5.  **Status**:
    - Projeto em fase de MVP (Minimum Viable Product) com desenvolvimento incremental.
6.  **Documentação**:
    - **Design**: Paleta de Cores, Tipografia, Logo (Links para `docs/designer/`).
    - **Funcionalidades**: Auth, Signup (Links para `docs/features/`).
    - **Desenvolvimento**: Padrões de Código (Link para `docs/coding_standards.md`).
7.  **Como Executar**:
    - `flutter pub get`, configuração do Supabase, `flutter run`.
8.  **Testes**:
    - Instrução `flutter test`.
9.  **Licença**:
    - MIT (Link para [LICENSE](file:///home/rtadeu/Dev/FlutterProject/dia_a_dia/LICENSE)).

## Verificação Plan

### Manual Verification
- Validar se todos os links relativos funcionam.
- Confirmar a renderização correta do Markdown (Português Brasileiro).
