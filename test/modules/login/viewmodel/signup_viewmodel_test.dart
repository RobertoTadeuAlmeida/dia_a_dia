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

  const name = 'João';
  const lastName = 'Silva';
  const email = 'test@email.com';
  const password = '12345678';
  const confirmPassword = '12345678';

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
        viewModel.name = '';
        viewModel.lastName = lastName;
        viewModel.email = email;
        viewModel.password = password;
        viewModel.confirmPassword = confirmPassword;

        viewModel.validateForm();

        expect(viewModel.nameError, 'Nome obrigatório.');
        expect(viewModel.isFormValid, isFalse);
      },
    );

    test('deve retornar erro quando nome conter apenas espacos', () {
      viewModel.name = '   ';
      viewModel.lastName = lastName;
      viewModel.email = email;
      viewModel.password = password;
      viewModel.confirmPassword = confirmPassword;

      viewModel.validateForm();

      expect(viewModel.nameError, 'Nome obrigatório.');
      expect(viewModel.isFormValid, isFalse);
    });

    test(
      'deve remover espacos das extremidades do nome antes da validacao',
      () {
        viewModel.name = ' João ';
        viewModel.lastName = lastName;
        viewModel.email = email;
        viewModel.password = password;
        viewModel.confirmPassword = confirmPassword;

        viewModel.validateForm();

        expect(viewModel.name, 'João');
        expect(viewModel.isFormValid, isTrue);
        expect(viewModel.nameError, isNull);
      },
    );

    test('deve retornar erro quando nome possuir menos de 2 caracteres', () {
      viewModel.name = 'J';
      viewModel.lastName = lastName;
      viewModel.email = email;
      viewModel.password = password;
      viewModel.confirmPassword = confirmPassword;

      viewModel.validateForm();

      expect(
        viewModel.nameError,
        'O nome deve possuir no mínimo 2 caracteres.',
      );
      expect(viewModel.isFormValid, isFalse);
    });

    test('deve considerar nome valido quando possuir 2 ou mais caracteres', () {
      viewModel.name = 'Jo';
      viewModel.lastName = lastName;
      viewModel.email = email;
      viewModel.password = password;
      viewModel.confirmPassword = confirmPassword;

      viewModel.validateForm();

      expect(viewModel.nameError, isNull);
      expect(viewModel.isFormValid, isTrue);
    });
    test('deve limpar erro de nome quando nome se tornar valido', () {
      viewModel.name = 'J';
      viewModel.lastName = lastName;
      viewModel.email = email;
      viewModel.password = password;
      viewModel.confirmPassword = confirmPassword;

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
    test('deve retornar erro quando sobrenome for vazio', () {});

    test('deve retornar erro quando sobrenome conter apenas espacos', () {});

    test('deve remover espacos antes de validar sobrenome', () {});

    test(
      'deve retornar erro quando sobrenome possuir menos de 2 caracteres',
      () {},
    );

    test(
      'deve considerar sobrenome valido quando possuir 2 ou mais caracteres',
      () {},
    );
    test(
      'deve limpar erro de sobrenome quando sobrenome se tornar valido',
      () {},
    );
  });
  group('E-mail', () {
    test('deve retornar erro quando email for vazio', () {});

    test('deve retornar erro quando email conter apenas espacos', () {});

    test('deve remover espacos antes de validar email', () {});

    test('deve retornar erro quando email possuir formato invalido', () {});

    test('deve considerar email valido quando formato estiver correto', () {});

    test('deve limpar erro de email quando email se tornar valido', () {});
  });

  group('Senha', () {
    test('deve retornar erro quando senha for vazia', () {});

    test(
      'deve retornar erro quando senha possuir menos de 8 caracteres',
      () {},
    );

    test(
      'deve considerar senha valida quando possuir 8 ou mais caracteres',
      () {},
    );

    test('deve limpar erro de senha quando senha se tornar valida', () {});
  });

  group('Confirmação de senha', () {
    test('deve retornar erro quando confirmacao for vazia', () {});

    test(
      'deve considerar confirmacao valida quando senha e confirmacao forem iguais',
      () {},
    );

    test(
      'deve retornar erro quando senha e confirmacao forem diferentes',
      () {},
    );
    test('nao deve validar correspondencia enquanto senha for invalida', () {});

    test(
      'nao deve validar correspondencia enquanto confirmacao for invalida',
      () {},
    );
  });
  group('Botão', () {
    test(
      'deve manter o botão desabilitado quando o formulário estiver vazio',
      () {},
    );

    test(
      //TODO:bool get isFormValid
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

