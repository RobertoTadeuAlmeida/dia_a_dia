# Plano de Ação - Refinamento da Documentação FN0001

O objetivo é atualizar a documentação `docs/features/auth/FN0001_autenticar_usuario.md` para refletir exatamente os nomes de métodos e a lógica de fluxo implementada atualmente no projeto (TDD e MVVM).

## User Review Required

> [!IMPORTANT]
> A documentação será ajustada para usar `signInWithEmailAndPassword` e `signInWithGoogle` em vez de um genérico `signIn()`. Também incluirei os métodos de gerenciamento de sessão como `checkSession`.

## Mudanças Propostas

### Documentação

#### [MODIFY] [FN0001_autenticar_usuario.md](file:///home/rtadeu/Dev/FlutterProject/dia_a_dia/docs/features/auth/FN0001_autenticar_usuario.md)
- Atualizar a seção **Fluxo MVVM > Sequência** para:
    - Alterar `signIn()` para `signInWithEmailAndPassword()` e `signInWithGoogle()`.
    - Refletir que a View (`LoginPage`) utiliza `LoginValidators` para a validação visual antes de chamar a ViewModel.
- Revisar as mensagens de erro nos requisitos funcionais (ex: RF009) para alinhar com o que o `AuthRepository` retorna (ex: "Erro inesperado" em vez de uma frase longa).
- Adicionar os nomes dos métodos de persistência na seção RF010: `checkSession`, `hasValidSession` e `restoreSession`.
- Atualizar RF012 para mencionar o método `signOut()`.

## Plano de Verificação

### Verificação Manual
- Comparar o arquivo MD final com as classes `AuthViewModel.dart` e `AuthRepository.dart` para garantir 100% de paridade nos nomes dos métodos.
