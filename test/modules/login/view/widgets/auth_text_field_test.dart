import 'package:dia_a_dia/core/constants/app_keys.dart';
import 'package:dia_a_dia/core/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pumpAuthTextField(
    WidgetTester tester, {
      TextEditingController? controller,
      String label = 'E-mail',
      String hintText = 'Digite seu e-mail',
      IconData? prefixIcon,
      IconData? suffixIcon,
      String? errorText,
      bool obscureText = false,
      bool enabled = true,
      bool isPassword = false,
      TextInputType keyboardType = TextInputType.text,
      VoidCallback? onTap,
      ValueChanged<String>? onChanged,
      VoidCallback? onTogglePasswordVisibility,
    }) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: AuthTextField(
          controller: controller ?? TextEditingController(),
          label: label,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          errorText: errorText,
          obscureText: obscureText,
          enabled: enabled,
          keyboardType: keyboardType,
          isPassword: isPassword,
          onTap: onTap,
          onChanged: onChanged,
          onTogglePasswordVisibility: onTogglePasswordVisibility,
        ),
      ),
    ),
  );
}

void main() {
  //===========================================================================
  // Estrutura
  //===========================================================================

  group('Estrutura', () {
    testWidgets('deve exibir o label informado', (tester) async {
      await _pumpAuthTextField(tester);

      expect(find.text('E-mail'), findsOneWidget);
      expect(find.byKey(AppKeys.authTextFieldLabel), findsOneWidget);
    });

    testWidgets('deve exibir o hintText informado', (tester) async {
      await _pumpAuthTextField(tester);

      expect(find.text('Digite seu e-mail'), findsOneWidget);
    });

    testWidgets('deve exibir o ícone inicial quando informado', (
        tester,
        ) async {
      await _pumpAuthTextField(
        tester,
        prefixIcon: Icons.email_outlined,
      );

      expect(find.byKey(AppKeys.authTextFieldPrefixIcon), findsOneWidget);
      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
    });

    testWidgets('não deve exibir ícone inicial quando não informado', (
        tester,
        ) async {
      await _pumpAuthTextField(tester);

      expect(find.byKey(AppKeys.authTextFieldPrefixIcon), findsNothing);
    });

    testWidgets('deve exibir o campo de texto', (tester) async {
      await _pumpAuthTextField(tester);

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byKey(AppKeys.authTextField), findsOneWidget);
    });
  });

  //===========================================================================
  // Texto
  //===========================================================================

  group('Texto', () {
    testWidgets('deve exibir o valor inicial informado', (tester) async {
      await _pumpAuthTextField(
        tester,
        controller: TextEditingController(
          text: 'teste@email.com',
        ),
      );

      expect(find.text('teste@email.com'), findsOneWidget);
    });

    testWidgets('deve atualizar o texto digitado', (tester) async {
      final controller = TextEditingController();

      await _pumpAuthTextField(
        tester,
        controller: controller,
      );

      await tester.enterText(
        find.byKey(AppKeys.authTextField),
        'novo@email.com',
      );

      expect(controller.text, 'novo@email.com');
    });

    testWidgets('deve chamar onChanged ao alterar o texto', (
        tester,
        ) async {
      String? value;

      await _pumpAuthTextField(
        tester,
        onChanged: (text) => value = text,
      );

      await tester.enterText(
        find.byKey(AppKeys.authTextField),
        'novo@email.com',
      );

      expect(value, 'novo@email.com');
    });
  });

  //===========================================================================
  // Campo de Senha
  //===========================================================================

  group('Campo de Senha', () {


    testWidgets(
      'deve exibir botão para mostrar ou ocultar senha',
          (tester) async {
        await _pumpAuthTextField(
          tester,
          isPassword: true,
        );

        expect(
          find.byKey(AppKeys.authTextFieldPasswordToggle),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'não deve exibir botão de senha quando não for campo de senha',
          (tester) async {
        await _pumpAuthTextField(
          tester,
          isPassword: false,
        );

        expect(
          find.byKey(AppKeys.authTextFieldPasswordToggle),
          findsNothing,
        );
      },
    );

    testWidgets(
      'deve chamar onTogglePasswordVisibility ao pressionar o botão',
          (tester) async {
        var called = false;

        await _pumpAuthTextField(
          tester,
          isPassword: true,
          onTogglePasswordVisibility: () {
            called = true;
          },
        );

        await tester.tap(
          find.byKey(AppKeys.authTextFieldPasswordToggle),
        );

        await tester.pump();

        expect(called, isTrue);
      },
    );
  });

  //===========================================================================
  // Estados
  //===========================================================================

  group('Estados', () {
    testWidgets('deve permanecer habilitado por padrão', (
        tester,
        ) async {
      await _pumpAuthTextField(tester);

      final field = tester.widget<TextFormField>(
        find.byKey(AppKeys.authTextField),
      );

      expect(field.enabled, isTrue);
    });

    testWidgets('deve permanecer desabilitado quando enabled for falso', (
        tester,
        ) async {
      await _pumpAuthTextField(
        tester,
        enabled: false,
      );

      final field = tester.widget<TextFormField>(
        find.byKey(AppKeys.authTextField),
      );

      expect(field.enabled, isFalse);
    });

    testWidgets('não deve permitir edição quando estiver desabilitado', (
        tester,
        ) async {
      final controller = TextEditingController();

      await _pumpAuthTextField(
        tester,
        enabled: false,
        controller: controller,
      );

      await tester.enterText(
        find.byKey(AppKeys.authTextField),
        'teste',
      );

      expect(controller.text, isEmpty);
    });
  });

  //===========================================================================
  // Mensagens de Erro
  //===========================================================================

  group('Mensagens de Erro', () {
    testWidgets(
      'deve exibir mensagem de erro quando errorText for informado',
          (tester) async {
        await _pumpAuthTextField(
          tester,
          errorText: 'Campo obrigatório',
        );

        expect(find.text('Campo obrigatório'), findsOneWidget);
        expect(
          find.byKey(AppKeys.authTextFieldError),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'não deve exibir mensagem de erro quando errorText for nulo',
          (tester) async {
        await _pumpAuthTextField(tester);

        expect(
          find.byKey(AppKeys.authTextFieldError),
          findsNothing,
        );
      },
    );
  });
}