import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:dia_a_dia/modules/login/repositories/auth_repository.dart';

// Mocks
class MockSupabaseClient extends Mock implements SupabaseClient {}
class MockGoTrueClient extends Mock implements GoTrueClient {}
class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}
class MockAuthResponse extends Mock implements AuthResponse {}
class MockSession extends Mock implements Session {}

void main() {
  late AuthRepository repository;
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockGoTrue;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    mockGoTrue = MockGoTrueClient();
    mockSecureStorage = MockFlutterSecureStorage();

    when(() => mockSupabaseClient.auth).thenReturn(mockGoTrue);

    repository = AuthRepository(
      supabaseClient: mockSupabaseClient,
      secureStorage: mockSecureStorage,
    );
  });

  group('signInWithEmailAndPassword', () {
    test('deve persistir token em caso de sucesso', () async {
      final mockSession = MockSession();
      final mockResponse = MockAuthResponse();

      when(() => mockSession.accessToken).thenReturn('token_valido');
      when(() => mockResponse.session).thenReturn(mockSession);
      when(() => mockGoTrue.signInWithPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      )).thenAnswer((_) async => mockResponse);
      when(() => mockSecureStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      )).thenAnswer((_) async {});

      await repository.signInWithEmailAndPassword('user@email.com', '12345678');

      verify(() => mockSecureStorage.write(
        key: 'auth_session',
        value: 'token_valido',
      )).called(1);
    });

    test('deve lançar mensagem de credenciais inválidas para statusCode 400', () async {
      when(() => mockGoTrue.signInWithPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      )).thenThrow(
        const AuthException('Invalid login credentials', statusCode: '400'),
      );

      await expectLater(
        repository.signInWithEmailAndPassword('user@email.com', 'senhaerrada'),
        throwsA(
          predicate<Exception>(
                (e) => e.toString().contains('E-mail ou senha inválidos.'),
          ),
        ),
      );
    });

    test('deve lançar mensagem de credenciais inválidas para statusCode 422', () async {
      when(() => mockGoTrue.signInWithPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      )).thenThrow(
        const AuthException('Unprocessable entity', statusCode: '422'),
      );

      await expectLater(
        repository.signInWithEmailAndPassword('user@email.com', 'senhaerrada'),
        throwsA(
          predicate<Exception>(
                (e) => e.toString().contains('E-mail ou senha inválidos.'),
          ),
        ),
      );
    });

    test('deve lançar mensagem de sem conexão para SocketException', () async {
      when(() => mockGoTrue.signInWithPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      )).thenThrow(const SocketException('No internet'));

      await expectLater(
        repository.signInWithEmailAndPassword('user@email.com', '12345678'),
        throwsA(
          predicate<Exception>(
                (e) => e.toString().contains('Sem conexão com a internet.'),
          ),
        ),
      );
    });

    test('deve lançar mensagem genérica para erro desconhecido', () async {
      when(() => mockGoTrue.signInWithPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      )).thenThrow(const AuthException('Server error', statusCode: '500'));

      await expectLater(
        repository.signInWithEmailAndPassword('user@email.com', '12345678'),
        throwsA(
          predicate<Exception>(
                (e) => e.toString().contains('Ops!'),
          ),
        ),
      );
    });
  });

  group('signOut', () {
    test('deve remover sessão local ao fazer logout', () async {
      when(() => mockGoTrue.signOut()).thenAnswer((_) async {});
      when(() => mockSecureStorage.delete(key: any(named: 'key')))
          .thenAnswer((_) async {});

      await repository.signOut();

      verify(() => mockSecureStorage.delete(key: 'auth_session')).called(1);
    });

    test('deve remover sessão local mesmo se o Supabase falhar', () async {
      when(() => mockGoTrue.signOut())
          .thenThrow(Exception('Supabase indisponível'));
      when(() => mockSecureStorage.delete(key: any(named: 'key')))
          .thenAnswer((_) async {});

      await repository.signOut();

      verify(() => mockSecureStorage.delete(key: 'auth_session')).called(1);
    });
  });

  group('hasValidSession', () {
    test('deve retornar true quando token existir', () async {
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => 'token_valido');

      final result = await repository.hasValidSession();

      expect(result, isTrue);
    });

    test('deve retornar false quando token for nulo', () async {
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => null);

      final result = await repository.hasValidSession();

      expect(result, isFalse);
    });

    test('deve retornar false quando token for string vazia', () async {
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => '');

      final result = await repository.hasValidSession();

      expect(result, isFalse);
    });
  });
}