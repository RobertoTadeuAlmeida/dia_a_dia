# Frontend — Documentação Visual da Tela de Login

## Funcionalidade Relacionada
FN0001 | Autenticar Usuário

---

# Objetivo da Tela
Permitir que o usuário realize autenticação no aplicativo Dia A Dia de forma rápida, intuitiva e visualmente limpa.

---

# Interface (Wireframe)

![tela-login](/assets/FN0001_tela_login.png)

## Link do Figma
> [!TIP]
> Consulte o design system e protótipos interativos no Figma do projeto.

---

# Estrutura Visual
A tela é composta pela seguinte hierarquia:

1. **Background**: Gradiente suave para criar identidade visual moderna e destacar o card principal.
2. **Header**: Branding e contexto inicial.
3. **Card de Autenticação**: Agrupador central do formulário e ações.
4. **Formulário**: Inputs de coleta de dados.
5. **Ações Sociais**: Alternativa de login rápido.
6. **Navegação Secundária**: Links de transição para outras telas de acesso.

---

# Estrutura Técnica (Widget Tree)
```
Scaffold (AppKeys.loginPage)
 └── SafeArea
      └── SingleChildScrollView
           └── Padding
                └── Column
                     ├── AuthHeader
                     ├── Form
                     │    └── LoginCard
                     │         └── AuthCard
                     │              └── Column
                     │                   ├── AuthTextField (Email)
                     │                   ├── AuthTextField (Senha)
                     │                   ├── PrimaryButton
                     │                   ├── OrDivider
                     │                   └── SocialLoginButton
                     └── ErrorMessage
                     └── _SignUpText (GestureDetector)
```

---

# Componentização (Reutilizáveis)

### AuthHeader
- **Responsabilidade**: Exibir branding (logo) e títulos de boas-vindas.
- **Keys**: `authLogo`, `authTitle`, `authSubtitle`.

### AuthCard
- **Responsabilidade**: Container com bordas arredondadas (24px), leve elevação e padding amplo para destacar o conteúdo central.
- **Keys**: `authCard`.

### AuthTextField
- **Responsabilidade**: Campo de entrada com suporte a ícones internos, label flutuante e feedback visual de erro.
- **Configurações de UX**:
    - Suporte a teclado especializado (E-mail, Numérico, etc.).
    - Opção de mostrar/ocultar senha (toggle visual).
- **Keys**: `authTextFieldLabel`, `authTextFieldPrefixIcon`, `authTextFieldPasswordToggle`, `authTextFieldError`.

### PrimaryButton
- **Responsabilidade**: Call to Action (CTA) principal com estados visuais de interação.
- **Estados Visuais**:
    - **Idle**: Botão ativo pronto para clique.
    - **Loading**: Exibe spinner (`primaryButtonLoading`) e bloqueia interação.
    - **Disabled**: Estilização opaca indicando indisponibilidade.

### OrDivider
- **Responsabilidade**: Divisor visual horizontal com texto central para separação de fluxos de login.

---

# Estados Visuais da Tela

### Idle (Inativo)
Tela pronta para interação inicial do usuário, com foco no primeiro campo de entrada.

### Loading (Carregando)
- Botão "Entrar" exibe indicador de progresso.
- Interações de input permanecem permitidas, mas submissões consecutivas são bloqueadas.

### Erro (Visual)
- Mensagens de erro exibidas inline abaixo do respectivo campo ou acima do botão principal utilizando o widget `ErrorMessage`.

---

# UX e Responsividade
- **Suporte ao Teclado**: O layout utiliza `SingleChildScrollView` para evitar que o teclado oculte os campos de input.
- **Densidade de Tela**: Espaçamentos flexíveis para adaptação em dispositivos de diferentes tamanhos (celulares pequenos a tablets).
- **Acessibilidade**: Uso de `AppKeys` em todos os elementos interativos para facilitar automação e leitores de tela.

---

# Espaçamentos Recomendados
| De → Para | Espaço |
| --- | --- |
| Header → Card | 32 px |
| Input → Input | 16 px |
| Card Interno (Padding) | 24 px |
| Formulário → Botão | 24 px |
| Botão → Divider | 32 px |
| Divider → Google | 24 px |
