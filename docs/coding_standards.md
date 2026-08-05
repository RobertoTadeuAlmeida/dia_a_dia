# Coding Standards — Dia A Dia

Este documento define as diretrizes técnicas e padrões de desenvolvimento do projeto **Dia A Dia**. O objetivo é garantir consistência, legibilidade e facilidade de manutenção por desenvolvedores e ferramentas de IA.

## Arquitetura

O projeto utiliza o padrão **MVVM (Model-View-ViewModel)** aliado ao **Repository Pattern**.

- **Model**: Representação dos dados e lógica de mapeamento (JSON/Entities).
- **View**: Telas (Pages) e componentes visuais (Widgets). Responsável pela interface e navegação.
- **ViewModel**: Gerenciador de estado da tela. Responsável por validar inputs, processar lógica de negócio e comunicar-se com o Repository.
- **Repository**: Camada de abstração de dados (Supabase, Local Storage, APIs externas).

> [!IMPORTANT]
> O projeto prioriza simplicidade e não deve adicionar camadas, abstrações ou padrões arquiteturais (como Clean Architecture ou Use Cases) sem necessidade real para o escopo atual.

## Gerenciamento de Estado

Utilizamos o **Provider** para o gerenciamento de estado reativo.
As ViewModels herdam de `ChangeNotifier` para notificar a View sobre alterações de estado.

## Modularização

A organização é feita por **Feature (Funcionalidade)** dentro do diretório `lib/modules/`. Cada módulo deve seguir a estrutura:

```text
module_name/
├── models/
├── repositories/
├── view/
│   ├── pages/
│   └── widgets/
└── viewmodel/
```

Recursos globais e compartilhados ficam em `lib/core/` ou `lib/shared/`.

## Naming Conventions

- **Arquivos**: `snake_case.dart` (ex: `login_page.dart`).
- **Classes**: `PascalCase` (ex: `AuthRepository`).
- **Métodos e Variáveis**: `camelCase` (ex: `signInWithEmail()`).
- **Variáveis Privadas**: Devem iniciar com underline (ex: `_isLoading`).

## Nomenclatura Técnica (Exemplos)

- **ViewModels**: Deve terminar com `ViewModel` (ex: `SignupViewModel`).
- **Repositories**: Deve terminar com `Repository` (ex: `AuthRepository`).
- **Páginas**: Deve terminar com `Page` (ex: `LoginPage`).

## Organização de Arquivos (Interno)

1. Imports (Organizados por pacotes e relativos)
2. Constantes/Enums
3. Classe Principal
    - Propriedades (Privadas primeiro)
    - Construtor
    - Métodos Públicos
    - Métodos Privados/Helpers

## Widgets Reutilizáveis

Componentes que aparecem em múltiplas telas devem ser movidos para `lib/core/widgets/` ou `lib/shared/widgets/`.
Exemplos existentes:
- `PrimaryButton`
- `AuthTextField`
- `ErrorMessage`

## Uso de AppKeys

Todas as chaves para testes e automação devem ser centralizadas em `lib/core/constants/app_keys.dart`.
**Nunca** declare strings de Key diretamente nos Widgets.

## Navegação

A navegação deve utilizar as rotas nomeadas definidas em `lib/core/routes/route_names.dart` e gerenciadas em `lib/core/routes/app_routes.dart`.

## Tratamento de Erros e Validações

- Validações de formulário devem ser centralizadas em utilitários de validação (ex: `LoginValidators`).
- Mensagens de erro devem ser amigáveis e gerenciadas pela ViewModel, sendo exibidas na View via componentes padronizados.

## Testes

- **Unitários**: Focados na lógica das ViewModels e Repositories.
- **Widget Tests**: Focados na UI, garantindo que componentes renderizem corretamente e reajam a estados.
- Utilizamos o pacote **Mocktail** para criação de mocks de dependências.

## Boas Práticas

- **Don't Repeat Yourself (DRY)**: Reutilize widgets e lógica sempre que possível.
- **Simplicidade**: Código legível é melhor do que código "esperto".
- **Comentários**: Use apenas para explicar o "porquê" de decisões complexas, não o "quê".
