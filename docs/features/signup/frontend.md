# Frontend — Documentação Visual da Tela de Cadastro

## Funcionalidade Relacionada
FN0002 | Gerenciar Usuário

---

# Objetivo da Tela
Permitir que novos usuários criem uma conta no aplicativo Dia A Dia de forma simples, rápida e intuitiva.

A tela foi projetada com foco em:
- baixa fricção no onboarding;
- experiência mobile otimizada;
- suporte visual para coleta segura de dados cadastrais.

---

# Status da Tela

| Item | Status |
| --- | --- |
| Estrutura visual | ✔ Definida |
| Fluxo visual | ✔ Definido |
| UX inicial | ✔ Definida |
| Responsividade | ✔ Considerada |
| Produção final | ❌ Em andamento |

---

# Preview da Estrutura Visual

![tela-cadastro](/assets/FN0002_tela_cadastro.png)

---

## Link do Figma
> [!TIP]
> Consulte o design system e protótipos interativos no Figma para detalhes de cores e tipografia.

---

# Estrutura Visual Geral
A tela segue uma hierarquia vertical clara:

```
AuthHeader
  ↓
Título "Criar Conta"
  ↓
Subtítulo
  ↓
Card de Cadastro
  ├── Nome
  ├── Sobrenome
  ├── E-mail
  ├── Senha
  ├── Confirmar Senha
  └── Botão Criar Conta
  ↓
Divisor "ou"
  ↓
Botão Continuar com Google
  ↓
Link "Já possui uma conta? Fazer Login"
```

# Hierarquia Visual
Ordem de atenção projetada para o usuário:
1. Header (Logo, título e subtítulo).
2. Formulário de cadastro.
3. Botão Criar Conta (ação principal).
4. Botão Continuar com Google (ação secundária).
5. Link Fazer Login (navegação).

---

# Header
- **Estrutura**: Logo centralizada seguida de título de destaque e subtítulo contextual.
- **Objetivo**: Introduzir o usuário ao fluxo de criação de conta.
- **Componente utilizado**: `AuthHeader`.

---

# Navegação Superior
- **Botão Voltar**: Ícone de seta ou texto "Voltar".
- **Comportamento visual**: Localizado no topo para permitir o cancelamento do fluxo de cadastro e retorno à tela anterior.

---

# Card de Cadastro
- **Objetivo**: Agrupar visualmente os campos do formulário para reduzir a carga cognitiva.
- **Características visuais**: 
    - Bordas arredondadas (24px).
    - Leve elevação (sombra).
    - Padding interno generoso (24px) para melhor leitura.

---

# Campos do Formulário

### Campo Nome
- **Placeholder**: `João`
- **Objetivo**: Identificar o usuário no sistema.
- **Comportamento visual**: Exibe rótulo e fornece feedback visual de erro abaixo do campo.

### Campo Sobrenome
- **Placeholder**: `Silva`
- **Objetivo**: Complementar a identificação nominal.
- **Comportamento visual**: Segue o padrão visual do campo de nome.

### Campo E-mail
- **Placeholder**: `seu@email.com`
- **Objetivo**: Definir a identificação única da conta.
- **Comportamento visual**: Configurado com teclado especializado para entrada de e-mail.

### Campo Senha
- **Placeholder**: `Mínimo 8 caracteres`
- **Objetivo**: Definição segura da credencial de acesso.
- **Comportamento visual**: Texto oculto por padrão com ícone lateral para alternar visibilidade.

### Campo Confirmar Senha
- **Placeholder**: `Digite a senha novamente`
- **Objetivo**: Evitar erros de digitação na criação da senha.
- **Comportamento visual**: Mesmo padrão visual e comportamento de toggle do campo de senha.

---

# Botão Principal
- **Estrutura**: Botão de largura total com texto centralizado "Criar Conta".
- **Componente**: `PrimaryButton`.
- **Estados visuais**:
    - **Idle**: Interativo e com cor de destaque.
    - **Disabled**: Opacidade reduzida indicando bloqueio por validação.
- **Loading**: Substitui o texto por um spinner (`primaryButtonLoading`) e impede múltiplos cliques.

---

# Cadastro com Google
- **Estrutura**: Botão secundário com ícone do provedor social.
- **Objetivo**: Facilitar o acesso através de contas existentes.
- **Observações visuais**: Padronizado conforme diretrizes de branding do provedor.

---

# Divisor Visual
- **Estrutura**: Linha horizontal com o texto "OU" centralizado.
- **Objetivo**: Separar de forma elegante os métodos de cadastro (Manual vs Social).

---

# Navegação Inferior
- **Estrutura**: Texto informativo "Já possui uma conta?" seguido do link "Fazer Login".
- **Objetivo**: Facilitar o fluxo de retorno para usuários que já possuem acesso.

---

# Estados Visuais

### Idle
Tela em estado neutro, aguardando entrada de dados.

### Loading
Estado ativo durante o processamento do cadastro, com indicadores visuais no botão principal.

### Erro
Exibição de mensagens de feedback visual em cores de alerta (vermelho) abaixo dos respectivos campos ou de forma global via `ErrorMessage`.

### Sucesso
Feedback visual positivo (opcional) seguido de transição automática para a tela principal (Home).

---

# Funcionalidades Visuais do MVP
- **Toggle de Senha**: Ações para mostrar/ocultar caracteres nos campos de segurança.
- **Loading Progress**: Feedback visual de operação em andamento.
- **Validações Inline**: Mensagens de erro apresentadas diretamente no contexto do campo.
- **Navegação Intuitiva**: Links claros para transição entre fluxos de Login e Cadastro.

---

# Melhorias Futuras de Interface
- **Indicador de Força**: Barra visual indicando a complexidade da senha digitada.
- **Micro-interações**: Animações de sucesso ao concluir etapas do formulário.

---

# Componentização
Widgets reutilizáveis aplicados na construção da interface:
- **AuthHeader**: Identidade e títulos.
- **AuthCard**: Container de destaque.
- **AuthTextField**: Inputs padronizados.
- **PrimaryButton**: Ação principal de confirmação.
- **SocialLoginButton**: Acesso via provedores sociais.
- **ErrorMessage**: Feedback visual de falhas.
- **OrDivider**: Divisor de fluxos.

---

# Compatibilidade Flutter
| Critério | Avaliação |
| --- | --- |
| Responsividade | Alta (Suporte a diferentes tamanhos de tela) |
| Acessibilidade | Uso de Keys e labels apropriados |
| Performance | Renderização otimizada com componentes leves |

---

# Objetivo do MVP (Visão de Interface)
Garantir que a primeira interação do novo usuário seja fluida, visualmente consistente com o restante da aplicação e que ofereça feedback imediato a cada ação realizada no formulário.
