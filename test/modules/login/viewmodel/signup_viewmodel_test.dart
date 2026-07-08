import 'package:dia_a_dia/modules/login/repositories/auth_repository.dart';
import 'package:dia_a_dia/modules/login/viewmodel/signup_viewmodel.dart';
import 'package:dia_a_dia/modules/users/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserModel extends Mock implements UserModel {}

void main() {
  late SignUpViewModel viewModel;
  late MockAuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    viewModel = SignUpViewModel(repository: repository);
  });

  tearDown(() {
    viewModel.dispose();
  });

  //----------------------------------------------------------------------------
  // RESPONSABILIDADE: Registro de Novos Usuários
  // Funcionalidade: signUpWithEmailAndPassword
  //----------------------------------------------------------------------------
  group('Nome', () {
    test(
      'deve retornar erro quando nome for vazio e impedir envio do formulario',
      () {
        _preencherFormularioValido(viewModel, name: '');

        viewModel.validateForm();

        expect(viewModel.nameError, 'Nome obrigatório.');
        expect(viewModel.isFormValid, isFalse);
      },
    );

    test('deve retornar erro quando nome conter apenas espacos', () {
      _preencherFormularioValido(viewModel, name: '   ');

      viewModel.validateForm();

      expect(viewModel.nameError, 'Nome obrigatório.');
      expect(viewModel.isFormValid, isFalse);
    });

    test(
      'deve remover espacos das extremidades do nome antes da validacao',
      () {
        _preencherFormularioValido(viewModel, name: ' João ');

        viewModel.validateForm();

        expect(viewModel.name, 'João');
        expect(viewModel.isFormValid, isTrue);
        expect(viewModel.nameError, isNull);
      },
    );

    test('deve retornar erro quando nome possuir menos de 2 caracteres', () {
      _preencherFormularioValido(viewModel, name: 'J');

      viewModel.validateForm();

      expect(
        viewModel.nameError,
        'O nome deve possuir no mínimo 2 caracteres.',
      );
      expect(viewModel.isFormValid, isFalse);
    });

    test('deve considerar nome valido quando possuir 2 ou mais caracteres', () {
      _preencherFormularioValido(viewModel, name: 'Jo');

      viewModel.validateForm();

      expect(viewModel.nameError, isNull);
      expect(viewModel.isFormValid, isTrue);
    });
    test('deve limpar erro de nome quando nome se tornar valido', () {
      _preencherFormularioValido(viewModel, name: 'J');

      viewModel.validateForm();

      expect(
        viewModel.nameError,
        'O nome deve possuir no mínimo 2 caracteres.',
      );
      expect(viewModel.isFormValid, isFalse);

      viewModel.name = 'João';
      viewModel.validateForm();

      expect(viewModel.nameError, isNull);
      expect(viewModel.isFormValid, isTrue);
    });

    test(
      'TODO(RF003): deve retornar erro quando o nome nao representar um nome valido',
      () {
        // Exemplos:
        // "123"
        // "@@@"
        // "Joao123"
        // "Maria@"
        //
        // Regra ainda nao documentada.
      },
    );
  });

  group('Sobrenome', () {
    test('deve retornar erro quando sobrenome for vazio', () {
      _preencherFormularioValido(viewModel, lastName: '');

      viewModel.validateForm();

      expect(viewModel.lastNameError, 'Sobrenome obrigatório.');
      expect(viewModel.isFormValid, isFalse);
    });

    test('deve retornar erro quando sobrenome conter apenas espacos', () {
      _preencherFormularioValido(viewModel, lastName: '   ');

      viewModel.validateForm();

      expect(viewModel.lastNameError, 'Sobrenome obrigatório.');
      expect(viewModel.isFormValid, isFalse);
    });

    test('deve remover espacos antes de validar sobrenome', () {
      _preencherFormularioValido(viewModel, lastName: ' Silva ');

      viewModel.validateForm();

      expect(viewModel.lastName, 'Silva');
      expect(viewModel.isFormValid, isTrue);
      expect(viewModel.lastNameError, isNull);
    });

    test(
      'deve retornar erro quando sobrenome possuir menos de 2 caracteres',
      () {
        _preencherFormularioValido(viewModel, lastName: 'S');

        viewModel.validateForm();

        expect(
          viewModel.lastNameError,
          'O sobrenome deve possuir no mínimo 2 caracteres.',
        );
        expect(viewModel.isFormValid, isFalse);
      },
    );

    test(
      'deve considerar sobrenome valido quando possuir 2 ou mais caracteres',
      () {
        _preencherFormularioValido(viewModel, lastName: 'Sil');

        viewModel.validateForm();

        expect(viewModel.lastNameError, isNull);
        expect(viewModel.isFormValid, isTrue);
      },
    );
    test('deve limpar erro de sobrenome quando sobrenome se tornar valido', () {
      _preencherFormularioValido(viewModel, lastName: 'S');

      viewModel.validateForm();

      expect(
        viewModel.lastNameError,
        'O sobrenome deve possuir no mínimo 2 caracteres.',
      );
      expect(viewModel.isFormValid, isFalse);

      viewModel.lastName = 'Silva';
      viewModel.validateForm();

      expect(viewModel.lastNameError, isNull);
      expect(viewModel.isFormValid, isTrue);
    });
  });
  group('E-mail', () {
    test('deve retornar erro quando email for vazio', () {
      _preencherFormularioValido(viewModel, email: '');

      viewModel.validateForm();

      expect(viewModel.emailError, 'E-mail obrigatório.');
      expect(viewModel.isFormValid, isFalse);
    });

    test('deve retornar erro quando email conter apenas espacos', () {
      _preencherFormularioValido(viewModel, email: '   ');

      viewModel.validateForm();

      expect(viewModel.emailError, 'E-mail obrigatório.');
      expect(viewModel.isFormValid, isFalse);
    });

    test('deve remover espacos antes de validar email', () {
      _preencherFormularioValido(viewModel, email: ' test@email.com ');

      viewModel.validateForm();

      expect(viewModel.email, 'test@email.com');
      expect(viewModel.isFormValid, isTrue);
      expect(viewModel.emailError, isNull);
    });

    test('deve retornar erro quando email possuir formato invalido', () {
      _preencherFormularioValido(viewModel, email: 'test@email');

      viewModel.validateForm();

      expect(viewModel.emailError, 'Formato de e-mail inválido.');
      expect(viewModel.isFormValid, isFalse);
    });

    test('deve considerar email valido quando formato estiver correto', () {
      _preencherFormularioValido(viewModel, email: 'test@email.com');

      viewModel.validateForm();

      expect(viewModel.emailError, isNull);
      expect(viewModel.isFormValid, isTrue);
    });

    test('deve limpar erro de email quando email se tornar valido', () {
      _preencherFormularioValido(viewModel, email: 'test@email');

      viewModel.validateForm();

      expect(viewModel.emailError, 'Formato de e-mail inválido.');
      expect(viewModel.isFormValid, isFalse);

      viewModel.email = 'test@email.com';

      viewModel.validateForm();

      expect(viewModel.emailError, isNull);
      expect(viewModel.isFormValid, isTrue);
    });
  });

  group('Senha', () {
    test('deve retornar erro quando senha for vazia', () {
      _preencherFormularioValido(viewModel, password: '');

      viewModel.validateForm();

      expect(viewModel.passwordError, 'Senha obrigatória.');
      expect(viewModel.isFormValid, isFalse);
    });

    test('deve retornar erro quando senha possuir menos de 8 caracteres', () {
      _preencherFormularioValido(viewModel, password: '1234567');

      viewModel.validateForm();

      expect(
        viewModel.passwordError,
        'A senha deve possuir no mínimo 8 caracteres.',
      );
      expect(viewModel.isFormValid, isFalse);
    });

    test(
      'deve considerar senha valida quando possuir 8 ou mais caracteres',
      () {
        _preencherFormularioValido(viewModel, password: '12345678');

        viewModel.validateForm();

        expect(viewModel.passwordError, isNull);
        expect(viewModel.isFormValid, isTrue);
      },
    );

    test('deve limpar erro de senha quando senha se tornar valida', () {
      _preencherFormularioValido(viewModel, password: '1234567');

      viewModel.validateForm();

      expect(
        viewModel.passwordError,
        'A senha deve possuir no mínimo 8 caracteres.',
      );
      expect(viewModel.isFormValid, isFalse);

      viewModel.password = '12345678';
      viewModel.validateForm();

      expect(viewModel.passwordError, isNull);
      expect(viewModel.isFormValid, isTrue);
    });
  });

  group('Confirmação de senha', () {
    test('deve retornar erro quando confirmacao for vazia', () {
      _preencherFormularioValido(viewModel, confirmPassword: '');

      viewModel.validateForm();

      expect(
        viewModel.confirmPasswordError,
        'Confirmação de senha obrigatória.',
      );
      expect(viewModel.isFormValid, isFalse);
    });

    test(
      'deve considerar confirmacao valida quando senha e confirmacao forem iguais',
      () {
        _preencherFormularioValido(viewModel, confirmPassword: '12345678');

        viewModel.validateForm();

        expect(viewModel.confirmPasswordError, isNull);
        expect(viewModel.isFormValid, isTrue);
      },
    );

    test('deve retornar erro quando senha e confirmacao forem diferentes', () {
      _preencherFormularioValido(viewModel, confirmPassword: '87654321');

      viewModel.validateForm();

      expect(viewModel.confirmPasswordError, 'As senhas não coincidem.');
      expect(viewModel.isFormValid, isFalse);
    });
    test('nao deve validar correspondencia enquanto senha for invalida', () {
      _preencherFormularioValido(
        viewModel,
        password: '1234567',
        confirmPassword: '12345678',
      );

      viewModel.validateForm();

      expect(
        viewModel.passwordError,
        'A senha deve possuir no mínimo 8 caracteres.',
      );
      expect(viewModel.confirmPasswordError, isNull);
      expect(viewModel.isFormValid, isFalse);
    });
    test('deve limpar erro de confirmacao quando confirmacao se tornar valida',
        () {
      _preencherFormularioValido(
        viewModel,
        password: '12345678',
        confirmPassword: '87654321',
      );
      viewModel.validateForm();
      expect(
        viewModel.confirmPasswordError,
        'As senhas não coincidem.',
      );
      expect(viewModel.isFormValid, isFalse);
      viewModel.confirmPassword = '12345678';
      viewModel.validateForm();
      expect(viewModel.confirmPasswordError, isNull);
      expect(viewModel.isFormValid, isTrue);
        });
  });

  group('Botão', () {
    test(
      'deve manter o botão desabilitado quando o formulário estiver vazio',
      () {},
    );

    test(
      'deve considerar formulario invalido quando existir erro em qualquer campo',
      () {},
    );

    test(
      'deve habilitar o botão quando todos os campos estiverem válidos',
      () {},
    );

    test('deve desabilitar o botão durante o processo de cadastro', () {});

    test(
      'deve reabilitar o botão após falha no cadastro respeitando as validações do formulário',
      () {},
    );
  });

  group('Cadastro', () {
    test(
      'deve iniciar o estado de carregamento ao solicitar o cadastro',
      () {},
    );

    test(
      'deve encerrar o estado de carregamento quando o cadastro for concluído com sucesso',
      () {},
    );

    test(
      'deve encerrar o estado de carregamento quando o cadastro falhar',
      () {},
    );

    test(
      'deve chamar o repositório quando todos os campos estiverem válidos',
      () {},
    );

    test(
      'não deve chamar o repositório quando existir erro de validação no formulário',
      () {},
    );

    test('deve sinalizar sucesso quando o cadastro for concluído', () {});

    test('deve enviar os dados preenchidos para o repositorio', () {});
    test(
      'deve limpar mensagem de erro quando cadastro for concluido com sucesso',
      () {},
    );
  });

  group('Tratamento de Erros', () {
    test('deve exibir mensagem quando o e-mail já estiver cadastrado', () {});

    test(
      'deve exibir mensagem quando não houver conexão com a internet',
      () {},
    );

    test('deve exibir mensagem para erro genérico inesperado', () {});

    test(
      'deve remover o estado de carregamento quando ocorrer erro de e-mail já cadastrado',
      () {},
    );

    test(
      'deve remover o estado de carregamento quando ocorrer erro de conexão',
      () {},
    );

    test(
      'deve remover o estado de carregamento quando ocorrer erro genérico',
      () {},
    );
  });
}

void _preencherFormularioValido(
  SignUpViewModel viewModel, {
  String name = 'João',
  String lastName = 'Silva',
  String email = 'test@email.com',
  String password = '12345678',
  String confirmPassword = '12345678',
}) {
  viewModel.name = name;
  viewModel.lastName = lastName;
  viewModel.email = email;
  viewModel.password = password;
  viewModel.confirmPassword = confirmPassword;
}
