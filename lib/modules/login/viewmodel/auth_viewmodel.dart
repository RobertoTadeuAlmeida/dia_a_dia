import 'package:flutter/foundation.dart';
import 'package:dia_a_dia/modules/login/models/auth_status.dart';
import 'package:dia_a_dia/modules/login/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../users/models/user_model.dart';

/// Responsável pelo estado e fluxo de autenticação.
///
/// Responsabilidades:
/// - Verificar sessão ao iniciar o app
/// - Realizar login com e-mail/senha e Google
/// - Realizar logout
/// - Manter o estado da autenticação via [AuthStatus]
/// - Disponibilizar o usuário autenticado
/// - Expor mensagens de erro para a UI

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repository;

  AuthViewModel({required AuthRepository repository})
    : _repository = repository;

  // ─── Estado ────────────────────────────────────────────────────────────────

  /// Estado atual da autenticação.
  ///
  /// Utilizado pela View para controlar:
  /// - loading
  /// - navegação
  /// - mensagens de erro

  AuthStatus _status = AuthStatus.initial;

  AuthStatus get status => _status;

  /// Última mensagem de erro disponível para a UI.
  ///
  /// Deve ser consumida pela View e posteriormente
  /// limpa através de [clearError].
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  // TODO(FN0002):
  // Usuário autenticado será carregado após
  // implementação do módulo User.
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  /// Indica se existe uma sessão autenticada.
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  // ─── Sessão ─────────────────────────────────────────────────────────────────

  /// Verifica e restaura sessão ao iniciar o app.
  /// Deve ser chamado no `initState` do widget raiz ou no splash.
  Future<void> checkSession() async {
    /// TODO(FUTURO):
    /// Validar explicitamente o resultado da restauração
    /// da sessão quando houver gerenciamento avançado
    /// de autenticação.
    try {
      _setStatus(AuthStatus.loading);
      if (await _repository.hasValidSession()) {
        await _repository.restoreSession();
        _setStatus(AuthStatus.authenticated);
      } else {
        _setStatus(AuthStatus.unauthenticated);
      }
    } on Exception catch (e) {
      _setError(_getErrorMessage(e));
    }
  }

  // ─── Login ──────────────────────────────────────────────────────────────────

  /// Autentica com e-mail e senha.
  /// Recebe os campos já validados pela View.
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      _setStatus(AuthStatus.loading);
      await _repository.signInWithEmailAndPassword(email, password);
      _setStatus(AuthStatus.authenticated);
    } on Exception catch (e) {
      _setError(_getErrorMessage(e));
    }
  }

  /// Autentica via Google OAuth2.
  /// Cancelamento pelo usuário não deve exibir mensagem de erro.
  Future<void> signInWithGoogle() async {
    try {
      _setStatus(AuthStatus.loading);

      await _repository.signInWithGoogle();

      _setStatus(AuthStatus.authenticated);
    } on Exception catch (e) {
      final message = _getErrorMessage(e);
      if (message == 'autenticacao_cancelada') {
        _setStatus(AuthStatus.unauthenticated);
      } else {
        _setError(message);
      }
    }
  }

  // ─── Logout ─────────────────────────────────────────────────────────────────

  /// Encerra a sessão autenticada.
  Future<void> signOut() async {
    try {
      _setStatus(AuthStatus.loading);
      await _repository.signOut();
      _currentUser = null;
      _setStatus(AuthStatus.unauthenticated);
    } on Exception catch (e) {
      _setError(_getErrorMessage(e));
    }
  }

  // ─── Helpers privados ───────────────────────────────────────────────────────

  void _setStatus(AuthStatus status) {
    _status = status;
    _errorMessage = null;

    notifyListeners();
  }

  void _setError(String message) {
    _status = AuthStatus.error;
    _errorMessage = message;
    notifyListeners();
  }

  String _getErrorMessage(Exception e) {
    return e.toString().replaceFirst('Exception: ', '');
  }

  /// Remove a mensagem de erro atual.
  ///
  /// Utilizado pela View após exibir Snackbar
  /// ou Dialog de erro.
  void clearError() {
    if (_errorMessage == null) return;

    _errorMessage = null;
    notifyListeners();
  }
}
