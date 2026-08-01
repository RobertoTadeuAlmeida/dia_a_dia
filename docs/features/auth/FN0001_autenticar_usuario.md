## Objetivo

Permitir que o usuário se autentique para o acesso a aplicação através da tela
de login, onde o usuário deve fornecer credenciais validas.

---

## Atores

- Usuário

---

## Fluxo Principal (Funcional)

1. Usuário acessa a tela de login.
2. Usuário informa e-mail e senha.
3. Sistema valida os campos localmente.
4. Sistema realiza autenticação via Supabase.
5. Sistema retorna sucesso ou erro.
6. Usuário autenticado é redirecionado para a tela inicial.

---

## Fluxo do Usuário

1. Abrir tela
2. Preencher e-mail
3. Preencher senha
4. Acionar ação de Entrar
5. Aguardar processamento (Loading)
6. Redirecionamento para Home (Sucesso) ou Exibição de Mensagem (Erro)

---

## Fluxo MVVM

#### Diagrama

> [!NOTE]
> Diagrama de sequência representando a interação entre as camadas.

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

## Validações de Campo

### Campo: E-mail
| Regra | Mensagem de Erro |
| --- | --- |
| Preenchimento obrigatório | `Informe seu e-mail` |
| Formato de e-mail inválido | `E-mail inválido` |

### Campo: Senha
| Regra                     | Mensagem de Erro                           |
|---------------------------|--------------------------------------------|
| Preenchimento obrigatório | `Informe sua senha`                        |
| Mínimo de 8 caracteres    | `A senha deve ter pelo menos 8 caracteres` |

---

## Matriz de Navegação

| Origem | Ação | Destino | Condição |
| --- | --- | --- | --- |
| Login | Clique em "Criar conta" | Cadastro (Signup) | Sempre |
| Login | Login com E-mail/Senha | Home | Credenciais válidas |
| Login | Login com Google | Home | Autenticação Google confirmada |
| Inicialização | Automática | Home | Sessão ativa e válida |
| Inicialização | Automática | Login | Sem sessão ativa |

---

## Requisitos funcionais

### RF001 — Exibir tela de login
- O sistema deve disponibilizar a tela de login através da rota `/`.
- A tela de login deve ser apresentada para usuários não autenticados ao iniciar a aplicação.
- Usuários autenticados não devem acessar a tela de login, devendo ser redirecionados automaticamente para a rota `/home`.

### RF002 — Login social Google
- O sistema deve permitir autenticação utilizando conta Google através do fluxo OAuth2.
- Em caso de cancelamento da autenticação Google o sistema deve retornar o usuário para a tela de login sem gerar sessão autenticada.

### RF003 — Formulário de autenticação
- O sistema deve exibir campos de e-mail, senha e botão “Entrar”.
- O formulário deve permitir autenticação manual utilizando e-mail e senha.

### RF004 — Validação de e-mail
- O sistema deve validar o campo de e-mail durante o processo de autenticação.
- O sistema não deve permitir autenticação enquanto o campo de e-mail possuir erros de validação.

### RF005 — Validação de senha
- O sistema deve validar o campo de senha durante o processo de autenticação.
- O sistema não deve permitir autenticação enquanto o campo de senha possuir erros de validação.

### RF006 — Visualização de senha
- O sistema deve permitir visualizar e ocultar o conteúdo do campo de senha.

### RF007 — Controle do botão de login
- O botão “Entrar” deve permanecer desabilitado enquanto os campos obrigatórios estiverem vazios.
- Exibir indicador de progresso (loading) durante o processo de autenticação.

### RF008 — Autenticação
- Gerar sessão autenticada para credenciais válidas.
- Armazenar a sessão autenticada localmente utilizando `Flutter Secure Storage`.

### RF009 — Tratamento de erro
- Mensagem padrão: `Ops! Não foi possível acessar a aplicação. Tente novamente mais tarde.`
- Credenciais inválidas: `E-mail ou senha inválidos.`
- Sem conexão: Exibir mensagem informando indisponibilidade de rede.

### RF010 — Persistência de sessão
- Verificar existência de sessão válida através de `checkSession()`.
- Restaurar sessão persistida com `restoreSession()`.

### RF011 — Validação de sessão
- Permitir acesso apenas para usuários autenticados via estado `isAuthenticated`.

### RF012 — Logout
- Permitir encerramento da sessão através do método `signOut()`.

---

## Regras de Negócio

- **RN001 — Validade da sessão**: Sessões permanecem válidas enquanto existir autenticação ativa no dispositivo.
- **RN002 — Acesso protegido**: Usuários não autenticados não acessam funcionalidades protegidas.
- **RN003 — Logout**: O logout limpa obrigatoriamente os tokens locais.
- **RN004 — Cancelamento Google**: Não gera sessão se o fluxo Google for cancelado.
- **RN005 — Validação obrigatória**: Autenticação bloqueada se houver erros de validação ativos.

---

## Critérios do MVP

- [x] CRUD de autenticação funcional (E-mail/Senha).
- [x] Login Social com Google.
- [x] Persistência de sessão em armazenamento seguro.
- [x] Tratamento de erros amigável para o usuário.

---

## Dependências externas

- **Supabase**: Autenticação e gerenciamento de sessão.
- **OAuth 2.0**: Fluxo de autenticação social Google.
- **Flutter Secure Storage**: Armazenamento seguro de tokens.
