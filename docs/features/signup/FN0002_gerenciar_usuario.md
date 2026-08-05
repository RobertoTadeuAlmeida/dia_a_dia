# FN0002 | Gerenciar Usuário (Cadastro)

## Objetivo
Permitir que novos usuários criem uma conta no sistema fornecendo seus dados básicos, garantindo o acesso às funcionalidades do Dia A Dia.

## Escopo
Este documento foca exclusivamente na criação de novos usuários via e-mail e senha. Outras ações de gerenciamento (perfil, exclusão) são planejadas para futuras iterações.

## Atores
- **Usuário**: Pessoa sem conta que deseja se registrar.

## Fluxo Principal
1. O usuário acessa a tela de Cadastro através da tela de Login.
2. O usuário preenche Nome, Sobrenome, E-mail e Senha.
3. O usuário confirma a senha informada.
4. O sistema valida a consistência dos dados localmente.
5. O sistema solicita a criação da conta ao Supabase.
6. Em caso de sucesso, o sistema autentica o usuário automaticamente e o redireciona para a Home.

## Fluxo MVVM
1. **View** (`SignupPage`): Captura os dados e observa o estado da `SignupViewModel`.
2. **ViewModel** (`SignupViewModel`): Realiza validações de formato e correspondência de senhas. Aciona o Repository para criação.
3. **Repository** (`AuthRepository`): Executa o `signUp` no Supabase e persiste os metadados (nome/sobrenome).

## Responsabilidades das Camadas
- **View**: Coleta de dados e feedback visual de progresso.
- **ViewModel**: Lógica de validação (ex: senhas iguais) e controle de estado de submissão.
- **Repository**: Interface com o provedor de autenticação e tratamento de exceções de banco (e-mail duplicado).

## Requisitos Funcionais

### RF001 — Formulário de Cadastro
- O sistema deve solicitar: Nome, Sobrenome, E-mail, Senha e Confirmação de Senha.

### RF002 — Validação de Dados
- **Nome/Sobrenome**: Obrigatórios, mínimo de 2 caracteres.
- **E-mail**: Obrigatório, formato válido.
- **Senha**: Obrigatória, mínimo de 8 caracteres.
- **Confirmação**: Deve ser idêntica à senha.

### RF003 — Autenticação Automática
- Após o cadastro bem-sucedido, o sistema deve realizar o login automático do usuário.

### RF004 — Verificação de E-mail Duplicado
- O sistema deve impedir o cadastro caso o e-mail já esteja em uso, informando o usuário.

### RF005 — Redirecionamento Pós-Cadastro
- O usuário deve ser enviado para a tela Home imediatamente após o registro bem-sucedido.

## Requisitos Não Funcionais

### RNF001 — Segurança
- As senhas não devem ser armazenadas localmente em texto plano.
- O cadastro deve ser feito sobre conexão segura (HTTPS).

### RNF002 — UX (User Experience)
- O botão de cadastro deve permanecer desabilitado enquanto o formulário estiver incompleto ou inválido.

## Regras de Negócio

- **RN001 — Unicidade de E-mail**: Um e-mail só pode estar vinculado a uma conta ativa.
- **RN002 — Tratamento de Espaços**: O sistema deve remover espaços em branco no início e fim de nomes e e-mails antes de processar.
- **RN003 — Identificador Único**: Cada usuário cadastrado recebe um UUID único gerado pelo Supabase.

## Estados da Funcionalidade
- **Aguardando Preenchimento**: Estado inicial com formulário vazio.
- **Processando Cadastro**: Enviando dados para o servidor.
- **Cadastro Concluído**: Transição para a Home.
- **Falha no Cadastro**: Exibição da causa do erro (ex: e-mail em uso).

## Tratamento de Erros
- **E-mail já existente**: "Este e-mail já está cadastrado."
- **Senhas divergentes**: "As senhas não coincidem."
- **Erro de Conexão**: "Sem conexão com a internet."

## Navegação
- **Cadastro → Home**: Após sucesso no registro.

## Dependências Externas
- **Supabase Auth & Database**: Criação de usuário e armazenamento de metadados.
- **Flutter Secure Storage**: Persistência da sessão inicial gerada.
