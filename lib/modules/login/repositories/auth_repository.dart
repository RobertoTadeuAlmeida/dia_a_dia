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
  })  : _supabaseClient = supabaseClient,
        _secureStorage = secureStorage;

  /// Autentica o usuário com e-mail e senha.
  /// Persiste o token de sessão localmente em caso de sucesso.
  /// Lança [Exception] em caso de falha.
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      // TODO: Supabase integration
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
      throw Exception(
        'Ops! Não foi possível acessar a aplicação. Tente novamente mais tarde.',
      );
    } on SocketException {
      throw Exception('Sem conexão com a internet.');
    } catch (_) {
      throw Exception(
        'Ops! Não foi possível acessar a aplicação. Tente novamente mais tarde.',
      );
    }
  }

  /// Autentica o usuário via Google OAuth2.
  /// Lança [Exception] com a string 'autenticacao_cancelada' quando o usuário cancela o fluxo.
  Future<void> signInWithGoogle() async {
    try {
      // TODO: Supabase integration — configurar OAuth com Google provider
      final response = await _supabaseClient.auth.signInWithOAuth(
        OAuthProvider.google,
      );

      if (!response) {
        throw Exception('autenticacao_cancelada');
      }

      final token = _supabaseClient.auth.currentSession?.accessToken;
      if (token == null) {
        throw Exception('autenticacao_cancelada');
      }

      await _secureStorage.write(key: _sessionKey, value: token);
    } on AuthException {
      throw Exception(
        'Ops! Não foi possível acessar a aplicação. Tente novamente mais tarde.',
      );
    } on SocketException {
      throw Exception('Sem conexão com a internet.');
    } catch (e) {
      if (e.toString().contains('autenticacao_cancelada')) rethrow;
      throw Exception(
        'Ops! Não foi possível acessar a aplicação. Tente novamente mais tarde.',
      );
    }
  }

  /// Encerra a sessão autenticada e remove dados locais.
  /// Garante limpeza local mesmo em caso de falha no Supabase.
  Future<void> signOut() async {
    try {
      // TODO: Supabase integration
      await _supabaseClient.auth.signOut();
    } catch (_) {
      // Falha no Supabase não impede limpeza local
    } finally {
      await _secureStorage.delete(key: _sessionKey);
    }
  }

  /// Retorna `true` se existir uma sessão válida .
  Future<bool> hasValidSession() async {
    final token = await _secureStorage.read(key: _sessionKey);
    return token != null && token.isNotEmpty;
  }

  /// Restaura a sessão persistida ao iniciar o app.
  /// Deve ser chamado antes de verificar autenticação na inicialização.
  Future<void> restoreSession() async {
    // TODO: Supabase integration — restaurar sessão via token persistido
    // ex: await _supabaseClient.auth.setSession(token);
    final token = await _secureStorage.read(key: _sessionKey);
    if (token == null) return;
  }
}