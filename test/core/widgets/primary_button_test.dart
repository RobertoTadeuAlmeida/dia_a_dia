import 'package:dia_a_dia/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpPrimaryButton(
    WidgetTester tester, {
    VoidCallback? onPressed,
    bool isLoading = false,
    String text = 'Entrar',
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            text: text,
            onPressed: onPressed,
            isLoading: isLoading,
          ),
        ),
      ),
    );
  }

  //===========================================================================
  // Estrutura
  //===========================================================================

  group('Estrutura', () {
    testWidgets('deve exibir o texto informado', (tester) async {
      await pumpPrimaryButton(tester, text: 'Entrar');

      expect(find.text('Entrar'), findsOneWidget);
    });

    testWidgets('deve renderizar um ElevatedButton', (tester) async {
      await pumpPrimaryButton(tester);

      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  //===========================================================================
  // Estados
  //===========================================================================

  group('Estados', () {
    testWidgets(
      'deve exibir indicador de carregamento quando estiver em loading',
      (tester) async {
        await pumpPrimaryButton(tester, isLoading: true);

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets('não deve exibir o texto durante o loading', (tester) async {
      await pumpPrimaryButton(tester, isLoading: true);

      expect(find.text('Entrar'), findsNothing);
    });

    testWidgets('deve permanecer desabilitado quando onPressed for nulo', (
      tester,
    ) async {
      await pumpPrimaryButton(tester, onPressed: null);

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));

      expect(button.onPressed, isNull);
    });
  });

  //===========================================================================
  // Interações
  //===========================================================================

  group('Interações', () {
    testWidgets('deve executar onPressed ao ser pressionado', (tester) async {
      var called = false;

      await pumpPrimaryButton(
        tester,
        onPressed: () {
          called = true;
        },
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(called, isTrue);
    });
  });
}
