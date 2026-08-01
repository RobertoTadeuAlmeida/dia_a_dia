import 'package:dia_a_dia/modules/login/view/widgets/auth_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pumpAuthCard(
    WidgetTester tester, {
      Widget? child,
    }) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: AuthCard(
          child: child ?? const Text('Conteúdo'),
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
    testWidgets('deve renderizar um Card', (tester) async {
      await _pumpAuthCard(tester);

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('deve renderizar o conteúdo filho', (tester) async {
      await _pumpAuthCard(
        tester,
        child: const Text('Meu Conteúdo'),
      );

      expect(find.text('Meu Conteúdo'), findsOneWidget);
    });

    testWidgets('deve permitir renderizar qualquer Widget como filho', (
        tester,
        ) async {
      await _pumpAuthCard(
        tester,
        child: const Icon(Icons.person),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });
  });

  //===========================================================================
  // Aparência
  //===========================================================================

  group('Aparência', () {
    testWidgets('deve possuir bordas arredondadas', (tester) async {
      await _pumpAuthCard(tester);

      final card = tester.widget<Card>(find.byType(Card));

      final shape = card.shape as RoundedRectangleBorder;

      expect(shape.borderRadius, BorderRadius.circular(24));
    });

    testWidgets('deve possuir elevação', (tester) async {
      await _pumpAuthCard(tester);

      final card = tester.widget<Card>(find.byType(Card));

      expect(card.elevation, greaterThan(0));
    });

    testWidgets('deve possuir Padding interno', (tester) async {
      await _pumpAuthCard(tester);

      expect(find.byType(Padding), findsWidgets);
    });
  });
}