import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:dia_a_dia/modules/login/repositories/auth_repository.dart';

// -----------------------------------------------------------------------------
// Mocks
// -----------------------------------------------------------------------------

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockAuthResponse extends Mock implements AuthResponse {}

class MockSession extends Mock implements Session {}

// -----------------------------------------------------------------------------
// Helpers
// -----------------------------------------------------------------------------

late MockGoTrueClient _mockGoTrue;
late MockFlutterSecureStorage _mockSecureStorage;
late MockAuthResponse _mockResponse;

void _mockSignUpSuccess() {
  when(
    () => _mockGoTrue.signUp(
      email: any(named: 'email'),
      password: any(named: 'password'),
      data: any(named: 'data'),
    ),
  ).thenAnswer((_) async => _mockResponse);
}

void _mockSignUpFailure(Object error) {
  when(
    () => _mockGoTrue.signUp(
      email: any(named: 'email'),
      password: any(named: 'password'),
      data: any(named: 'data'),
    ),
  ).thenThrow(error);
}

void _mockSignInSuccess({String token = 'token_valido'}) {
  final mockSession = MockSession();
  when(() => mockSession.accessToken).thenReturn(token);
  when(() => _mockResponse.session).thenReturn(mockSession);

  when(
    () => _mockGoTrue.signInWithPassword(
      email: any(named: 'email'),
      password: any(named: 'password'),
    ),
  ).thenAnswer((_) async => _mockResponse);

  when(
    () => _mockSecureStorage.write(
      key: any(named: 'key'),
      value: any(named: 'value'),
    ),
  ).thenAnswer((_) async {});
}

void _mockSignInFailure(Object error) {
  when(
    () => _mockGoTrue.signInWithPassword(
      email: any(named: 'email'),
      password: any(named: 'password'),
    ),
  ).thenThrow(error);
}

void _verifySignUpCalled({
  required String email,
  required String password,
  required Map<String, dynamic> data,
}) {
  verify(
    () => _mockGoTrue.signUp(
      email: email,
      password: password,
      data: data,
    ),
  ).called(1);
}

void _verifyTokenPersisted({String token = 'token_valido'}) {
  verify(
    () => _mockSecureStorage.write(
      key: 'auth_session',
      value: token,
    ),
  ).called(1);
}

void _verifyTokenNotPersisted() {
  verifyNever(
    () => _mockSecureStorage.write(
      key: any(named: 'key'),
      value: any(named: 'value'),
    ),
  );
}

void main() {
  late AuthRepository repository;
  late MockSupabaseClient mockSupabaseClient;

  const tName = 'João';
  const tEmail = 'test@email.com';
  const tPassword = 'password123';
  const tLastName = 'Silva';

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    _mockGoTrue = MockGoTrueClient();
    _mockSecureStorage = MockFlutterSecureStorage();
    _mockResponse = MockAuthResponse();

    when(() => mockSupabaseClient.auth).thenReturn(_mockGoTrue);

    repository = AuthRepository(
      supabaseClient: mockSupabaseClient,
      secureStorage: _mockSecureStorage,
    );
  });

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Registro de Novos Usuários
  // Funcionalidade: signUpWithEmailAndPassword
  // ---------------------------------------------------------------------------
  group('Registro de Usuários | signUpWithEmailAndPassword', () {
    test(
      'deve invocar o fluxo de cadastro do Supabase com os metadados corretos',
      () async {
        // Arrange
        _mockSignUpSuccess();

        // Act
        await repository.signUpWithEmailAndPassword(
          name: tName,
          lastName: tLastName,
          email: tEmail,
          password: tPassword,
        );

        // Assert
        _verifySignUpCalled(
          email: tEmail,
          password: tPassword,
          data: {'name': tName, 'last_name': tLastName},
        );
      },
    );

    test(
      'deve lançar erro de conexão quando o Supabase disparar SocketException durante o cadastro',
      () async {
        // Arrange
        _mockSignUpFailure(const SocketException('Network unreachable'));

        // Act & Assert
        await expectLater(
          repository.signUpWithEmailAndPassword(
            name: tName,
            lastName: tLastName,
            email: tEmail,
            password: tPassword,
          ),
          throwsA(
            predicate<Exception>(
              (e) => e.toString().contains('Sem conexão com a internet.'),
            ),
          ),
        );
      },
    );

    test(
      'deve mapear exceção desconhecida para erro inesperado durante o cadastro',
      () async {
        // Arrange
        _mockSignUpFailure(Exception('Server error'));

        // Act & Assert
        await expectLater(
          repository.signUpWithEmailAndPassword(
            name: tName,
            lastName: tLastName,
            email: tEmail,
            password: tPassword,
          ),
          throwsA(
            predicate<Exception>(
              (e) => e.toString().contains('Erro inesperado'),
            ),
          ),
        );
      },
    );

    test(
      'deve lançar exceção específica quando o e-mail já estiver em uso',
      () async {
        // Arrange
        _mockSignUpFailure(const AuthException('User already registered'));

        // Act & Assert
        await expectLater(
          () => repository.signUpWithEmailAndPassword(
            name: tName,
            lastName: tLastName,
            email: tEmail,
            password: tPassword,
          ),
          throwsA(
            predicate<Exception>(
              (e) => e.toString().contains('Este e-mail já está em uso.'),
            ),
          ),
        );
      },
    );
  });

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Autenticação via E-mail e Persistência
  // Funcionalidade: signInWithEmailAndPassword
  // ---------------------------------------------------------------------------
  group('Autenticação e Persistência | signInWithEmailAndPassword', () {
    test(
      'deve persistir o token de acesso localmente quando o login for bem-sucedido',
      () async {
        // Arrange
        const tToken = 'token_valido';
        _mockSignInSuccess(token: tToken);

        // Act
        await repository.signInWithEmailAndPassword(tEmail, tPassword);

        // Assert
        _verifyTokenPersisted(token: tToken);

      },
    );

    test(
      'deve mapear exceção desconhecida para erro inesperado quando o servidor retornar uma sessão sem token',
      () async {
        // Arrange
        when(() => _mockResponse.session).thenReturn(null);
        when(
          () => _mockGoTrue.signInWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => _mockResponse);

        // Act & Assert
        await expectLater(
          repository.signInWithEmailAndPassword(tEmail, tPassword),
          throwsA(
            predicate<Exception>(
              (e) => e.toString().contains('Erro inesperado'),
            ),
          ),
        );

        _verifyTokenNotPersisted();
      },
    );

    test(
      'deve mapear erro de credenciais inválidas quando o servidor retornar Invalid login credentials',
      () async {
        // Arrange
        _mockSignInFailure(const AuthException('Invalid login credentials'));

        // Act & Assert
        await expectLater(
          repository.signInWithEmailAndPassword(tEmail, tPassword),
          throwsA(
            predicate<Exception>(
              (e) => e.toString().contains('E-mail ou senha inválidos.'),
            ),
          ),
        );
      },
    );

    test(
      'deve mapear erro de credenciais inválidas quando o servidor retornar Unprocessable entity',
      () async {
        // Arrange
        _mockSignInFailure(const AuthException('Unprocessable entity'));

        // Act & Assert
        await expectLater(
          repository.signInWithEmailAndPassword(tEmail, tPassword),
          throwsA(
            predicate<Exception>(
              (e) => e.toString().contains('E-mail ou senha inválidos.'),
            ),
          ),
        );
      },
    );

    test(
      'deve lançar erro de conexão quando o Supabase disparar SocketException no login',
      () async {
        // Arrange
        _mockSignInFailure(const SocketException('No internet'));

        // Act & Assert
        await expectLater(
          repository.signInWithEmailAndPassword(tEmail, tPassword),
          throwsA(
            predicate<Exception>(
              (e) => e.toString().contains('Sem conexão com a internet.'),
            ),
          ),
        );
      },
    );

    test(
      'deve retornar erro inesperado quando ocorrer erro desconhecido no login',
      () async {
        // Arrange
        _mockSignInFailure(const AuthException('Server error'));

        // Act & Assert
        await expectLater(
          repository.signInWithEmailAndPassword(tEmail, tPassword),
          throwsA(
            predicate<Exception>(
              (e) => e.toString().contains('Erro inesperado'),
            ),
          ),
        );
      },
    );
  });

  // group('signInWithGoogle', () {
  //   test('deve iniciar fluxo OAuth com Google', () async {
  //     when(
  //       () => _mockGoTrue.signInWithOAuth(
  //         OAuthProvider.google,
  //         redirectTo: any(named: 'redirectTo'),
  //       ),
  //     ).thenAnswer((_) async => true);
  //
  //     await repository.signInWithGoogle();
  //
  //     verify(
  //       () => _mockGoTrue.signInWithOAuth(
  //         OAuthProvider.google,
  //         redirectTo: 'io.supabase.flutter://login-callback',
  //       ),
  //     ).called(1);
  //   });
  //
  //   test(
  //     'deve lançar mensagem de sem conexão quando SocketException ocorrer no Google Login',
  //     () async {
  //       when(
  //         () => _mockGoTrue.signInWithOAuth(
  //           OAuthProvider.google,
  //           redirectTo: any(named: 'redirectTo'),
  //         ),
  //       ).thenThrow(const SocketException('No internet'));
  //
  //       await expectLater(
  //         repository.signInWithGoogle(),
  //         throwsA(
  //           predicate<Exception>(
  //             (e) => e.toString().contains('Sem conexão com a internet.'),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  //
  //   test(
  //     'deve lançar mensagem genérica quando OAuth falhar com erro desconhecido',
  //     () async {
  //       when(
  //         () => _mockGoTrue.signInWithOAuth(
  //           OAuthProvider.google,
  //           redirectTo: any(named: 'redirectTo'),
  //         ),
  //       ).thenThrow(Exception('OAuth provider error'));
  //
  //       await expectLater(
  //         repository.signInWithGoogle(),
  //         throwsA(predicate<Exception>((e) => e.toString().contains('Erro inesperado'))),
  //       );
  //     },
  //   );
  // });

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Encerramento de Sessão
  // Funcionalidade: signOut
  // ---------------------------------------------------------------------------
  group('Ciclo de Vida da Sessão | signOut', () {
    test(
      'deve limpar os dados persistidos localmente ao realizar o logout',
      () async {
        // Arrange
        when(() => _mockGoTrue.signOut()).thenAnswer((_) async {});
        when(
          () => _mockSecureStorage.delete(key: any(named: 'key')),
        ).thenAnswer((_) async {});

        // Act
        await repository.signOut();

        // Assert
        verify(() => _mockGoTrue.signOut()).called(1);
        verify(() => _mockSecureStorage.delete(key: 'auth_session')).called(1);
      },
    );

    test(
      'deve garantir a limpeza local mesmo se a chamada remota ao Supabase falhar',
      () async {
        // Arrange
        when(() => _mockGoTrue.signOut()).thenThrow(Exception('Supabase indisponível'));
        when(
          () => _mockSecureStorage.delete(key: any(named: 'key')),
        ).thenAnswer((_) async {});

        // Act
        await repository.signOut();

        // Assert
        verify(() => _mockSecureStorage.delete(key: 'auth_session')).called(1);
      },
    );
  });

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Validação de Estado da Sessão
  // Funcionalidade: hasValidSession
  // ---------------------------------------------------------------------------
  group('Estado da Sessão | hasValidSession', () {
    test(
      'deve retornar verdadeiro quando existir um token persistido',
      () async {
        // Arrange
        when(
          () => _mockSecureStorage.read(key: any(named: 'key')),
        ).thenAnswer((_) async => 'token_valido');

        // Act
        final result = await repository.hasValidSession();

        // Assert
        expect(result, isTrue);
      },
    );

    test(
      'deve retornar falso quando não houver token persistido (nulo)',
      () async {
        // Arrange
        when(
          () => _mockSecureStorage.read(key: any(named: 'key')),
        ).thenAnswer((_) async => null);

        // Act
        final result = await repository.hasValidSession();

        // Assert
        expect(result, isFalse);
      },
    );

    test(
      'deve retornar falso quando o token persistido for uma string vazia',
      () async {
        // Arrange
        when(
          () => _mockSecureStorage.read(key: any(named: 'key')),
        ).thenAnswer((_) async => '');

        // Act
        final result = await repository.hasValidSession();

        // Assert
        expect(result, isFalse);
      },
    );
  });
}
