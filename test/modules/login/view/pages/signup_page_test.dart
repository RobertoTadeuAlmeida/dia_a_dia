import 'package:dia_a_dia/core/constants/app_keys.dart';
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
      child: const MaterialApp(home: SignupPage()),
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

    testWidgets('deve exibir o formulário completo', (tester) async {


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

      expect(find.byKey(AppKeys.createAccountButton), findsOneWidget);
    });
  });

  //---------------------------------------------------------------------------
  // RESPONSABILIDADE: Campos do Formulário
  //---------------------------------------------------------------------------

  group('Campos', () {
    testWidgets('deve exibir campo Nome', (tester) async {});

    testWidgets('deve exibir campo Sobrenome', (tester) async {});

    testWidgets('deve exibir campo E-mail', (tester) async {});

    testWidgets('deve exibir campo Senha', (tester) async {});

    testWidgets('deve exibir campo Confirmar Senha', (tester) async {});

    testWidgets(
      'deve enviar o texto digitado para a ViewModel',
      (tester) async {},
    );
  });

  //---------------------------------------------------------------------------
  // RESPONSABILIDADE: Botão Criar Conta
  //---------------------------------------------------------------------------

  group('Botão Criar Conta', () {
    testWidgets('deve iniciar desabilitado', (tester) async {});

    testWidgets(
      'deve habilitar quando o formulário estiver válido',
      (tester) async {},
    );

    testWidgets('deve chamar signUp ao ser pressionado', (tester) async {});

    testWidgets(
      'deve permanecer desabilitado durante o loading',
      (tester) async {},
    );
  });

  //---------------------------------------------------------------------------
  // RESPONSABILIDADE: Estados da Interface
  //---------------------------------------------------------------------------

  group('Estados da Tela', () {
    testWidgets(
      'deve exibir indicador de carregamento durante o cadastro',
      (tester) async {},
    );

    testWidgets(
      'deve ocultar indicador quando o cadastro terminar',
      (tester) async {},
    );

    testWidgets(
      'deve exibir mensagem de erro quando houver falha',
      (tester) async {},
    );

    testWidgets(
      'deve remover mensagem de erro após novo sucesso',
      (tester) async {},
    );

    testWidgets(
      'deve exibir mensagem de sucesso quando cadastro for concluído',
      (tester) async {},
    );
  });

  //---------------------------------------------------------------------------
  // RESPONSABILIDADE: Campos de Senha
  //---------------------------------------------------------------------------

  group('Senha', () {
    testWidgets('deve ocultar senha inicialmente', (tester) async {});

    testWidgets(
      'deve mostrar senha ao tocar no ícone de visualização',
      (tester) async {},
    );

    testWidgets(
      'deve ocultar novamente ao tocar pela segunda vez',
      (tester) async {},
    );

    testWidgets(
      'deve aplicar o mesmo comportamento na confirmação de senha',
      (tester) async {},
    );
  });

  //---------------------------------------------------------------------------
  // RESPONSABILIDADE: Navegação
  //---------------------------------------------------------------------------

  group('Navegação', () {
    testWidgets(
      'deve retornar para Login ao pressionar Voltar',
      (tester) async {},
    );

    testWidgets(
      'deve navegar para Login ao tocar em Fazer Login',
      (tester) async {},
    );

    testWidgets(
      'deve navegar para Home após cadastro concluído',
      (tester) async {},
    );
  });

  //---------------------------------------------------------------------------
  // RESPONSABILIDADE: Login Social
  //---------------------------------------------------------------------------

  group('Google', () {
    testWidgets('deve exibir botão Continuar com Google', (tester) async {});

    testWidgets(
      'deve chamar signUpWithGoogle ao tocar no botão',
      (tester) async {},
    );
  });

  //---------------------------------------------------------------------------
  // RESPONSABILIDADE: Acessibilidade
  //---------------------------------------------------------------------------

  group('Acessibilidade', () {
    testWidgets(
      'deve permitir rolagem quando o teclado estiver aberto',
      (tester) async {},
    );

    testWidgets('deve possuir labels acessíveis nos campos', (tester) async {});
  });

  //---------------------------------------------------------------------------
  // RESPONSABILIDADE: Ciclo de Vida
  //---------------------------------------------------------------------------
  group('Ciclo de Vida', () {
    testWidgets(
      'não deve lançar exceções ao remover a tela durante o carregamento',
      (tester) async {},
    );
  });
}
