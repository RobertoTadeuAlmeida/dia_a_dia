import 'package:dia_a_dia/core/constants/app_keys.dart';
import 'package:dia_a_dia/core/routes/app_routes.dart';
import 'package:dia_a_dia/core/routes/route_names.dart';
import 'package:dia_a_dia/core/widgets/primary_button.dart';
import 'package:dia_a_dia/modules/login/models/auth_status.dart';
import 'package:dia_a_dia/modules/login/view/pages/login_page.dart';
import 'package:dia_a_dia/modules/login/view/widgets/auth_card.dart';
import 'package:dia_a_dia/modules/login/view/widgets/auth_header.dart';
import 'package:dia_a_dia/modules/login/view/widgets/or_divider.dart';
import 'package:dia_a_dia/modules/login/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthViewModel extends Mock
    with ChangeNotifier
    implements AuthViewModel {}

late MockAuthViewModel _viewModel;

//===========================================================================
// Helpers Mocks
//===========================================================================

void _mockInitialState() {
  when(() => _viewModel.status).thenReturn(AuthStatus.initial);
  when(() => _viewModel.errorMessage).thenReturn(null);
  when(() => _viewModel.currentUser).thenReturn(null);
  when(() => _viewModel.isAuthenticated).thenReturn(false);
  when(() => _viewModel.checkSession()).thenAnswer((_) async {});
  when(() => _viewModel.clearError()).thenReturn(null);
}

void _mockLoadingState() {
  when(() => _viewModel.status).thenReturn(AuthStatus.loading);
}

void _mockAuthenticatedState() {
  when(() => _viewModel.status).thenReturn(AuthStatus.authenticated);
  when(() => _viewModel.isAuthenticated).thenReturn(true);
}

void _mockUnauthenticatedState() {
  when(() => _viewModel.status).thenReturn(AuthStatus.unauthenticated);
  when(() => _viewModel.isAuthenticated).thenReturn(false);
}

void _mockErrorState(String message) {
  when(() => _viewModel.status).thenReturn(AuthStatus.error);
  when(() => _viewModel.errorMessage).thenReturn(message);
}

//===========================================================================
// Helpers UI
//===========================================================================

Future<void> _pumpLoginPage(WidgetTester tester) async {
  await tester.pumpWidget(
    ChangeNotifierProvider<AuthViewModel>.value(
      value: _viewModel,
      child: MaterialApp(
        initialRoute: RouteNames.login,
        routes: AppRoutes.routes,
      ),
    ),
  );
}

void _setSmallScreen(WidgetTester tester) {
  tester.view.physicalSize = const Size(360, 640);
  tester.view.devicePixelRatio = 1.0;

  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}

void main() {
  setUp(() {
    _viewModel = MockAuthViewModel();
    _mockInitialState();
  });

  //===========================================================================
  // Estrutura da Tela
  //===========================================================================

  group('Estrutura da Tela', () {
    testWidgets('deve exibir o AuthHeader', (tester) async {
      await _pumpLoginPage(tester);

      expect(find.byType(AuthHeader), findsOneWidget);
    });

    testWidgets('deve exibir o AuthCard', (tester) async {
      await _pumpLoginPage(tester);

      expect(find.byType(AuthCard), findsOneWidget);
    });

    testWidgets('deve exibir o OrDivider', (tester) async {
      await _pumpLoginPage(tester);

      expect(find.byType(OrDivider), findsOneWidget);
    });

    testWidgets('deve exibir o campo de e-mail', (tester) async {
      await _pumpLoginPage(tester);

      expect(find.byKey(AppKeys.loginEmailField), findsOneWidget);
    });

    testWidgets('deve exibir o campo de senha', (tester) async {
      await _pumpLoginPage(tester);

      expect(find.byKey(AppKeys.loginPasswordField), findsOneWidget);
    });
  });

  //===========================================================================
  // Ciclo de Vida
  //===========================================================================

  group('Ciclo de Vida', () {
    testWidgets('deve chamar checkSession ao iniciar a tela', (tester) async {
      await _pumpLoginPage(tester);

      verify(() => _viewModel.checkSession()).called(1);
    });
  });

  //===========================================================================
  // Botão Entrar
  //===========================================================================

  group('Botão Entrar', () {
    testWidgets('deve exibir o botão principal', (tester) async {
      await _pumpLoginPage(tester);

      expect(find.byKey(AppKeys.loginButton), findsOneWidget);
    });

    testWidgets(
      'deve chamar signInWithEmailAndPassword com e-mail e senha informados',
      (tester) async {
        when(
          () => _viewModel.signInWithEmailAndPassword(any(), any()),
        ).thenAnswer((_) async {});

        await _pumpLoginPage(tester);

        await tester.enterText(
          find.byKey(AppKeys.loginEmailField),
          'teste@email.com',
        );

        await tester.enterText(
          find.byKey(AppKeys.loginPasswordField),
          '12345678',
        );

        await tester.pump();

        await tester.tap(find.byKey(AppKeys.loginButton));

        await tester.pump();

        verify(
          () => _viewModel.signInWithEmailAndPassword(
            'teste@email.com',
            '12345678',
          ),
        ).called(1);
      },
    );

    testWidgets(
      'deve manter o botão desabilitado quando o formulário for inválido',
      (tester) async {
        await _pumpLoginPage(tester);

        final button = tester.widget<PrimaryButton>(
          find.byKey(AppKeys.loginButton),
        );

        await tester.pump();

        expect(button.onPressed, isNull);
      },
    );
  });
  //===========================================================================
  // Login Google
  //===========================================================================

  group('Login Google', () {
    testWidgets('deve exibir o botão Google', (tester) async {
      await _pumpLoginPage(tester);

      expect(find.byKey(AppKeys.googleLoginButton), findsOneWidget);
    });

    testWidgets('deve chamar signInWithGoogle', (tester) async {
      when(() => _viewModel.signInWithGoogle()).thenAnswer((_) async {});

      await _pumpLoginPage(tester);

      await tester.tap(find.byKey(AppKeys.googleLoginButton));
      await tester.pump();

      verify(() => _viewModel.signInWithGoogle()).called(1);
    });
  });

  //===========================================================================
  // Navegação
  //===========================================================================

  group('Navegação', () {
    testWidgets('deve exibir o link Criar Conta', (tester) async {
      await _pumpLoginPage(tester);

      expect(find.byKey(AppKeys.createAccountButton), findsOneWidget);
    });

    testWidgets('deve navegar para Cadastro ao pressionar Criar Conta', (
      tester,
    ) async {
      await _pumpLoginPage(tester);

      await tester.tap(find.byKey(AppKeys.createAccountButton));
      await tester.pumpAndSettle();

      expect(find.byKey(AppKeys.signupPage), findsOneWidget);
    });

    testWidgets('deve navegar para Home quando autenticado', (tester) async {
      _mockAuthenticatedState();

      await _pumpLoginPage(tester);

      expect(find.byKey(AppKeys.homePage), findsOneWidget);
    });

    testWidgets('deve permanecer na Login quando não autenticado', (
      tester,
    ) async {
      _mockUnauthenticatedState();

      await _pumpLoginPage(tester);

      expect(find.byKey(AppKeys.loginPage), findsOneWidget);
    });
  });

  //===========================================================================
  // Feedback
  //===========================================================================

  group('Feedback ao Usuário', () {
    testWidgets('deve exibir ErrorMessage quando houver erro', (tester) async {
      _mockErrorState('Erro de autenticação');

      await _pumpLoginPage(tester);

      expect(find.byKey(AppKeys.errorMessage), findsOneWidget);
    });

    testWidgets('não deve exibir ErrorMessage quando não houver erro', (
      tester,
    ) async {
      await _pumpLoginPage(tester);

      expect(find.byKey(AppKeys.errorMessage), findsNothing);
    });

    testWidgets('deve exibir loading quando ViewModel estiver carregando', (
      tester,
    ) async {
      _mockLoadingState();

      await _pumpLoginPage(tester);

      expect(find.byKey(AppKeys.primaryButtonLoading), findsOneWidget);
      expect(find.byKey(AppKeys.errorMessage), findsNothing);
    });
  });

  //===========================================================================
  // Responsividade
  //===========================================================================

  group('Responsividade', () {
    testWidgets('deve renderizar corretamente em telas pequenas', (
      tester,
    ) async {
      _setSmallScreen(tester);

      await _pumpLoginPage(tester);

      expect(find.byType(LoginPage), findsOneWidget);
      expect(find.byType(AuthHeader), findsOneWidget);
      expect(find.byType(AuthCard), findsOneWidget);
      expect(find.byType(OrDivider), findsOneWidget);
    });

    testWidgets(
      'deve permitir acessar o botão Criar Conta através da rolagem',
      (tester) async {
        await _pumpLoginPage(tester);

        await tester.ensureVisible(
          find.byKey(AppKeys.createAccountButton).first,
        );

        expect(find.byKey(AppKeys.createAccountButton), findsOneWidget);
      },
    );

    testWidgets('deve evitar overflow em telas pequenas', (tester) async {
      _setSmallScreen(tester);

      await _pumpLoginPage(tester);

      expect(tester.takeException(), isNull);
    });
  });
}
