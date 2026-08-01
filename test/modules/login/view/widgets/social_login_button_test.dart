import 'package:dia_a_dia/modules/login/view/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpSocialLoginButton(
    WidgetTester tester, {
    VoidCallback? onPressed,
    bool isLoading = false,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SocialLoginButton(onPressed: onPressed, isLoading: isLoading),
        ),
      ),
    );
  }

  //===========================================================================
  // Estrutura
  //===========================================================================

  group('Estrutura', () {
    testWidgets('deve exibir o ícone do Google', (tester) async {
      await pumpSocialLoginButton(tester);

      expect(find.byKey(const Key('social_login_google_icon')), findsOneWidget);
    });

    testWidgets('deve exibir o texto "Continuar com Google"', (tester) async {
      await pumpSocialLoginButton(tester);

      expect(find.text('Continuar com Google'), findsOneWidget);
    });
  });

  //===========================================================================
  // Estados
  //===========================================================================

  group('Estados', () {
    testWidgets(
      'deve exibir indicador de carregamento quando estiver em loading',
      (tester) async {
        await pumpSocialLoginButton(tester, isLoading: true);

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets('não deve exibir o texto durante o loading', (tester) async {
      await pumpSocialLoginButton(tester, isLoading: true);

      expect(find.text('Continuar com Google'), findsNothing);
    });

    testWidgets('deve permanecer desabilitado quando onPressed for nulo', (
      tester,
    ) async {
      await pumpSocialLoginButton(tester, onPressed: null);

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

      await pumpSocialLoginButton(
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
