# DIA A DIA - COPILOT INSTRUCTIONS

## Projeto
Aplicativo Flutter chamado: **Dia A Dia**  
Slogan: *"Seu dia mais organizado"*

---

## Stack Técnico

- Flutter: 3.44.0
- Dart: compatível com Flutter 3.44.0
- Gerenciamento de estado: `provider: ^6.1.5+1` com `ChangeNotifier`
- Backend: Supabase (ainda não configurado — não implementar ainda)
- Persistência local: `shared_preferences`
- HTTP: `http` ou `dio` (para APIs externas como previsão do tempo)

### Pacotes principais
- `provider: ^6.1.5+1`
- `supabase_flutter` (quando configurado)
- `shared_preferences`
- `intl`
- `equatable`
- `uuid`
- `google_fonts`
- `cached_network_image`
- `mocktail` (testes)

---

## Objetivo do Projeto

Aplicativo organizador de rotina com:
- Tarefas
- Compromissos
- Previsão do tempo
- Produtividade

---

## Arquitetura

- MVVM
- Provider com ChangeNotifier
- Modularização por feature
- Repository Pattern simples

### NÃO utilizar
- Clean Architecture
- Overengineering
- Abstrações desnecessárias
- Padrões enterprise complexos
- Código extremamente genérico
- Múltiplas camadas desnecessárias

---

## Estrutura de Pastas

```
lib/
├── core/
│   ├── theme/
│   │   └── theme.dart
│   ├── widgets/
│   └── enums/
│       └── view_state.dart
└── modules/
    ├── login/
    │   ├── models/
    │   ├── viewmodel/
    │   ├── view/
    │   │   ├── pages/
    │   │   └── widgets/
    │   ├── repositories/
    │   └── services/
    ├── users/
    │   └── (mesma estrutura)
    ├── tasks/
    │   └── (mesma estrutura)
    ├── weather/
    │   └── (mesma estrutura)
    └── home/
        └── (mesma estrutura)
```

### Regras de estrutura
- Todo arquivo de tema fica em `core/theme/`
- Widgets compartilhados entre módulos ficam em `core/widgets/`
- Enums globais ficam em `core/enums/`
- Cada módulo é autossuficiente — não importar de outro módulo diretamente

---

## Convenções de Nomenclatura

### Arquivos
- snake_case para todos os arquivos: `task_viewmodel.dart`, `task_model.dart`
- Sufixos obrigatórios: `_model`, `_viewmodel`, `_repository`, `_service`, `_page`, `_widget`

### Classes
- PascalCase: `TaskViewModel`, `TaskModel`, `TaskRepository`
- Pages: sufixo `Page` → `TaskPage`
- Widgets: sufixo `Widget` ou nome descritivo → `TaskCardWidget`, `TaskListWidget`
- ViewModels: sufixo `ViewModel` → `TaskViewModel`
- Repositories: sufixo `Repository` → `TaskRepository`

### Variáveis e métodos
- camelCase: `loadTasks()`, `isLoading`, `errorMessage`
- Privados com underscore: `_tasks`, `_state`

---

## Padrão de Estado de Telas

Todas as telas usam o enum `ViewState` definido em `core/enums/view_state.dart`.

```dart
// core/enums/view_state.dart
enum ViewState { idle, loading, success, error }
```

### Implementação no ViewModel

```dart
class TaskViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  Future<void> loadTasks() async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      _tasks = await _repository.getTasks();
      _state = ViewState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewState.error;
    }

    notifyListeners();
  }
}
```

### Implementação na View

```dart
switch (viewModel.state) {
  case ViewState.loading => const CircularProgressIndicator(),
  case ViewState.error   => ErrorWidget(message: viewModel.errorMessage),
  case ViewState.success => TaskListWidget(tasks: viewModel.tasks),
  case ViewState.idle    => const SizedBox.shrink(),
}
```

---

## ViewModel

Responsável por:
- Estado da tela via `ViewState`
- Validações de formulário
- Fluxo da funcionalidade
- Controle de loading e erros

**Não colocar no ViewModel:**
- Lógica de UI (cores, tamanhos, animações)
- Widgets
- BuildContext (exceto quando absolutamente necessário)

---

## Repository

Responsável por:
- Autenticação (Supabase — quando configurado)
- Persistência local (shared_preferences)
- Acesso ao Supabase
- Chamadas a APIs externas (ex: previsão do tempo)

**Não colocar no Repository:**
- Lógica de negócio
- Estado de tela
- Validações

---

## Model

Responsável apenas por:
- Representar entidades de dados
- Métodos `fromJson` / `toJson`
- `copyWith` quando necessário

Usar `equatable` para comparação de objetos.

**Models NÃO devem:**
- Acessar APIs
- Controlar fluxo
- Executar regras de negócio

---

## Organização da UI

A UI deve ser:
- Moderna e minimalista — poucos elementos por tela, bastante espaço negativo
- Consistente — usar sempre os tokens do `theme.dart` (cores, tipografia, espaçamentos)
- Reutilizável — componentes compartilhados ficam em `core/widgets/`

### Componentização
Criar widgets reutilizáveis quando o mesmo bloco visual aparecer em **2 ou mais lugares**.  
Evitar:
- Abstração prematura (não criar widget para uso único)
- Widgets com mais de uma responsabilidade visual
- Widgets com lógica de negócio

---

## TDD

Priorizar código testável em:
- ViewModels (testar mudanças de estado)
- Validações
- Repositories (com mock via `mocktail`)

Ao gerar um ViewModel ou Repository, sempre gerar também o arquivo de teste correspondente em `test/`.

---

## Prioridades de Desenvolvimento

1. Simplicidade
2. Legibilidade
3. Organização
4. Manutenção

---

## Regra de Implementação

Implementar **apenas o que foi solicitado**.

NÃO inventar:
- Funcionalidades não pedidas
- Integrações extras
- Fluxos adicionais
- Arquitetura além do especificado
- Dependências não listadas no stack técnico