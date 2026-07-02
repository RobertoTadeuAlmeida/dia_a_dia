import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Responsável por autenticação e persistência de sessão.
/// Não contém validações de campos nem lógica de estado de tela.
class AuthRepository {
  final SupabaseClient _supabaseClient;
  final FlutterSecureStorage _secureStorage;

  static const _sessionKey = 'auth_session';

  AuthRepository({
    required SupabaseClient supabaseClient,
    required FlutterSecureStorage secureStorage,
  }) : _supabaseClient = supabaseClient,
       _secureStorage = secureStorage;

  /// Realiza o cadastro de um novo usuário no Supabase.
  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      await _supabaseClient.auth.signUp(
        data: {'name': name, 'last_name': lastName},
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      _handleSignUpError(e);
    } on SocketException {
      _handleNetworkError();
    } catch (e) {
      _handleUnexpectedError(e);
    }
  }

  /// Autentica o usuário com e-mail e senha.
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final token = response.session?.accessToken;

      if (token == null || token.isEmpty) {
        throw Exception('E-mail ou senha inválidos.');
      }

      await _secureStorage.write(key: _sessionKey, value: token);
    } on AuthException catch (e) {
      _handleSignInError(e);
    } on SocketException {
      _handleNetworkError();
    } catch (e) {
      _handleUnexpectedError(e);
    }
  }

  /// Autentica o usuário via Google OAuth2.
  ///
  /// Lança [Exception] com a string 'autenticacao_cancelada' quando o usuário cancela o fluxo.
  /// TODO(FN0001-GOOGLE):
  /// Finalizar captura automática da sessão após
  /// retorno do OAuth.
  ///
  /// Atualmente o fluxo abre o navegador, porém
  /// o callback ainda não retorna corretamente
  /// para o aplicativo.
  Future<void> signInWithGoogle() async {
    try {
      // TODO: validar criação da sessão após retorno do OAuth.
      // Em versões futuras usar authStateChanges para capturar login concluído.
      final response = await _supabaseClient.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.flutter://login-callback',
      );

      if (!response) {
        throw Exception('autenticacao_cancelada');
      }
    } on AuthException {
      throw Exception(_defaultErrorMessage());
    } on SocketException {
      _handleNetworkError();
    } catch (e) {
      if (e.toString().contains('autenticacao_cancelada')) rethrow;
      _handleUnexpectedError(e);
    }
  }

  /// Remove a sessão do Supabase e limpa os dados persistidos localmente.
  Future<void> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
    } catch (_) {
      // Falha no Supabase não impede limpeza local
    } finally {
      await _secureStorage.delete(key: _sessionKey);
    }
  }

  /// Verifica se existe um token salvo localmente.
  ///
  /// Não garante que a sessão ainda seja válida
  /// no servidor.
  ///
  /// TODO(FUTURO):
  /// Substituir a validação baseada em SecureStorage
  /// pela sessão gerenciada pelo próprio Supabase.
  ///
  /// Atualmente o método verifica apenas a existência
  /// de um token persistido localmente. Em versões futuras,
  /// deve validar diretamente:
  /// `_supabaseClient.auth.currentSession`,
  /// garantindo que a sessão não esteja expirada.
  Future<bool> hasValidSession() async {
    final token = await _secureStorage.read(key: _sessionKey);
    return token?.isNotEmpty ?? false;
  }

  /// Restaura a sessão persistida ao iniciar o app.
  ///
  /// Deve ser chamado antes de verificar autenticação na inicialização.
  Future<void> restoreSession() async {
    // TODO(FUTURO):
    // Atualmente o Supabase restaura a sessão
    // automaticamente através do SDK.
    //
    // Este método foi mantido para preservar
    // a abstração do Repository e permitir
    // implementações futuras.
    final token = await _secureStorage.read(key: _sessionKey);
    if (token == null) return;
  }

  // ─── Helpers de Tratamento de Erros ────────────────────────────────────────

  void _handleSignUpError(AuthException e) {
    if (e.message.contains('already registered') || e.statusCode == '422') {
      throw Exception('Este e-mail já está em uso.');
    }
    throw Exception(_defaultErrorMessage());
  }

  void _handleSignInError(AuthException e) {
    if (e.message.contains('Invalid login credentials') ||
        e.message.contains('Unprocessable entity')) {
      throw Exception('E-mail ou senha inválidos.');
    }
    throw Exception(_defaultErrorMessage());
  }

  void _handleNetworkError() {
    throw Exception('Sem conexão com a internet.');
  }

  void _handleUnexpectedError(Object e) {
    throw Exception(_defaultErrorMessage());
  }

  String _defaultErrorMessage() {
    return 'Ops! Não foi possível acessar a aplicação. Tente novamente mais tarde.';
  }
}
