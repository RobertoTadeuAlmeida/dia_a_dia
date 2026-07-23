import 'package:dia_a_dia/modules/login/view/widgets/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pumpAuthHeader(WidgetTester tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: Scaffold(
        body: AuthHeader(),
      ),
    ),
  );
}

void main() {
  //===========================================================================
  // Estrutura Inicial
  //===========================================================================

  group('Estrutura Inicial', () {
    testWidgets(
      'deve exibir a logo do aplicativo',
          (tester) async {
        await _pumpAuthHeader(tester);

        expect(find.byKey(const Key('auth_logo')), findsOneWidget);
      },
    );

    testWidgets(
      'deve exibir o título do aplicativo',
          (tester) async {
        await _pumpAuthHeader(tester);

        expect(find.text('Dia A Dia'), findsOneWidget);
      },
    );

    testWidgets(
      'deve exibir o subtítulo do aplicativo',
          (tester) async {
        await _pumpAuthHeader(tester);

        expect(find.text('Seu dia mais organizado'), findsOneWidget);
      },
    );
  });

  //===========================================================================
  // Layout
  //===========================================================================

  group('Layout', () {
    testWidgets(
      'deve organizar os elementos em uma Column',
          (tester) async {
        await _pumpAuthHeader(tester);

        expect(find.byType(Column), findsOneWidget);
      },
    );

    testWidgets(
      'deve centralizar o conteúdo',
          (tester) async {
        await _pumpAuthHeader(tester);

        final column = tester.widget<Column>(find.byType(Column));

        expect(column.crossAxisAlignment, CrossAxisAlignment.center);
      },
    );
  });

  //===========================================================================
  // Renderização
  //===========================================================================

  group('Renderização', () {
    testWidgets(
      'deve renderizar sem lançar exceções',
          (tester) async {
        await _pumpAuthHeader(tester);

        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'deve ocupar apenas o espaço necessário',
          (tester) async {
        await _pumpAuthHeader(tester);

        expect(find.byType(AuthHeader), findsOneWidget);
      },
    );
  });
}