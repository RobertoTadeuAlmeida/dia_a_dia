import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Responsável por autenticação e persistência de sessão.
/// Não contém validações de campos nem lógica de estado de tela.
class AuthRepository {
  /// Cliente utilizado para comunicação com o Supabase.
  final SupabaseClient _supabaseClient;
  /// Armazenamento seguro utilizado para persistência local.
  final FlutterSecureStorage _secureStorage;

  /// Chave utilizada para persistir o token
  /// de autenticação localmente.
  static const _sessionKey = 'auth_session';

  /// Cria uma instância responsável pelas operações
  /// de autenticação e persistência de sessão.
  AuthRepository({
    required SupabaseClient supabaseClient,
    required FlutterSecureStorage secureStorage,
  }) : _supabaseClient = supabaseClient,
       _secureStorage = secureStorage;

  /// Autentica o usuário com e-mail e senha.
  /// Persiste o token de sessão localmente em caso de sucesso.
  /// Lança [Exception] em caso de falha.
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final token = response.session?.accessToken;

      if (token == null) {
        throw Exception('E-mail ou senha inválidos.');
      }

      await _secureStorage.write(key: _sessionKey, value: token);
    } on AuthException catch (e) {
      if (e.statusCode == '400' || e.statusCode == '422') {
        throw Exception('E-mail ou senha inválidos.');
      }
      throw Exception(_defaultErrorMessage());
    } on SocketException {
      throw Exception('Sem conexão com a internet.');
    } catch (_) {
      throw Exception(_defaultErrorMessage());
    }
  }

  /// Autentica o usuário via Google OAuth2.
  /// Lança [Exception] com a string 'autenticacao_cancelada' quando o usuário cancela o fluxo.
  /// TODO(FN0001-GOOGLE):
  /// Finalizar captura automática da sessão após
  /// retorno do OAuth.
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
      throw Exception('Sem conexão com a internet.');
    } catch (e) {
      if (e.toString().contains('autenticacao_cancelada')) rethrow;
      throw Exception(_defaultErrorMessage());
    }
  }

  /// Remove a sessão do Supabase e limpa os
  /// dados persistidos localmente.
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
    return token != null && token.isNotEmpty;
  }

  /// Restaura a sessão persistida ao iniciar o app.
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

  /// Retorna a mensagem padrão utilizada
  /// para erros inesperados de autenticação.
  String _defaultErrorMessage() {
    return 'Ops! Não foi possível acessar a aplicação. Tente novamente mais tarde.';
  }
}
