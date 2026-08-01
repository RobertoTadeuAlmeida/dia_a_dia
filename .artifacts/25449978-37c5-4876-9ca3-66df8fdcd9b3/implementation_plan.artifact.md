# Plano de Implementação - SignupPage (Estado Green)

O objetivo é implementar a `SignupPage` para satisfazer todos os testes em `signup_page_test.dart`, seguindo os padrões MVVM e a arquitetura do projeto.

## User Review Required

> [!IMPORTANT]
> - Criarei o widget `SuccessMessage` em `lib/core/widgets/success_message.dart`, seguindo o padrão do `ErrorMessage`.
> - A `SignupPage` será implementada com controladores para todos os campos e reagirá aos estados de erro e sucesso da `SignUpViewModel`.
> - Utilizarei `AppKeys` para garantir que os testes localizem os widgets corretamente.

## Mudanças Propostas

### Core Widgets

#### [NEW] [success_message.dart](file:///home/rtadeu/Dev/FlutterProject/dia_a_dia/lib/core/widgets/success_message.dart)
- Implementar `SuccessMessage` similar ao `ErrorMessage`.
- Utilizar `AppKeys.successMessage`, `AppKeys.successMessageIcon` e `AppKeys.successMessageText`.
- Usar `Icons.check_circle_outline`.

### Módulo de Login

#### [MODIFY] [signup_page.dart](file:///home/rtadeu/Dev/FlutterProject/dia_a_dia/lib/modules/login/view/pages/signup_page.dart)
- Implementar `_SignupPageState` com:
    - `TextEditingController` para Nome, Sobrenome, E-mail, Senha e Confirmação.
    - Estados booleanos para visibilidade de senha e confirmação.
- Estrutura do `build`:
    - `Scaffold` com `AppKeys.signupPage`.
    - `AppBar` com `signupBackButton`.
    - `SingleChildScrollView` para evitar overflow.
    - `AuthHeader` com `AppKeys.authHeader`.
    - `AuthCard` com `AppKeys.authCard`.
    - `AuthTextField` para cada campo com suas respectivas `AppKeys`.
    - `PrimaryButton` para "Criar Conta" com `AppKeys.signupButton`.
    - `OrDivider` e `SocialLoginButton`.
    - `ErrorMessage` e `SuccessMessage`.
    - Link "Fazer Login" com `AppKeys.signupLoginLink`.
- Lógica:
    - Atualizar ViewModel no `onChanged` de cada campo.
    - Navegar para `RouteNames.home` ao detectar sucesso.
    - Navegar para `RouteNames.login` no botão voltar ou link de login.

## Plano de Verificação

### Testes Automatizados
- Executar `flutter test test/modules/login/view/pages/signup_page_test.dart`.
- Garantir que todos os 25 testes passem.
