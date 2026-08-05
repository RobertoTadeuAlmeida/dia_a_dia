import 'package:dia_a_dia/core/constants/app_keys.dart';
import 'package:dia_a_dia/core/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pumpErrorMessage(WidgetTester tester, {String? message}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(body: ErrorMessage(message: message)),
    ),
  );
}

void main() {
  //===========================================================================
  // Estrutura
  //===========================================================================

  group('Estrutura', () {
    testWidgets('deve exibir a mensagem informada', (tester) async {
      await _pumpErrorMessage(tester, message: 'E-mail inválido.');

      expect(find.text('E-mail inválido.'), findsOneWidget);
      expect(find.byKey(AppKeys.errorMessageText), findsOneWidget);
    });

    testWidgets('deve exibir o ícone de erro', (tester) async {
      await _pumpErrorMessage(tester, message: 'Erro.');

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.byKey(AppKeys.errorMessageIcon), findsOneWidget);
    });

    testWidgets('deve renderizar o container da mensagem', (tester) async {
      await _pumpErrorMessage(tester, message: 'Erro.');

      expect(find.byKey(AppKeys.errorMessage), findsOneWidget);
    });
  });

  //===========================================================================
  // Estados
  //===========================================================================

  group('Estados', () {
    testWidgets('deve renderizar quando a mensagem for informada', (
      tester,
    ) async {
      await _pumpErrorMessage(tester, message: 'Erro.');

      expect(find.byType(ErrorMessage), findsOneWidget);
    });

    testWidgets('não deve renderizar quando a mensagem for nula', (
      tester,
    ) async {
      await _pumpErrorMessage(tester, message: null);

      expect(find.byType(ErrorMessage), findsNothing);
    });

    testWidgets('não deve renderizar quando a mensagem estiver vazia', (
      tester,
    ) async {
      await _pumpErrorMessage(tester, message: '');

      expect(find.byType(ErrorMessage), findsNothing);
    });
  });

  //===========================================================================
  // Conteúdo
  //===========================================================================

  group('Conteúdo', () {
    testWidgets('deve atualizar o texto quando a mensagem mudar', (
      tester,
    ) async {
      await _pumpErrorMessage(tester, message: 'Erro 1');

      expect(find.text('Erro 1'), findsOneWidget);

      await _pumpErrorMessage(tester, message: 'Erro 2');

      expect(find.text('Erro 2'), findsOneWidget);
    });
  });
}
