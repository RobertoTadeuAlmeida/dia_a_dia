import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dia_a_dia/modules/login/viewmodel/auth_viewmodel.dart';
import 'package:dia_a_dia/modules/login/repositories/auth_repository.dart';
import 'package:dia_a_dia/modules/login/models/auth_status.dart';

/// Suíte de Testes Unitários para a [AuthViewModel].
///
/// Esta classe é responsável por validar as regras de negócio de autenticação,
/// gerenciamento de sessão e estados de UI (loading, sucesso, erro).
///
/// Responsabilidades testadas:
/// 1. Verificação de sessão existente na inicialização.
/// 2. Fluxos de login (E-mail/Senha e Social).
/// 3. Fluxo de registro de novos usuários.
/// 4. Encerramento de sessão (Logout).

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthViewModel viewModel;
  late MockAuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    viewModel = AuthViewModel(repository: repository);
  });

  tearDown(() {
    viewModel.dispose();
  });

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Gestão de Sessão
  // Funcionalidade: checkSession
  // ---------------------------------------------------------------------------
  group('Gestão de Sessão | checkSession', () {
    test(
      'deve definir status como authenticated quando houver uma sessão válida persistida',
      () async {
        when(() => repository.hasValidSession()).thenAnswer((_) async => true);
        when(() => repository.restoreSession()).thenAnswer((_) async {});

        await viewModel.checkSession();

        expect(viewModel.status, AuthStatus.authenticated);
        expect(viewModel.errorMessage, isNull);
      },
    );

    test(
      'deve definir status como unauthenticated quando não houver sessão persistida',
      () async {
        when(() => repository.hasValidSession()).thenAnswer((_) async => false);

        await viewModel.checkSession();

        expect(viewModel.status, AuthStatus.unauthenticated);
      },
    );

    test(
      'deve definir status como error e capturar mensagem quando a verificação falhar',
      () async {
        when(() => repository.hasValidSession()).thenThrow(Exception('erro'));

        await viewModel.checkSession();

        expect(viewModel.status, AuthStatus.error);
        expect(viewModel.errorMessage, isNotNull);
      },
    );
  });

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Autenticação via E-mail
  // Funcionalidade: signInWithEmailAndPassword
  // ---------------------------------------------------------------------------
  group('Autenticação | signInWithEmailAndPassword', () {
    test(
      'deve autenticar o usuário e definir status como authenticated em caso de sucesso',
      () async {
        when(
          () => repository.signInWithEmailAndPassword(any(), any()),
        ).thenAnswer((_) async {});

        await viewModel.signInWithEmailAndPassword('test@test.com', '123456');

        expect(viewModel.status, AuthStatus.authenticated);
        expect(viewModel.errorMessage, isNull);
      },
    );

    test(
      'deve definir status como error e retornar mensagem amigável quando as credenciais forem inválidas',
      () async {
        when(
          () => repository.signInWithEmailAndPassword(any(), any()),
        ).thenThrow(Exception('E-mail ou senha inválidos.'));

        await viewModel.signInWithEmailAndPassword('test@test.com', '123456');

        expect(viewModel.status, AuthStatus.error);
        expect(viewModel.errorMessage, 'E-mail ou senha inválidos.');
      },
    );
  });

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Autenticação Social (Google)
  // Funcionalidade: signInWithGoogle
  // ---------------------------------------------------------------------------
  group('Autenticação Social | signInWithGoogle', () {
    test(
      'deve definir status como authenticated quando o login social for concluído com sucesso',
      () async {
        when(() => repository.signInWithGoogle()).thenAnswer((_) async {});

        await viewModel.signInWithGoogle();

        expect(viewModel.status, AuthStatus.authenticated);
      },
    );

    test(
      'deve retornar para unauthenticated sem erro quando o usuário cancelar o fluxo do Google',
      () async {
        when(
          () => repository.signInWithGoogle(),
        ).thenThrow(Exception('autenticacao_cancelada'));

        await viewModel.signInWithGoogle();

        expect(viewModel.status, AuthStatus.unauthenticated);
        expect(viewModel.errorMessage, isNull);
      },
    );

    test(
      'deve definir status como error quando houver falha de rede no login social',
      () async {
        when(
          () => repository.signInWithGoogle(),
        ).thenThrow(Exception('Sem conexão com a internet.'));

        await viewModel.signInWithGoogle();

        expect(viewModel.status, AuthStatus.error);
        expect(viewModel.errorMessage, 'Sem conexão com a internet.');
      },
    );
  });

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Encerramento de Sessão
  // Funcionalidade: signOut
  // ---------------------------------------------------------------------------
  group('Sessão | signOut', () {
    test(
      'deve limpar dados do usuário e definir status como unauthenticated ao sair',
      () async {
        when(() => repository.signOut()).thenAnswer((_) async {});

        await viewModel.signOut();

        expect(viewModel.status, AuthStatus.unauthenticated);
        expect(viewModel.currentUser, isNull);
        expect(viewModel.errorMessage, isNull);
      },
    );

    test(
      'deve definir status como error quando ocorrer falha ao tentar encerrar a sessão',
      () async {
        when(() => repository.signOut()).thenThrow(Exception('erro'));

        await viewModel.signOut();

        expect(viewModel.status, AuthStatus.error);
      },
    );
  });
}
