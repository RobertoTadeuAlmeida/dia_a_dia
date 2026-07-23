# Coding Standards

> Projeto: **Dia A Dia**
>
> Este documento define os padrões obrigatórios de desenvolvimento utilizados em todo o projeto.
>
> Todo código produzido manualmente ou por Inteligência Artificial deve seguir rigorosamente estas diretrizes.

---

# Objetivos

Todo código deve priorizar:

- simplicidade;
- legibilidade;
- organização;
- manutenção;
- escalabilidade;
- compatibilidade com IA;
- reutilização.

Evitar qualquer forma de overengineering.

---

# Arquitetura

O projeto utiliza:

- MVVM
- Provider
- Repository Pattern
- Modularização por funcionalidade

Não utilizar:

- Clean Architecture
- DDD
- UseCases
- Services desnecessários
- Camadas extras sem necessidade

---

# Estrutura do Projeto

```text
lib/

core/
shared/

modules/

login/
users/
tasks/

view/
viewmodel/
repositories/
models/
widgets/
```

Cada módulo deve possuir sua própria estrutura.

---

# Organização dos Arquivos

A ordem dos elementos dentro de um arquivo deve seguir:

```text
Imports

Constantes

Mocks (quando testes)

Helpers privados

main()

Groups

Widgets privados
```

Nunca misturar helpers após os testes.

---

# Organização das Pastas

Widgets reutilizáveis:

```text
shared/widgets/
```

Widgets específicos de uma tela:

```text
modules/<feature>/view/widgets/
```

Nunca duplicar Widgets.

---

# Organização das Keys

Todas as Keys ficam em:

```text
lib/core/constants/app_keys.dart
```

Nunca criar Keys diretamente dentro do Widget.

Formato obrigatório:

```text
<tela>_<componente>_<tipo>
```

Exemplos:

```dart
login_email_field

login_password_field

login_button

login_google_button

signup_name_field

signup_button

auth_logo

auth_title

auth_subtitle

task_save_button
```

---

# Organização das Strings

Sempre que uma String for reutilizada diversas vezes, transformá-la em constante.

Exemplo:

```text
lib/core/constants/app_strings.dart
```

Evitar duplicação.

---

# Organização das Cores

```text
app_colors.dart
```

Nunca utilizar cores diretamente nos Widgets.

---

# Organização dos Assets

```text
app_assets.dart
```

Exemplo:

```dart
AppAssets.logo

AppAssets.googleLogo
```

Nunca escrever caminhos manualmente.

---

# Organização dos Espaçamentos

```text
app_sizes.dart
```

Exemplo:

```dart
AppSizes.small

AppSizes.medium

AppSizes.large
```

Evitar números mágicos.

---

# Organização dos Ícones

```text
app_icons.dart
```

---

# Componentização

Sempre reutilizar componentes.

Exemplos:

```text
AuthHeader

AuthTextField

PasswordField

PrimaryButton

SocialLoginButton

ErrorMessage
```

Evitar Widgets gigantes.

---

# View

Responsabilidades:

- renderizar interface
- consumir ViewModel
- navegação
- composição dos Widgets

Nunca conter regras de negócio.

---

# ViewModel

Responsabilidades:

- estado da tela
- validações
- mensagens
- loading
- chamadas ao Repository

Nunca acessar:

- BuildContext
- Widgets
- Navigator

---

# Repository

Responsável apenas por:

- Supabase
- APIs
- Banco local
- Secure Storage

Nunca conter lógica visual.

---

# Validações

Toda validação deve ocorrer na ViewModel.

A View apenas exibe o estado.

---

# Nomenclatura

Classes:

```dart
LoginViewModel

AuthRepository

PrimaryButton
```

Métodos:

```dart
signIn()

signUp()

validateForm()

togglePasswordVisibility()
```

Variáveis privadas:

```dart
_email

_password

_isLoading
```

---

# Comentários

Utilizar separadores padronizados.

Exemplo:

```dart
//===========================================================================
// Estrutura Inicial
//===========================================================================
```

Evitar comentários óbvios.

---

# Testes

O projeto utiliza:

- Unit Test
- Widget Test

---

# Organização dos Testes

Sempre dividir por responsabilidade.

Exemplo:

```text
Estado Inicial

Estrutura Inicial

Campos do Formulário

Validação Visual

Botão Principal

Interações

Fluxo

Navegação

Feedback

Responsividade
```

Nunca criar grupos baseados apenas no nome do método.

---

# Nome dos Testes

Sempre utilizar:

```text
deve + ação + condição
```

Exemplos:

```text
deve exibir o botão Entrar

deve habilitar o botão quando o formulário estiver válido

deve navegar para Home após login

deve exibir mensagem de erro quando o login falhar
```

Evitar:

```text
teste login

teste botão

teste campo

login sucesso
```

---

# Helpers de Teste

Helpers privados ficam antes do main.

Exemplo:

```dart
_pumpLoginPage()

_mockLoginSuccess()

_mockLoginFailure()

_verifyLoginCalled()
```

---

# Organização dos Mocks

Todos os Mocks ficam antes do main.

Exemplo:

```dart
MockAuthRepository

MockLoginViewModel

MockUserModel
```

---

# Organização dos Helpers

Sempre utilizar pequenos Helpers reutilizáveis.

Exemplo:

```dart
_pumpLoginPage()

_pumpSignUpPage()

_preencherFormulario()

_mockSuccess()

_mockFailure()

_verifyCalled()
```

Evitar repetição.

---

# Widget Tests

Cada Widget reutilizável deve possuir seu próprio arquivo de testes.

Exemplo:

```text
auth_header_test.dart

primary_button_test.dart

password_field_test.dart
```

A tela deve apenas verificar que o Widget está presente.

Nunca repetir testes internos do Widget.

---

# Responsabilidade dos Testes

## Widget

Validar:

- renderização
- interação
- aparência
- composição

---

## ViewModel

Validar:

- regras de negócio
- estados
- loading
- mensagens
- chamadas ao Repository

---

## Repository

Validar:

- integração
- exceções
- persistência
- mapeamento de erros

---

# Chaves de Teste (Keys)

Sempre utilizar Keys para localizar Widgets importantes.

Evitar utilizar textos quando possível.

Exemplo:

```dart
find.byKey(AppKeys.loginButton)
```

Preferir Keys a:

```dart
find.text(...)
```

---

# Objetivo Final

Todo código produzido deve ser:

- simples;
- previsível;
- organizado;
- reutilizável;
- facilmente testável;
- facilmente compreendido por humanos e Inteligência Artificial.

Qualquer contribuição que não siga este documento deverá ser refatorada antes de ser integrada ao projeto.