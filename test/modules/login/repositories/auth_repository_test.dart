import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:dia_a_dia/modules/login/repositories/auth_repository.dart';

/// Suíte de Testes Unitários para o [AuthRepository].
///
/// Esta classe é responsável por validar a camada de dados da autenticação,
/// garantindo a integração correta com o SDK do Supabase e a persistência
/// segura de tokens via Secure Storage.
///
/// Responsabilidades testadas:
/// 1. Comunicação com o backend (Supabase GoTrue).
/// 2. Persistência local de tokens de sessão.
/// 3. Tratamento e mapeamento de exceções (AuthException, SocketException).
/// 4. Gestão de ciclo de vida da sessão (Login, Cadastro, Logout).

// Mocks
class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockAuthResponse extends Mock implements AuthResponse {}

class MockSession extends Mock implements Session {}

class MockUserResponse extends Mock implements UserResponse {}

void main() {
  late AuthRepository repository;
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockGoTrue;
  late MockFlutterSecureStorage mockSecureStorage;
  late MockAuthResponse mockResponse;

  const name = 'João';
  const email = 'test@email.com';
  const password = 'password123';
  const lastName = 'Silva';

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    mockGoTrue = MockGoTrueClient();
    mockSecureStorage = MockFlutterSecureStorage();
    mockResponse = MockAuthResponse();

    when(() => mockSupabaseClient.auth).thenReturn(mockGoTrue);

    repository = AuthRepository(
      supabaseClient: mockSupabaseClient,
      secureStorage: mockSecureStorage,
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
        when(
          () => mockGoTrue.signUp(
            email: email,
            password: password,
            data: {'name': name, 'last_name': lastName},
          ),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          repository.signUpWithEmailAndPassword(
            name: name,
            lastName: lastName,
            email: email,
            password: password,
          ),
          completes,
        );

        verify(
          () => mockGoTrue.signUp(
            email: email,
            password: password,
            data: {'name': name, 'last_name': lastName},
          ),
        ).called(1);
      },
    );
    test('deve lancar erro de conexao quando nao houver internet', () async {
      when(
        () => mockGoTrue.signUp(
          email: any(named: 'email'),
          password: any(named: 'password'),
          data: any(named: 'data'),
        ),
      ).thenThrow(SocketException('Network unreachable'));

      await expectLater(
        repository.signUpWithEmailAndPassword(
          name: name,
          lastName: lastName,
          email: email,
          password: password,
        ),
        throwsA(
          predicate<Exception>(
            (e) => e.toString().contains('Sem conexão com a internet.'),
          ),
        ),
      );
    });

    test('deve lançar erro generico quando ocorrer falha inesperada', () async {
      when(
        () => mockGoTrue.signUp(
          email: any(named: 'email'),
          password: any(named: 'password'),
          data: any(named: 'data'),
        ),
      ).thenThrow(Exception('Server error'));
      await expectLater(
        repository.signUpWithEmailAndPassword(
          name: name,
          lastName: lastName,
          email: email,
          password: password,
        ),
        throwsA(predicate<Exception>((e) => e.toString().contains('Ops! Não foi possível concluir o cadastro. Tente novamente mais tarde.'))),
      );
    });

    test('deve lançar exceção quando o e-mail ja estiver em uso', () async {
      when(
        () => mockGoTrue.signUp(
          password: any(named: 'password'),
          email: any(named: 'email'),
          data: any(named: 'data'),
        ),
      ).thenThrow(AuthException('User already registered'));
      await expectLater(
        () => repository.signUpWithEmailAndPassword(
          name: name,
          lastName: lastName,
          email: email,
          password: password,
        ),
        throwsA(
          predicate<Exception>(
            (e) => e.toString().contains('Este e-mail já está em uso.'),
          ),
        ),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Autenticação via E-mail e Persistência
  // Funcionalidade: signInWithEmailAndPassword
  // ---------------------------------------------------------------------------
  group('Autenticação e Persistência | signInWithEmailAndPassword', () {
    test(
      'deve persistir o token de acesso localmente quando o login for bem-sucedido',
      () async {
        final mockSession = MockSession();
        final mockResponse = MockAuthResponse();

        when(() => mockSession.accessToken).thenReturn('token_valido');
        when(() => mockResponse.session).thenReturn(mockSession);
        when(
          () => mockGoTrue.signInWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => mockResponse);
        when(
          () => mockSecureStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async {});

        await repository.signInWithEmailAndPassword(email, password);

        verify(
          () => mockSecureStorage.write(
            key: 'auth_session',
            value: 'token_valido',
          ),
        ).called(1);
      },
    );

    test(
      'deve lançar exceção tratada quando o servidor retornar uma sessão sem token',
      () async {
        final mockSession = MockSession();
        final mockResponse = MockAuthResponse();

        // session existe mas accessToken é nulo
        when(() => mockSession.accessToken).thenReturn('');
        when(() => mockResponse.session).thenReturn(null);
        when(
          () => mockGoTrue.signInWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          repository.signInWithEmailAndPassword(email, password),
          throwsA(predicate<Exception>((e) => e.toString().contains('Ops!'))),
        );

        verifyNever(
          () => mockSecureStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        );
      },
    );

    test(
      'deve mapear erro de credenciais inválidas quando o servidor retornar Invalid login credentials',
      () async {
        when(
          () => mockGoTrue.signInWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(const AuthException('Invalid login credentials'));

        await expectLater(
          repository.signInWithEmailAndPassword(email, password),
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
        when(
          () => mockGoTrue.signInWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(const AuthException('Unprocessable entity'));

        await expectLater(
          repository.signInWithEmailAndPassword(email, password),
          throwsA(
            predicate<Exception>(
              (e) => e.toString().contains('E-mail ou senha inválidos.'),
            ),
          ),
        );
      },
    );

    test(
      'deve lançar mensagem de falha na conexão quando ocorrer uma SocketException',
      () async {
        when(
          () => mockGoTrue.signInWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(const SocketException('No internet'));

        await expectLater(
          repository.signInWithEmailAndPassword(email, password),
          throwsA(
            predicate<Exception>(
              (e) => e.toString().contains('Sem conexão com a internet.'),
            ),
          ),
        );
      },
    );

    test(
      'deve lançar mensagem genérica de sistema quando ocorrer um erro desconhecido no backend',
      () async {
        when(
          () => mockGoTrue.signInWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(const AuthException('Server error'));

        await expectLater(
          repository.signInWithEmailAndPassword(email, password),
          throwsA(predicate<Exception>((e) => e.toString().contains('Ops!'))),
        );
      },
    );
  });

  // ---------------------------------------------------------------------------
  // signInWithGoogle
  // ---------------------------------------------------------------------------

  // TODO(FN0001-GOOGLE):
  // Reativar testes do OAuth quando o callback
  // estiver concluído e o fluxo estiver estável.
  // group('signInWithGoogle', () {
  //   test('deve iniciar fluxo OAuth com Google', () async {
  //     when(
  //       () => mockGoTrue.signInWithOAuth(
  //         OAuthProvider.google,
  //         redirectTo: any(named: 'redirectTo'),
  //       ),
  //     ).thenAnswer((_) async => true);
  //
  //     await repository.signInWithGoogle();
  //
  //     verify(
  //       () => mockGoTrue.signInWithOAuth(
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
  //         () => mockGoTrue.signInWithOAuth(
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
  //         () => mockGoTrue.signInWithOAuth(
  //           OAuthProvider.google,
  //           redirectTo: any(named: 'redirectTo'),
  //         ),
  //       ).thenThrow(Exception('OAuth provider error'));
  //
  //       await expectLater(
  //         repository.signInWithGoogle(),
  //         throwsA(predicate<Exception>((e) => e.toString().contains('Ops!'))),
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
        when(() => mockGoTrue.signOut()).thenAnswer((_) async {});
        when(
          () => mockSecureStorage.delete(key: any(named: 'key')),
        ).thenAnswer((_) async {});

        await repository.signOut();

        verify(() => mockSecureStorage.delete(key: 'auth_session')).called(1);
      },
    );

    test(
      'deve garantir a limpeza local mesmo se a chamada remota ao Supabase falhar',
      () async {
        when(
          () => mockGoTrue.signOut(),
        ).thenThrow(Exception('Supabase indisponível'));
        when(
          () => mockSecureStorage.delete(key: any(named: 'key')),
        ).thenAnswer((_) async {});

        await repository.signOut();

        verify(() => mockSecureStorage.delete(key: 'auth_session')).called(1);
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
        when(
          () => mockSecureStorage.read(key: any(named: 'key')),
        ).thenAnswer((_) async => 'token_valido');

        final result = await repository.hasValidSession();

        expect(result, isTrue);
      },
    );

    test(
      'deve retornar falso quando não houver token persistido (nulo)',
      () async {
        when(
          () => mockSecureStorage.read(key: any(named: 'key')),
        ).thenAnswer((_) async => null);

        final result = await repository.hasValidSession();

        expect(result, isFalse);
      },
    );

    test(
      'deve retornar falso quando o token persistido for uma string vazia',
      () async {
        when(
          () => mockSecureStorage.read(key: any(named: 'key')),
        ).thenAnswer((_) async => '');

        final result = await repository.hasValidSession();

        expect(result, isFalse);
      },
    );
  });
}
