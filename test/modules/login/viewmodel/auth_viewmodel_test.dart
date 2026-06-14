import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dia_a_dia/modules/login/viewmodel/auth_viewmodel.dart';
import 'package:dia_a_dia/modules/login/repositories/auth_repository.dart';
import 'package:dia_a_dia/modules/login/models/auth_status.dart';

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
  group('checkSession', () {
    test('deve autenticar quando há sessão válida', () async {
      when(() => repository.hasValidSession()).thenAnswer((_) async => true);

      when(() => repository.restoreSession()).thenAnswer((_) async {});

      await viewModel.checkSession();

      expect(viewModel.status, AuthStatus.authenticated);
      expect(viewModel.errorMessage, isNull);
    });

    test('deve ficar unauthenticated quando não há sessão', () async {
      when(() => repository.hasValidSession()).thenAnswer((_) async => false);

      await viewModel.checkSession();

      expect(viewModel.status, AuthStatus.unauthenticated);
    });

    test('deve ir para error quando falha', () async {
      when(() => repository.hasValidSession()).thenThrow(Exception('erro'));

      await viewModel.checkSession();

      expect(viewModel.status, AuthStatus.error);
      expect(viewModel.errorMessage, isNotNull);
    });
  });

  group('signInWithEmailAndPassword', () {
    test('deve autenticar com sucesso', () async {
      when(
        () => repository.signInWithEmailAndPassword(any(), any()),
      ).thenAnswer((_) async {});

      await viewModel.signInWithEmailAndPassword('test@test.com', '123456');

      expect(viewModel.status, AuthStatus.authenticated);
      expect(viewModel.errorMessage, isNull);
    });

    test('deve ir para error quando falha', () async {
      when(
        () => repository.signInWithEmailAndPassword(any(), any()),
      ).thenThrow(Exception('E-mail ou senha inválidos.'));

      await viewModel.signInWithEmailAndPassword('test@test.com', '123456');

      expect(viewModel.status, AuthStatus.error);
      expect(viewModel.errorMessage, 'E-mail ou senha inválidos.');
    });
  });

  group('signInWithGoogle', () {
    test('deve autenticar com sucesso', () async {
      when(() => repository.signInWithGoogle()).thenAnswer((_) async {});

      await viewModel.signInWithGoogle();

      expect(viewModel.status, AuthStatus.authenticated);
    });

    test('deve ficar unauthenticated quando usuário cancela', () async {
      when(
        () => repository.signInWithGoogle(),
      ).thenThrow(Exception('autenticacao_cancelada'));

      await viewModel.signInWithGoogle();

      expect(viewModel.status, AuthStatus.unauthenticated);
      expect(viewModel.errorMessage, isNull);
    });

    test('deve ir para error quando falha', () async {
      when(
        () => repository.signInWithGoogle(),
      ).thenThrow(Exception('Sem conexão com a internet.'));

      await viewModel.signInWithGoogle();

      expect(viewModel.status, AuthStatus.error);
      expect(viewModel.errorMessage, 'Sem conexão com a internet.');
    });
  });

  group('signOut', () {
    test('deve limpar sessão e ir para unauthenticated', () async {
      when(() => repository.signOut()).thenAnswer((_) async {});

      await viewModel.signOut();

      expect(viewModel.status, AuthStatus.unauthenticated);
      expect(viewModel.currentUser, isNull);
      expect(viewModel.errorMessage, isNull);
    });

    test('deve ir para error quando falha', () async {
      when(() => repository.signOut()).thenThrow(Exception('erro'));

      await viewModel.signOut();

      expect(viewModel.status, AuthStatus.error);
    });
  });
}
