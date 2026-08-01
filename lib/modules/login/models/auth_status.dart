/// Representa o estado atual do fluxo de autenticação.
///
/// Utilizado pela ViewModel para informar a View
/// sobre carregamento, sucesso, falha ou ausência
/// de sessão autenticada.
enum AuthStatus {
  /// Estado inicial da ViewModel.
  initial,

  /// Operação em andamento.
  loading,

  /// Usuário autenticado.
  authenticated,

  /// Usuário não autenticado.
  unauthenticated,

  /// Erro durante uma operação de autenticação.
  error,
}