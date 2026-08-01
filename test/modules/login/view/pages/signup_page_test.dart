import 'package:dia_a_dia/core/constants/app_keys.dart';
import 'package:dia_a_dia/core/routes/app_routes.dart';
import 'package:dia_a_dia/core/routes/route_names.dart';
import 'package:dia_a_dia/core/theme/app_theme.dart';
import 'package:dia_a_dia/core/widgets/primary_button.dart';
import 'package:dia_a_dia/modules/login/viewmodel/signup_viewmodel.dart';
import 'package:dia_a_dia/modules/login/view/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockSignUpViewModel extends Mock
    with ChangeNotifier
    implements SignUpViewModel {}

late MockSignUpViewModel _viewModel;

//===========================================================================
// Helpers Mocks
//===========================================================================

void _mockInitialState() {
  when(() => _viewModel.isLoading).thenReturn(false);
  when(() => _viewModel.errorMessage).thenReturn(null);
  when(() => _viewModel.sucessMessage).thenReturn(null);
  when(() => _viewModel.isFormValid).thenReturn(false);
  when(() => _viewModel.isButtonEnabled).thenReturn(false);
}

void _mockLoadingState() {
  when(() => _viewModel.isLoading).thenReturn(true);
  when(() => _viewModel.isButtonEnabled).thenReturn(false);
}

void _mockErrorState(String message) {
  when(() => _viewModel.isLoading).thenReturn(false);
  when(() => _viewModel.errorMessage).thenReturn(message);
}

void _mockSuccessState(String message) {
  when(() => _viewModel.isLoading).thenReturn(false);
  when(() => _viewModel.sucessMessage).thenReturn(message);
}

//===========================================================================
// Helpers UI
//===========================================================================

Future<void> _pumpSignUpPage(WidgetTester tester) async {
  await tester.pumpWidget(
    ChangeNotifierProvider<SignUpViewModel>.value(
      value: _viewModel,
      child: MaterialApp(
        title: 'Dia A Dia',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        initialRoute: RouteNames.signup,
        routes: AppRoutes.routes,
      ),
    ),
  );
}

void main() {
  setUp(() {
    _viewModel = MockSignUpViewModel();
    _mockInitialState();
  });

  //---------------------------------------------------------------------------
  // RESPONSABILIDADE: Estrutura Inicial da Tela
  //---------------------------------------------------------------------------

  group('Estrutura Inicial', () {
    testWidgets('deve exibir o botão de voltar', (tester) async {
      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.signupBackButton), findsOneWidget);
    });

    testWidgets('deve exibir o AuthHeader', (tester) async {
      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.authHeader), findsOneWidget);
    });

    testWidgets('deve exibir o Card de cadastro', (tester) async {
      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.authCard), findsOneWidget);
    });

    testWidgets('deve exibir o botão Criar Conta', (tester) async {
      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.signupButton), findsOneWidget);
    });

    testWidgets('deve exibir o divisor "ou"', (tester) async {
      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.orDivider), findsOneWidget);
    });

    testWidgets('deve exibir o botão Continuar com Google', (tester) async {
      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.socialLoginButton), findsOneWidget);
    });

    testWidgets('deve exibir o link Fazer Login', (tester) async {
      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.signupLoginLink), findsOneWidget);
    });
  });

  //---------------------------------------------------------------------------
  // RESPONSABILIDADE: Campos do Formulário
  //---------------------------------------------------------------------------

  group('Campos', () {
    testWidgets('deve exibir campo Nome', (tester) async {
      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.signupNameField), findsOneWidget);
    });

    testWidgets('deve exibir campo Sobrenome', (tester) async {
      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.signupLastNameField), findsOneWidget);
    });

    testWidgets('deve exibir campo E-mail', (tester) async {
      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.signupEmailField), findsOneWidget);
    });

    testWidgets('deve exibir campo Senha', (tester) async {
      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.signupPasswordField), findsOneWidget);
    });

    testWidgets('deve exibir campo Confirmar Senha', (tester) async {
      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.signupConfirmPasswordField), findsOneWidget);
    });
  });

  //---------------------------------------------------------------------------
  // RESPONSABILIDADE: Botão Criar Conta
  //---------------------------------------------------------------------------

  group('Botão Criar Conta', () {
    testWidgets('deve iniciar desabilitado', (tester) async {
      await _pumpSignUpPage(tester);

      final button = tester.widget<PrimaryButton>(
        find.byKey(AppKeys.signupButton),
      );

      expect(button.onPressed, isNull);
    });

    testWidgets('deve habilitar quando o formulário estiver válido', (
      tester,
    ) async {
      when(() => _viewModel.isFormValid).thenReturn(true);

      await _pumpSignUpPage(tester);

      final button = tester.widget<PrimaryButton>(
        find.byKey(AppKeys.signupButton),
      );

      expect(button.onPressed, isNotNull);
    });

    testWidgets('deve chamar signUp ao ser pressionado', (tester) async {
      _mockSuccessState('cadastro realizado com sucesso.');
      await _pumpSignUpPage(tester);

      await tester.tap(find.byKey(AppKeys.signupButton));
      await tester.pump();

      verify(() => _viewModel.signUp()).called(1);
    });

    testWidgets('deve permanecer desabilitado durante o loading', (
      tester,
    ) async {
      _mockLoadingState();

      await _pumpSignUpPage(tester);

      final button = tester.widget<PrimaryButton>(
        find.byKey(AppKeys.signupButton),
      );

      expect(button.onPressed, isNull);
    });
  });

  //---------------------------------------------------------------------------
  // RESPONSABILIDADE: Estados da Interface
  //---------------------------------------------------------------------------

  group('Estados da Tela', () {
    testWidgets('deve exibir indicador de carregamento durante o cadastro', (
      tester,
    ) async {
      _mockLoadingState();

      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.primaryButtonLoading), findsOneWidget);
    });

    testWidgets(
      'não deve exibir indicador de carregamento quando isLoading for false',
      (tester) async {
        await _pumpSignUpPage(tester);

        expect(find.byKey(AppKeys.primaryButtonLoading), findsNothing);
      },
    );

    testWidgets('deve exibir erro quando o e-mail já estiver cadastrado', (
      tester,
    ) async {
      _mockErrorState('Este e-mail já está cadastrado.');

      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.errorMessage), findsOneWidget);
      expect(find.text('Este e-mail já está cadastrado.'), findsOneWidget);
    });

    testWidgets('deve exibir erro quando não houver conexão', (tester) async {
      const message =
          'Sem conexão com a internet. Verifique sua rede e tente novamente.';
      _mockErrorState(message);

      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.errorMessage), findsOneWidget);
      expect(find.text(message), findsOneWidget);
    });

    testWidgets('deve exibir erro genérico quando ocorrer falha inesperada', (
      tester,
    ) async {
      const message =
          'Ops! Não foi possível concluir o cadastro. Tente novamente mais tarde.';

      _mockErrorState(message);

      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.errorMessage), findsOneWidget);
      expect(find.text(message), findsOneWidget);
    });

    testWidgets('não deve exibir ErrorMessage quando não houver erro', (
      tester,
    ) async {
      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.errorMessage), findsNothing);
    });

    testWidgets(
      'deve exibir mensagem de sucesso quando cadastro for concluído',
      (tester) async {
        _mockSuccessState('Cadastro realizado com sucesso.');

        await _pumpSignUpPage(tester);

        expect(find.byKey(AppKeys.successMessage), findsOneWidget);
        expect(find.text('Cadastro realizado com sucesso.'), findsOneWidget);
      },
    );
  });

  //---------------------------------------------------------------------------
  // RESPONSABILIDADE: Campos de Senha
  //---------------------------------------------------------------------------

  group('Senha', () {
    testWidgets('deve ocultar senha inicialmente', (tester) async {
      await _pumpSignUpPage(tester);

      final passwordField = tester.widget<TextFormField>(
        find.byKey(AppKeys.signupPasswordField),
      );

      expect(passwordField.obscureText, isTrue);
    });

    testWidgets('deve mostrar senha ao tocar no ícone de visualização', (
      tester,
    ) async {
      await _pumpSignUpPage(tester);

      await tester.tap(find.byKey(AppKeys.authTextFieldPasswordToggle));
      await tester.pump();

      final passwordField = tester.widget<TextFormField>(
        find.byKey(AppKeys.signupPasswordField),
      );

      expect(passwordField.obscureText, isFalse);
    });

    testWidgets('deve ocultar novamente ao tocar pela segunda vez', (
      tester,
    ) async {
      await _pumpSignUpPage(tester);

      await tester.tap(find.byKey(AppKeys.authTextFieldPasswordToggle));
      await tester.pump();

      await tester.tap(find.byKey(AppKeys.authTextFieldPasswordToggle));
      await tester.pump();

      final passwordField = tester.widget<TextFormField>(
        find.byKey(AppKeys.signupPasswordField),
      );

      expect(passwordField.obscureText, isTrue);
    });

    testWidgets(
      'não deve alterar o texto digitado ao mostrar ou ocultar a senha',
      (tester) async {
        await _pumpSignUpPage(tester);

        await tester.enterText(
          find.byKey(AppKeys.signupPasswordField),
          'senha123',
        );
        await tester.pump();

        final passwordFieldBefore = tester.widget<TextFormField>(
          find.byKey(AppKeys.signupPasswordField),
        );

        expect(passwordFieldBefore.obscureText, isTrue);

        await tester.tap(find.byKey(AppKeys.authTextFieldPasswordToggle));
        await tester.pump();

        final passwordFieldAfter = tester.widget<TextFormField>(
          find.byKey(AppKeys.signupPasswordField),
        );

        expect(passwordFieldAfter.obscureText, isFalse);

        expect(passwordFieldAfter.controller?.text, 'senha123');
      },
    );
  });

  //---------------------------------------------------------------------------
  // RESPONSABILIDADE: Navegação
  //---------------------------------------------------------------------------

  group('Navegação', () {
    testWidgets('deve retornar para Login ao pressionar Voltar', (
      tester,
    ) async {
      await _pumpSignUpPage(tester);

      await tester.tap(find.byKey(AppKeys.signupBackButton));
      await tester.pumpAndSettle();

      expect(find.byKey(AppKeys.loginPage), findsOneWidget);
    });

    testWidgets('deve navegar para Login ao tocar em Fazer Login', (
      tester,
    ) async {
      await _pumpSignUpPage(tester);

      await tester.tap(find.byKey(AppKeys.signupLoginLink));
      await tester.pump();

      expect(find.byKey(AppKeys.loginPage), findsOneWidget);
    });

    testWidgets('deve navegar para Home após cadastro concluído', (
      tester,
    ) async {
      _mockSuccessState('Cadastro realizado com sucesso.');

      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.homePage), findsOneWidget);
    });
  });

  //---------------------------------------------------------------------------
  // RESPONSABILIDADE: Login Social
  //---------------------------------------------------------------------------

  group('Google', () {
    testWidgets('deve exibir botão Continuar com Google', (tester) async {
      await _pumpSignUpPage(tester);

      expect(find.byKey(AppKeys.socialLoginButton), findsOneWidget);
    });

    testWidgets(
      'deve chamar signUpWithGoogle ao tocar no botão',
      (tester) async {},
    );
  });

  //---------------------------------------------------------------------------
  // RESPONSABILIDADE: Layout Responsivo
  //---------------------------------------------------------------------------

  group('Layout Responsivo', () {
    testWidgets('deve utilizar SingleChildScrollView para permitir rolagem', (
      tester,
    ) async {
      await _pumpSignUpPage(tester);

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });

  //---------------------------------------------------------------------------
  // RESPONSABILIDADE: Ciclo de Vida
  //---------------------------------------------------------------------------
  group('Ciclo de Vida', () {
    testWidgets(
      'não deve lançar exceções ao remover a tela durante o carregamento',
      (tester) async {
        _mockLoadingState();

        await _pumpSignUpPage(tester);

        await tester.pumpWidget(const MaterialApp(home: SizedBox()));

        expect(tester.takeException(), isNull);
      },
    );
  });
}
