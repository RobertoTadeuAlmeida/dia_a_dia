import 'package:dia_a_dia/modules/login/repositories/auth_repository.dart';
import 'package:dia_a_dia/modules/login/viewmodel/signup_viewmodel.dart';
import 'package:dia_a_dia/modules/users/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// -----------------------------------------------------------------------------
// Mocks
// -----------------------------------------------------------------------------

class MockAuthRepository extends Mock implements AuthRepository {}

// -----------------------------------------------------------------------------
// Constants
// -----------------------------------------------------------------------------

const tName = 'João';
const tLastName = 'Silva';
const tEmail = 'test@email.com';
const tPassword = '12345678';
const tConfirmPassword = '12345678';

// -----------------------------------------------------------------------------
// Helpers
// -----------------------------------------------------------------------------

late SignUpViewModel _viewModel;
late MockAuthRepository _repository;

void _preencherFormularioValido({
  String? name,
  String? lastName,
  String? email,
  String? password,
  String? confirmPassword,
}) {
  _viewModel.name = name ?? tName;
  _viewModel.lastName = lastName ?? tLastName;
  _viewModel.email = email ?? tEmail;
  _viewModel.password = password ?? tPassword;
  _viewModel.confirmPassword = confirmPassword ?? tConfirmPassword;
}

void _mockSignUpSuccess() {
  when(
    () => _repository.signUpWithEmailAndPassword(
      name: any(named: 'name'),
      lastName: any(named: 'lastName'),
      email: any(named: 'email'),
      password: any(named: 'password'),
    ),
  ).thenAnswer((_) async {});
}

void _mockSignUpFailure(String message) {
  when(
    () => _repository.signUpWithEmailAndPassword(
      name: any(named: 'name'),
      lastName: any(named: 'lastName'),
      email: any(named: 'email'),
      password: any(named: 'password'),
    ),
  ).thenThrow(Exception(message));
}

void _verifySignUpCalled() {
  verify(
    () => _repository.signUpWithEmailAndPassword(
      name: any(named: 'name'),
      lastName: any(named: 'lastName'),
      email: any(named: 'email'),
      password: any(named: 'password'),
    ),
  ).called(1);
}

void _verifySignUpNeverCalled() {
  verifyNever(
    () => _repository.signUpWithEmailAndPassword(
      name: any(named: 'name'),
      lastName: any(named: 'lastName'),
      email: any(named: 'email'),
      password: any(named: 'password'),
    ),
  );
}

void main() {
  setUp(() {
    _repository = MockAuthRepository();
    _viewModel = SignUpViewModel(repository: _repository);
  });

  tearDown(() {
    _viewModel.dispose();
  });

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Estado Inicial
  // ---------------------------------------------------------------------------
  group('Estado Inicial', () {
    test('deve iniciar sem mensagens de erro nos campos', () {
      // Assert
      expect(_viewModel.nameError, isNull);
      expect(_viewModel.lastNameError, isNull);
      expect(_viewModel.emailError, isNull);
      expect(_viewModel.passwordError, isNull);
      expect(_viewModel.confirmPasswordError, isNull);
    });

    test('deve iniciar com estado de carregamento desabilitado', () {
      // Assert
      expect(_viewModel.isLoading, isFalse);
    });

    test('deve iniciar com o botão de cadastro desabilitado', () {
      // Assert
      expect(_viewModel.isButtonEnabled, isFalse);
    });

    test('deve iniciar com formulário inválido', () {
      // Assert
      expect(_viewModel.isFormValid, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Validação do Campo Nome
  // ---------------------------------------------------------------------------
  group('Nome', () {
    test('deve definir erro quando o nome estiver vazio', () {
      // Arrange
      _preencherFormularioValido(name: '');

      // Act
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.nameError, 'Nome obrigatório.');
      expect(_viewModel.isFormValid, isFalse);
    });

    test('deve definir erro quando o nome contiver apenas espaços', () {
      // Arrange
      _preencherFormularioValido(name: '   ');

      // Act
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.nameError, 'Nome obrigatório.');
      expect(_viewModel.isFormValid, isFalse);
    });

    test(
      'deve remover espaços das extremidades do nome antes da validação',
      () {
        // Arrange
        _preencherFormularioValido(name: ' João ');

        // Act
        _viewModel.validateForm();

        // Assert
        expect(_viewModel.name, 'João');
        expect(_viewModel.isFormValid, isTrue);
        expect(_viewModel.nameError, isNull);
      },
    );

    test('deve definir erro quando o nome possuir menos de 2 caracteres', () {
      // Arrange
      _preencherFormularioValido(name: 'J');

      // Act
      _viewModel.validateForm();

      // Assert
      expect(
        _viewModel.nameError,
        'O nome deve possuir no mínimo 2 caracteres.',
      );
      expect(_viewModel.isFormValid, isFalse);
    });

    test('deve considerar nome válido quando possuir 2 ou mais caracteres', () {
      // Arrange
      _preencherFormularioValido(name: 'Jo');

      // Act
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.nameError, isNull);
      expect(_viewModel.isFormValid, isTrue);
    });

    test('deve limpar erro de nome quando o valor se tornar válido', () {
      // Arrange
      _preencherFormularioValido(name: 'J');
      _viewModel.validateForm();
      expect(
        _viewModel.nameError,
        'O nome deve possuir no mínimo 2 caracteres.',
      );

      // Act
      _viewModel.name = 'João';
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.nameError, isNull);
      expect(_viewModel.isFormValid, isTrue);
    });
  });

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Validação do Campo Sobrenome
  // ---------------------------------------------------------------------------
  group('Sobrenome', () {
    test('deve definir erro quando o sobrenome estiver vazio', () {
      // Arrange
      _preencherFormularioValido(lastName: '');

      // Act
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.lastNameError, 'Sobrenome obrigatório.');
      expect(_viewModel.isFormValid, isFalse);
    });

    test('deve definir erro quando o sobrenome contiver apenas espaços', () {
      // Arrange
      _preencherFormularioValido(lastName: '   ');

      // Act
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.lastNameError, 'Sobrenome obrigatório.');
      expect(_viewModel.isFormValid, isFalse);
    });

    test('deve remover espaços antes de validar o sobrenome', () {
      // Arrange
      _preencherFormularioValido(lastName: ' Silva ');

      // Act
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.lastName, 'Silva');
      expect(_viewModel.isFormValid, isTrue);
      expect(_viewModel.lastNameError, isNull);
    });

    test(
      'deve definir erro quando o sobrenome possuir menos de 2 caracteres',
      () {
        // Arrange
        _preencherFormularioValido(lastName: 'S');

        // Act
        _viewModel.validateForm();

        // Assert
        expect(
          _viewModel.lastNameError,
          'O sobrenome deve possuir no mínimo 2 caracteres.',
        );
        expect(_viewModel.isFormValid, isFalse);
      },
    );

    test(
      'deve considerar sobrenome válido quando possuir 2 ou mais caracteres',
      () {
        // Arrange
        _preencherFormularioValido(lastName: 'Sil');

        // Act
        _viewModel.validateForm();

        // Assert
        expect(_viewModel.lastNameError, isNull);
        expect(_viewModel.isFormValid, isTrue);
      },
    );

    test('deve limpar erro de sobrenome quando o valor se tornar válido', () {
      // Arrange
      _preencherFormularioValido(lastName: 'S');
      _viewModel.validateForm();
      expect(
        _viewModel.lastNameError,
        'O sobrenome deve possuir no mínimo 2 caracteres.',
      );

      // Act
      _viewModel.lastName = 'Silva';
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.lastNameError, isNull);
      expect(_viewModel.isFormValid, isTrue);
    });
  });

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Validação do Campo E-mail
  // ---------------------------------------------------------------------------
  group('E-mail', () {
    test('deve definir erro quando o e-mail estiver vazio', () {
      // Arrange
      _preencherFormularioValido(email: '');

      // Act
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.emailError, 'E-mail obrigatório.');
      expect(_viewModel.isFormValid, isFalse);
    });

    test('deve definir erro quando o e-mail contiver apenas espaços', () {
      // Arrange
      _preencherFormularioValido(email: '   ');

      // Act
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.emailError, 'E-mail obrigatório.');
      expect(_viewModel.isFormValid, isFalse);
    });

    test('deve remover espaços antes de validar o e-mail', () {
      // Arrange
      _preencherFormularioValido(email: ' test@email.com ');

      // Act
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.email, 'test@email.com');
      expect(_viewModel.isFormValid, isTrue);
      expect(_viewModel.emailError, isNull);
    });

    test('deve definir erro quando o e-mail possuir formato inválido', () {
      // Arrange
      _preencherFormularioValido(email: 'test@email');

      // Act
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.emailError, 'Formato de e-mail inválido.');
      expect(_viewModel.isFormValid, isFalse);
    });

    test('deve considerar e-mail válido quando o formato estiver correto', () {
      // Arrange
      _preencherFormularioValido(email: 'test@email.com');

      // Act
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.emailError, isNull);
      expect(_viewModel.isFormValid, isTrue);
    });

    test('deve limpar erro de e-mail quando o valor se tornar válido', () {
      // Arrange
      _preencherFormularioValido(email: 'test@email');
      _viewModel.validateForm();
      expect(_viewModel.emailError, 'Formato de e-mail inválido.');

      // Act
      _viewModel.email = 'test@email.com';
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.emailError, isNull);
      expect(_viewModel.isFormValid, isTrue);
    });
  });

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Validação do Campo Senha
  // ---------------------------------------------------------------------------
  group('Senha', () {
    test('deve definir erro quando a senha estiver vazia', () {
      // Arrange
      _preencherFormularioValido(password: '');

      // Act
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.passwordError, 'Senha obrigatória.');
      expect(_viewModel.isFormValid, isFalse);
    });

    test('deve definir erro quando a senha possuir menos de 8 caracteres', () {
      // Arrange
      _preencherFormularioValido(password: '1234567');

      // Act
      _viewModel.validateForm();

      // Assert
      expect(
        _viewModel.passwordError,
        'A senha deve possuir no mínimo 8 caracteres.',
      );
      expect(_viewModel.isFormValid, isFalse);
    });

    test(
      'deve considerar senha válida quando possuir 8 ou mais caracteres',
      () {
        // Arrange
        _preencherFormularioValido(password: '12345678');

        // Act
        _viewModel.validateForm();

        // Assert
        expect(_viewModel.passwordError, isNull);
        expect(_viewModel.isFormValid, isTrue);
      },
    );

    test('deve limpar erro de senha quando o valor se tornar válido', () {
      // Arrange
      _preencherFormularioValido(password: '1234567');
      _viewModel.validateForm();
      expect(
        _viewModel.passwordError,
        'A senha deve possuir no mínimo 8 caracteres.',
      );

      // Act
      _viewModel.password = '12345678';
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.passwordError, isNull);
      expect(_viewModel.isFormValid, isTrue);
    });
  });

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Validação da Confirmação de Senha
  // ---------------------------------------------------------------------------
  group('Confirmação de Senha', () {
    test('deve definir erro quando a confirmação estiver vazia', () {
      // Arrange
      _preencherFormularioValido(confirmPassword: '');

      // Act
      _viewModel.validateForm();

      // Assert
      expect(
        _viewModel.confirmPasswordError,
        'Confirmação de senha obrigatória.',
      );
      expect(_viewModel.isFormValid, isFalse);
    });

    test(
      'deve considerar confirmação válida quando senha e confirmação forem iguais',
      () {
        // Arrange
        _preencherFormularioValido(confirmPassword: tPassword);

        // Act
        _viewModel.validateForm();

        // Assert
        expect(_viewModel.confirmPasswordError, isNull);
        expect(_viewModel.isFormValid, isTrue);
      },
    );

    test('deve definir erro quando a senha e confirmação forem diferentes', () {
      // Arrange
      _preencherFormularioValido(confirmPassword: 'different_password');

      // Act
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.confirmPasswordError, 'As senhas não coincidem.');
      expect(_viewModel.isFormValid, isFalse);
    });

    test(
      'não deve validar correspondência enquanto a senha principal for inválida',
      () {
        // Arrange
        _preencherFormularioValido(password: '123', confirmPassword: '123');

        // Act
        _viewModel.validateForm();

        // Assert
        expect(
          _viewModel.passwordError,
          'A senha deve possuir no mínimo 8 caracteres.',
        );
        expect(_viewModel.confirmPasswordError, isNull);
        expect(_viewModel.isFormValid, isFalse);
      },
    );

    test('deve limpar erro de confirmação quando o valor se tornar válido', () {
      // Arrange
      _preencherFormularioValido(confirmPassword: 'wrong');
      _viewModel.validateForm();
      expect(_viewModel.confirmPasswordError, 'As senhas não coincidem.');

      // Act
      _viewModel.confirmPassword = tPassword;
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.confirmPasswordError, isNull);
      expect(_viewModel.isFormValid, isTrue);
    });
  });

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Gestão do Botão de Cadastro
  // ---------------------------------------------------------------------------
  group('Botão', () {
    test(
      'deve manter o botão desabilitado quando o formulário estiver vazio',
      () {
        // Act
        _viewModel.validateForm();

        // Assert
        expect(_viewModel.isFormValid, isFalse);
        expect(_viewModel.isButtonEnabled, isFalse);
      },
    );

    test('deve habilitar o botão quando todos os campos estiverem válidos', () {
      // Arrange
      _preencherFormularioValido();

      // Act
      _viewModel.validateForm();

      // Assert
      expect(_viewModel.isFormValid, isTrue);
      expect(_viewModel.isButtonEnabled, isTrue);
    });

    test(
      'deve reabilitar o botão após falha no cadastro respeitando as validações do formulário',
      () async {
        // Arrange
        _preencherFormularioValido();
        _mockSignUpFailure('Erro');

        // Act
        await _viewModel.signUp();

        // Assert
        _verifySignUpCalled();
        expect(_viewModel.isLoading, isFalse);
        expect(_viewModel.isButtonEnabled, isTrue);
      },
    );
  });

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Fluxo de Cadastro
  // ---------------------------------------------------------------------------
  group('Cadastro', () {
    test(
      'deve encerrar o estado de carregamento quando o cadastro for concluído com sucesso',
      () async {
        // Arrange
        _preencherFormularioValido();
        _mockSignUpSuccess();

        // Act
        await _viewModel.signUp();

        // Assert
        _verifySignUpCalled();
        expect(_viewModel.isLoading, isFalse);
      },
    );

    test(
      'deve encerrar o estado de carregamento quando o cadastro falhar',
      () async {
        // Arrange
        _preencherFormularioValido();
        _mockSignUpFailure('Erro');

        // Act
        await _viewModel.signUp();

        // Assert
        _verifySignUpCalled();
        expect(_viewModel.isLoading, isFalse);
      },
    );

    test(
      'não deve invocar o repositório quando existir erro de validação no formulário',
      () async {
        // Arrange
        _preencherFormularioValido(password: 'short');

        // Act
        await _viewModel.signUp();

        // Assert
        expect(_viewModel.isFormValid, isFalse);
        _verifySignUpNeverCalled();
      },
    );

    test(
      'deve sinalizar sucesso com mensagem amigável quando o cadastro for concluído',
      () async {
        // Arrange
        _preencherFormularioValido();
        _mockSignUpSuccess();

        // Act
        await _viewModel.signUp();

        // Assert
        _verifySignUpCalled();
        expect(_viewModel.sucessMessage, 'Cadastro realizado com sucesso.');
      },
    );

    test(
      'deve enviar os dados preenchidos corretamente para o repositório',
      () async {
        // Arrange
        _preencherFormularioValido();
        _mockSignUpSuccess();

        // Act
        await _viewModel.signUp();

        // Assert
        // Utilização do verify explícito para validar argumentos exatos
        verify(
          () => _repository.signUpWithEmailAndPassword(
            name: tName,
            lastName: tLastName,
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
      },
    );

    test(
      'deve limpar a mensagem de erro anterior após um novo cadastro realizado com sucesso',
      () async {
        // Arrange
        _preencherFormularioValido();
        _mockSignUpFailure('Erro');
        await _viewModel.signUp();
        expect(_viewModel.errorMessage, 'Erro');

        reset(_repository);
        _mockSignUpSuccess();

        // Act
        await _viewModel.signUp();

        // Assert
        expect(_viewModel.errorMessage, isNull);
      },
    );
  });

  test(
    'deve validar o formulário automaticamente antes de iniciar o cadastro',
    () async {
      // Arrange
      _preencherFormularioValido(password: '123');

      // Act
      await _viewModel.signUp();

      // Assert
      expect(_viewModel.passwordError, isNotNull);
      expect(_viewModel.isFormValid, isFalse);
      expect(_viewModel.isLoading, isFalse);

      _verifySignUpNeverCalled();
    },
  );

  // ---------------------------------------------------------------------------
  // RESPONSABILIDADE: Tratamento de Erros de Integração
  // ---------------------------------------------------------------------------
  group('Mapeamento de Erros', () {
    test(
      'deve exibir mensagem específica quando o e-mail já estiver cadastrado',
      () async {
        // Arrange
        _preencherFormularioValido();
        _mockSignUpFailure('E-mail já cadastrado');

        // Act
        await _viewModel.signUp();

        // Assert
        _verifySignUpCalled();
        expect(_viewModel.errorMessage, 'E-mail já cadastrado');
        expect(_viewModel.isLoading, isFalse);
      },
    );

    test(
      'deve exibir mensagem de falha na conexão quando o cadastro falhar por falta de internet',
      () async {
        // Arrange
        _preencherFormularioValido();
        _mockSignUpFailure('Sem conexão com a internet');

        // Act
        await _viewModel.signUp();

        // Assert
        _verifySignUpCalled();
        expect(
          _viewModel.errorMessage,
          contains(
            'Sem conexão com a internet. Verifique sua rede e tente novamente.',
          ),
        );
        expect(_viewModel.isLoading, isFalse);
      },
    );

    test(
      'deve exibir mensagem amigável genérica para erro inesperado no cadastro',
      () async {
        // Arrange
        _preencherFormularioValido();
        _mockSignUpFailure('Erro inesperado');

        // Act
        await _viewModel.signUp();

        // Assert
        _verifySignUpCalled();
        expect(
          _viewModel.errorMessage,
          'Ops! Não foi possível concluir o cadastro. Tente novamente mais tarde.',
        );
        expect(_viewModel.isLoading, isFalse);
      },
    );

    test(
      'deve limpar a mensagem de sucesso quando um novo cadastro falhar',
      () async {
        // Arrange
        _preencherFormularioValido();

        _mockSignUpSuccess();
        await _viewModel.signUp();

        expect(_viewModel.sucessMessage, isNotNull);

        reset(_repository);

        _mockSignUpFailure('Erro inesperado');

        // Act
        await _viewModel.signUp();

        // Assert
        expect(_viewModel.sucessMessage, isNull);
        expect(_viewModel.errorMessage, isNotNull);
      },
    );
  });
}
