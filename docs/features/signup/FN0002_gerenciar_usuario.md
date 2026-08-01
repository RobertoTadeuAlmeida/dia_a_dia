# FN0002 | Gerenciar Usuário

## Objetivo

Permitir que o usuário crie uma conta de acesso à aplicação através da tela de cadastro, informando nome, e-mail e senha válidos.

Esta versão da FN0002 contempla exclusivamente o fluxo de criação manual de usuário (e-mail e senha) — a criação de conta via Google já é tratada na FN0001 (RF002). Demais ações de gerenciamento de conta (edição de perfil, alteração de senha, exclusão de conta) ficam para revisões futuras desta FN.

---

## Atores

- Usuário

---

## Fluxo Principal

1. Usuário acessa a tela de cadastro.
2. Usuário informa nome, e-mail, senha e confirmação de senha.
3. Sistema valida os campos.
4. Sistema realiza a criação do usuário.
5. Sistema retorna sucesso ou erro.
6. Usuário cadastrado é autenticado automaticamente e redirecionado para a tela inicial.

---

## Fluxo MVVM

#### Diagrama

!image.png

#### Sequência

1. Usuário preenche os dados de cadastro.
2. View aciona o método de cadastro.
3. ViewModel valida os campos informados.
4. ViewModel solicita a criação do usuário ao Repository.
5. Repository realiza a comunicação com o Supabase.
6. Supabase cria o usuário e retorna sucesso ou erro.
7. Repository retorna o resultado ao ViewModel.
8. ViewModel atualiza o estado da interface.
9. View reage ao novo estado.
10. Em caso de sucesso, o usuário é autenticado e redirecionado para a Home.

#### Responsabilidade

| Camada | Responsabilidade |
| --- | --- |
| View | Exibir a interface de cadastro e capturar as ações do usuário |
| ViewModel | Gerenciar estados, validações e fluxo da funcionalidade de cadastro |
| Repository | Realizar a criação do usuário e comunicação com os serviços de autenticação |
| Supabase | Autenticação, armazenamento e gerenciamento dos dados do usuário |

---

## Wireframes

Wireframe — Tela Cadastro

---

## Requisitos funcionais

### RF001 — Exibir tela de cadastro

- O sistema deve disponibilizar a tela de cadastro através da rota `/signup`.
- O sistema deve exibir uma opção de criação de conta na tela de login.
- Ao selecionar a opção de criação de conta, o usuário deve ser direcionado para a rota `/signup`.
- Apenas usuários não autenticados podem acessar a tela de cadastro.
- Caso um usuário autenticado tente acessar a rota `/signup`, o sistema deve redirecioná-lo automaticamente para a rota `/home`.

---

### RF002 — Formulário de cadastro

- O sistema deve exibir um formulário de cadastro contendo:
- Nome
- Sobrenome
- E-mail
- Senha
- Confirmação de senha
- Botão cadastrar
- O sistema deve permitir que o usuário informe os dados necessários para criação da conta.
- Ao selecionar o botão cadastrar, o sistema deve iniciar o processo de cadastro.

---

### RF003 — Validação de nome de usuário

- O sistema deve validar o campo de nome durante o processo de cadastro.
- O campo de nome deve:
- Ser de preenchimento obrigatório.
- Possuir no mínimo 2 caracteres após a remoção dos espaços em branco no início e no final do texto.
- Antes da validação, o sistema deve remover os espaços em branco existentes no início e no final do valor informado.
- Enquanto o campo de nome possuir erros de validação, o sistema não deve permitir a conclusão do cadastro.

**Mensagens de validação:**

`Nome obrigatório.`

`O nome deve possuir no mínimo 2 caracteres.`

---

### **RF004 — Validação de sobrenome do usuário**

- O sistema deve validar o campo de sobrenome durante o processo de cadastro.
- O campo de sobrenome deve:
- Ser de preenchimento obrigatório.
- Possuir no mínimo 2 caracteres após a remoção dos espaços em branco no início e no final do texto.
- Antes da validação, o sistema deve remover os espaços em branco existentes no início e no final do valor informado.
- Enquanto o campo de sobrenome possuir erros de validação, o sistema não deve permitir a conclusão do cadastro.

**Mensagens de validação:**

`Sobrenome obrigatório.`

`O sobrenome deve possuir no mínimo 2 caracteres.`

---

### RF005 — Validação de e-mail

- O sistema deve validar o campo de e-mail durante o processo de cadastro.
- O campo de e-mail deve:
- Ser de preenchimento obrigatório.
- Possuir formato válido de e-mail.
- Antes da validação, o sistema deve remover os espaços em branco existentes no início e no final do valor informado.
- Enquanto o campo de e-mail possuir erros de validação, o sistema não deve permitir a conclusão do cadastro.

**Mensagens de validação:**

`E-mail obrigatório.`

`Formato de e-mail inválido.`

---

### RF006 — Validação de senha e confirmação de senha

- O sistema deve validar os campos de senha e confirmação de senha durante o processo de cadastro.
- O campo de senha deve:
- Ser de preenchimento obrigatório.
- Possuir no mínimo 8 caracteres.
- O campo de confirmação de senha deve:
- Ser de preenchimento obrigatório.
- Possuir conteúdo idêntico ao campo de senha.
- A validação de correspondência entre senha e confirmação deve ocorrer somente quando ambos os campos estiverem preenchidos e válidos.
- Enquanto os campos de senha ou confirmação de senha possuírem erros de validação, o sistema não deve permitir a conclusão do cadastro.

**Mensagens de validação:**

`Senha obrigatória.`

`A senha deve possuir no mínimo 8 caracteres.`

`Confirmação de senha obrigatória.`

`As senhas não coincidem.`

---

### RF007 — Visualização de senha

- O sistema deve permitir alternar entre a exibição e a ocultação do conteúdo do campo de senha.
- O sistema deve permitir alternar entre a exibição e a ocultação do conteúdo do campo de confirmação de senha.
- Os campos devem permanecer ocultos por padrão ao serem exibidos na tela.
- A ação de visualizar ou ocultar a senha não deve alterar o conteúdo digitado pelo usuário.

---

### RF008 — Controle do botão de cadastro

- O botão “Cadastrar” deve permanecer desabilitado enquanto houver erros de validação nos campos do formulário.
- O botão “Cadastrar” deve ser habilitado somente quando todos os campos estiverem válidos.
- Ao ser acionado, o botão deve iniciar o processo de criação do usuário.
- Durante o processo de criação, o botão deve:
- exibir estado de carregamento (loading);
- permanecer desabilitado até a finalização da operação.
- Após a finalização do processo:
- em caso de sucesso, o sistema deve prosseguir com o fluxo de autenticação;
- em caso de falha, o botão deve retornar ao estado habilitado, respeitando novamente as validações do formulário.

---

### RF009 — Criação de usuário

- O sistema deve criar um novo usuário utilizando e-mail e senha informados.
- O sistema deve armazenar nome e sobrenome como metadados do usuário.
- Após a criação bem-sucedida, o sistema deve gerar uma sessão autenticada automaticamente.
- A sessão autenticada deve permanecer disponível após a criação da conta.
- Após autenticação, o usuário deve ser redirecionado para a rota `/home`.
- O sistema deve exibir a mensagem de sucesso:

```jsx
Cadastro realizado com sucesso.
```

### Regras de falha

- Em caso de falha na criação do usuário:
- o usuário não deve ser criado;
- nenhuma sessão deve ser gerada;
- o usuário não deve ser redirecionado para `/home`.

> ***Esta versão da funcionalidade assume confirmação de e-mail desabilitada no provedor de autenticação.***
>

---

### RF010 — Tratamento de erro

- O sistema deve exibir mensagens apropriadas ao usuário quando ocorrer falha no processo de cadastro.
- O sistema deve tratar os seguintes cenários:

### 1. Erro genérico

- Quando não for possível identificar a causa do erro:

```
Ops! Não foi possível concluir o cadastro. Tente novamente mais tarde.
```

---

### 2. E-mail já cadastrado

- Quando o e-mail informado já existir no sistema:

```
Este e-mail já está cadastrado.
```

---

### 3. Ausência de conexão com internet

- Quando não houver conexão com a internet:

```
Sem conexão com a internet. Verifique sua rede e tente novamente.
```

---

## Regras de estado da aplicação

Em qualquer falha no cadastro, o sistema deve:

- interromper o processo de criação do usuário;
- remover o estado de loading da interface;
- reabilitar o botão “Cadastrar” conforme validação do formulário;
- manter o usuário na tela de cadastro.

---

### RF011 — Navegação para tela de login

- O sistema deve disponibilizar uma ação para retorno à tela de login na tela de cadastro.
- Ao selecionar a ação de retorno, o sistema deve redirecionar o usuário para a rota `/`.
- Ao executar essa ação, o sistema não deve iniciar o processo de criação de usuário.
- O estado atual do formulário de cadastro não deve ser persistido após o redirecionamento.

---

## Requisitos não funcionais

### RNF001 — Segurança

- O sistema deve utilizar o provedor de autenticação (Supabase) para criação e armazenamento seguro das credenciais do usuário.
- A senha do usuário não deve ser armazenada ou exposta em texto plano.
- As sessões autenticadas devem ser persistidas utilizando os mecanismos fornecidos pela solução de autenticação adotada pela aplicação.
- Tokens e dados de autenticação não devem ser expostos visualmente ao usuário.

---

### RNF002 — Performance

- As validações dos campos devem ocorrer localmente antes do envio da requisição de cadastro.
- O sistema deve permanecer responsivo durante o fluxo de cadastro.

---

### RNF003 — Feedback visual

- Mensagens de erro e sucesso devem ser apresentadas de forma clara e legível ao usuário.
- Notificações visuais devem possuir duração entre 2000ms e 3000ms.

---

### RNF004 — Compatibilidade

- O aplicativo deve ser compatível com dispositivos Android suportados pelo Flutter.
- O fluxo de cadastro deve funcionar corretamente em dispositivos Android na orientação retrato.

---

## Regra de negocio

### RN001 — Unicidade de e-mail

- O sistema não deve permitir o cadastro de mais de um usuário com o mesmo e-mail.

---

### RN002 — Autenticação automática após cadastro

- Ao concluir o cadastro com sucesso, o sistema deve autenticar o usuário automaticamente, sem exigir nova inserção de credenciais.

> ***Esta funcionalidade assume confirmação de e-mail desabilitada no provedor de autenticação.***
>

---

### RN003 — Obrigatoriedade dos dados cadastrais

- O usuário deve possuir nome, sobrenome, e-mail e senha para que uma conta possa ser criada.

---

### RN004 — Persistência de sessão autenticada

- Usuários autenticados devem permanecer autenticados entre reinicializações do aplicativo até que realizem logout ou a sessão seja invalidada.

### RN005 — Identificação única do usuário

- Cada conta cadastrada deve possuir um identificador único gerado pelo sistema.

> No Supabase isso será o UUID do usuário.
>

### RN006 — Integridade dos dados cadastrais

- Nome e sobrenome devem ser armazenados exatamente conforme informados pelo usuário após a remoção de espaços em branco excedentes no início e no final do texto.

---

## Dependências externas

- Supabase — criação de usuário, autenticação e persistência de dados do usuário.
- Flutter Secure Storage — armazenamento seguro de tokens e dados de autenticação no dispositivo.