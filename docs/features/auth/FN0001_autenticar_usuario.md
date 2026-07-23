## Objetivo

Permitir que o usuário se autentique para o acesso a aplicação através da tela
de login, onde o usuário deve fornecer credenciais validas.

---

## Atores

- Usuário

---

## Fluxo Principal

1. Usuário acessa a tela de login.
2. Usuário informa e-mail e senha.
3. Sistema valida os campos.
4. Sistema realiza autenticação.
5. Sistema retorna sucesso ou erro.
6. Usuário autenticado é redirecionado para a tela inicial.

---

## Fluxo MVVM

#### Diagrama

!image.png

#### Sequência

1. Usuário informa e-mail e senha.
2. LoginView valida os dados informados localmente utilizando `LoginValidators`.
3. LoginView aciona o método `signInWithEmailAndPassword()` ou `signInWithGoogle()`.
4. LoginViewModel solicita a autenticação ao AuthRepository.
5. AuthRepository realiza a autenticação no Supabase utilizando `signInWithPassword()` ou `signInWithOAuth()`.
6. Supabase retorna sucesso ou erro.
7. LoginViewModel atualiza o estado da tela (`status` e `errorMessage`).
8. LoginView reage à mudança de estado exibindo uma mensagem ou navegando para a Home.

#### Responsabilidades

| Camada | Responsabilidade |
| --- | --- |
| View | Exibir a interface e capturar as ações do usuário |
| ViewModel | Gerenciar estados, validações e fluxo da funcionalidade |
| Repository | Realizar comunicação com APIs e persistência de dados |
| Supabase | Autenticação, armazenamento e gerenciamento dos dados |

---


## Interface (Wireframe)

![Tela de Autenticação](dia_a_dia/docs/features/auth/assets/FN0001_tela-login.png)


---

## Requisitos funcionais

### RF001 — Exibir tela de login

- O sistema deve disponibilizar a tela de login através da rota `/`.
- A tela de login deve ser apresentada para usuários não autenticados ao iniciar a aplicação.
- Usuários autenticados não devem acessar a tela de login, devendo ser redirecionados automaticamente para a rota `/home`.
- A tela de login deve permanecer acessível enquanto não existir sessão autenticada válida.

---

### RF002 — Login social Google

O sistema deve permitir autenticação utilizando conta Google através do fluxo OAuth2.

- Ao selecionar a opção de login Google o usuário deve ser redirecionado para o fluxo de autenticação do provedor Google.
- Após autenticação bem-sucedida o sistema deve:
    - Validar os dados retornados pelo provedor de autenticação.
    - Criar e persistir sessão autenticada.
    - Redirecionar o usuário para a rota `/home` .
- Em caso de cancelamento da autenticação Google o sistema deve:
    - Interromper o fluxo de autenticação.
    - Não gerar sessão autenticada.
    - Manter o usuário na tela de login.
- Em caso de falha durante autenticação Google o sistema deve:
    - Impedir criação de sessão autenticada.
    - Exibir mensagem de erro apropriada.
    - Permitir nova tentativa de autenticação.

---

### RF003 — Formulário de autenticação

- O sistema deve exibir um formulário de autenticação na tela de login contendo:
    - Campo de e-mail.
    - Campo de senha.
    - Botão “Entrar”.
- O formulário deve permitir autenticação manual utilizando e-mail e senha.
- Os campos do formulário devem:
    - Permitir edição pelo usuário.
    - Possuir identificação visual clara.
    - Exibir mensagens de erro quando inválidos.
- O botão “Entrar” deve iniciar o processo de autenticação do usuário.

---

### RF004 — Validação de e-mail

- O sistema deve validar o campo de e-mail durante o processo de autenticação.
- O campo de e-mail deve validar:
    - Preenchimento obrigatório.
    - Formato válido de e-mail.
    - Remoção de espaços inválidos antes e após o conteúdo informado.
- O sistema não deve permitir autenticação enquanto o campo de e-mail possuir erros de validação.

Mensagens de validação:

`Formato de e-mail inválido.`

---

### RF005 — Validação de senha

- O sistema deve validar o campo de senha durante o processo de autenticação.
- O campo de senha deve validar:
    - Preenchimento obrigatório
    - Quantidade mínima de 8 caracteres
- O sistema não deve permitir autenticação enquanto o campo de senha possuir erros de validação.

Mensagens de validação:

`Senha vazia.`

`A senha deve possuir no mínimo 8 caracteres.`

---

### RF006 — Visualização de senha

O sistema deve permitir visualizar e ocultar o conteúdo do campo de senha durante autenticação.

---

### RF007 — Controle do botão de login

O botão “Entrar” deve:

- permanecer desabilitado enquanto existirem erros de validação
- iniciar o processo de autenticação ao ser acionado
- exibir loading visual durante autenticação
- permanecer bloqueado até finalização da autenticação
- retornar ao estado habilitado em caso de falha na autenticação

---

### RF008 — Autenticação

Ao realizar autenticação o sistema deve:

- Gerar sessão autenticada.
- Autenticar apenas usuários com credenciais válidas.
- Armazenar a sessão autenticada localmente.
- Redirecionar usuário para rota `/home`.
- Exibir mensagem de sucesso:

    `“Bem-vindo.”`


Em caso de autenticação inválida o sistema deve impedir acesso à aplicação autenticada.

---

### RF009 — Tratamento de erro

O sistema deve tratar falhas de autenticação exibindo mensagens apropriadas ao usuário conforme o tipo de erro identificado.

- Mensagem padrão:

`Ops! Não foi possível acessar a aplicação. Tente novamente mais tarde.`

- Em caso de credenciais inválidas o sistema deve exibir:

`E-mail ou senha inválidos.`

- Em caso de falha durante a autenticação o sistema deve:
    - Impedir acesso a rotas protegidas.
    - Remover estados de loading da interface.
    - Reabilitar interação do botão “Entrar”.
    - Exibir mensagens de erro correspondentes.
- Em caso de ausência de conexão com internet o sistema deve exibir mensagem informando indisponibilidade de conexão.
- Em caso de cancelamento da autenticação Google o sistema deve retornar o usuário para a tela de login sem gerar sessão autenticada.

---

### RF010 — Persistência de sessão

O sistema deve manter a sessão autenticada do usuário entre reinicializações do aplicativo enquanto existir autenticação válida.

Ao iniciar a aplicação o sistema deve:

- verificar existência de sessão autenticada válida através de `checkSession()`
- restaurar sessão autenticada persistida localmente com `restoreSession()`
- validar token local utilizando `hasValidSession()`
- redirecionar usuários autenticados para a rota `/home`

Em caso de sessão inexistente ou inválida o sistema deve redirecionar o usuário para a tela de login.

---

### RF011 — Validação de sessão

O sistema deve validar se existe uma sessão autenticada válida durante utilização da aplicação.

O sistema deve:

- permitir acesso apenas para usuários autenticados através do estado `isAuthenticated` da ViewModel
- impedir acesso quando não existir sessão válida
- redirecionar usuários não autenticados para a tela de login

Em caso de sessão expirada o sistema deve:

- remover autenticação local
- redirecionar usuário para a tela de login
- exigir nova autenticação

---

### RF012 — Logout

O sistema deve permitir encerramento da sessão autenticada do usuário através do método `signOut()`.

Ao realizar logout o sistema deve:

- invalidar sessão autenticada
- remover tokens armazenados localmente
- remover dados de autenticação persistidos
- redirecionar usuário para a tela de login

---

## Requisitos não funcionais

### RNF001 — Segurança

- O sistema deve utilizar autenticação segura através do protocolo OAuth2.
- Sessões autenticadas devem ser armazenadas utilizando armazenamento seguro do dispositivo.
- O sistema deve permitir acesso apenas para usuários autenticados com sessão válida.
- Tokens e dados de autenticação não devem ser expostos visualmente ao usuário.
- O sistema deve invalidar sessões autenticadas durante logout.
- O sistema deve remover dados de autenticação local após encerramento da sessão.

---

### RNF002 — Persistência

- O sistema deve persistir a sessão autenticada do usuário entre reinicializações do aplicativo enquanto existir autenticação válida.
- Tokens e dados de autenticação devem ser armazenados utilizando armazenamento seguro do dispositivo.
- O sistema deve armazenar apenas os dados necessários para manutenção da sessão autenticada.
- Dados de autenticação persistidos devem ser removidos após logout da aplicação.

---

### RNF003 — Performance

- As validações dos campos devem ocorrer localmente antes do envio da requisição.
- O botão de autenticação deve permanecer bloqueado durante o processo de autenticação.
- O sistema deve permanecer responsivo durante o fluxo de autenticação.

---

### RNF004 — Feedback visual

- O sistema deve exibir indicador visual de carregamento durante processos de autenticação.
- Mensagens de erro e sucesso devem ser apresentadas de forma clara e legível ao usuário.
- Notificações visuais devem possuir duração aproximada de 2000ms.

---

## Regra de negocio

### RN001 — Validade da sessão

- Sessões autenticadas devem permanecer válidas enquanto existir autenticação ativa no dispositivo.
- Em caso de expiração da sessão o sistema deve exigir nova autenticação do usuário.

---

### RN002 — Acesso protegido

- Usuários não autenticados não devem acessar funcionalidades protegidas da aplicação.

---

### RN003 — Logout

- Ao realizar logout o sistema deve encerrar a sessão autenticada do usuário.

---

### RN004 — Cancelamento de autenticação Google

- O sistema não deve gerar sessão autenticada quando o fluxo de autenticação Google for cancelado pelo usuário.

---

### RN005 — Validação obrigatória

- O sistema não deve permitir autenticação enquanto existirem erros de validação nos campos obrigatórios.

---

## Dependências externas

- Supabase — autenticação, gerenciamento de sessão e persistência de dados do usuário.
- OAuth 2.0 — autenticação social utilizando provedor Google.
- Flutter Secure Storage — armazenamento seguro de tokens e dados de autenticação no dispositivo.

---