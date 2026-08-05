# FN0001 | Autenticar Usuário

## Objetivo
Permitir que o usuário se autentique na aplicação para acessar as funcionalidades protegidas, utilizando credenciais de e-mail e senha ou conta Google.

## Escopo
Este documento cobre o fluxo de login manual, login social com Google, persistência de sessão e logout.

## Atores
- **Usuário**: Pessoa que deseja acessar o aplicativo.

## Fluxo Principal
1. O usuário acessa a tela de Login.
2. O usuário escolhe entre login manual (e-mail/senha) ou login social (Google).
3. No login manual, o sistema valida os campos localmente.
4. O sistema solicita a autenticação ao provedor (Supabase).
5. O sistema processa o retorno da autenticação.
6. Em caso de sucesso, o sistema persiste a sessão e redireciona o usuário para a Home.

## Fluxo MVVM
1. **View** (`LoginPage`): Captura os inputs e aciona a `AuthViewModel`.
2. **ViewModel** (`AuthViewModel`): Valida os dados e solicita a operação ao `AuthRepository`. Gerencia os estados de `loading`, `error` e `success`.
3. **Repository** (`AuthRepository`): Realiza a chamada ao Supabase e retorna os dados do usuário ou exceções.

## Responsabilidades das Camadas
- **View**: Renderização da UI, captura de eventos de clique e navegação.
- **ViewModel**: Controle de estado reativo e validação de regras de negócio de interface.
- **Repository**: Comunicação com o Supabase Auth e gerenciamento do `FlutterSecureStorage` para tokens.

## Requisitos Funcionais

### RF001 — Acesso à tela de login
- O sistema deve disponibilizar a tela de login como rota inicial (`/`).
- Usuários já autenticados devem ser redirecionados automaticamente para a `/home`.

### RF002 — Autenticação com E-mail e Senha
- O sistema deve permitir o login informando e-mail e senha cadastrados.

### RF003 — Login Social (Google)
- O sistema deve permitir a autenticação via conta Google (OAuth2).
- Caso o usuário cancele o fluxo do Google, o sistema deve retornar à tela de login sem erro fatal.

### RF004 — Validação de Campos
- O e-mail deve ser obrigatório e em formato válido.
- A senha deve ser obrigatória e ter no mínimo 8 caracteres.

### RF005 — Persistência de Sessão
- O sistema deve manter o usuário logado entre reinicializações do app através do armazenamento seguro de tokens.

### RF006 — Logout
- O sistema deve permitir o encerramento da sessão, limpando os dados locais e redirecionando para a tela de login.

## Requisitos Não Funcionais

### RNF001 — Segurança
- As credenciais devem ser trafegadas e armazenadas de forma segura via Supabase.
- Tokens de sessão devem ser armazenados no `Flutter Secure Storage`.

### RNF002 — Performance
- A validação de campos deve ser instantânea (local).
- O feedback de loading deve ser exibido durante a comunicação com o servidor.

## Regras de Negócio

- **RN001 — Bloqueio de Acesso**: Nenhuma funcionalidade além de Login e Cadastro pode ser acessada sem uma sessão válida.
- **RN002 — Unicidade de Sessão**: Cada login gera uma nova sessão válida no dispositivo atual.
- **RN003 — Tratamento de Credenciais Inválidas**: O sistema não deve informar se o erro foi especificamente no e-mail ou na senha por questões de segurança (usar mensagem genérica).

## Estados da Funcionalidade
- **Deslogado**: Estado inicial.
- **Autenticando (Loading)**: Aguardando resposta do Supabase.
- **Autenticado**: Sessão ativa e acesso liberado.
- **Erro de Autenticação**: Exibição de mensagem de falha.

## Tratamento de Erros
- **Credenciais Inválidas**: Mensagem amigável de e-mail ou senha incorretos.
- **Erro de Conexão**: Mensagem informando falta de internet.
- **Erro Genérico**: "Ops! Algo deu errado. Tente novamente mais tarde."

## Navegação
- **Login → Cadastro**: Via link "Criar conta".
- **Login → Home**: Após sucesso na autenticação.

## Dependências Externas
- **Supabase Auth**: Serviço de autenticação.
- **Flutter Secure Storage**: Persistência local segura.
