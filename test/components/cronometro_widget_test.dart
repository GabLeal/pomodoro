import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro/components/Cronometro.dart';
import 'package:pomodoro/components/EntradaTempo.dart';
import 'package:pomodoro/pages/Pomodoro.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

main() {
  // Função auxiliar para envolver os widgets a serem testados.
  late PomodoroStore something;

  Widget makeTestable(Widget widget) => MultiProvider(
        providers: [Provider<PomodoroStore>(create: (_) => PomodoroStore())],
        child: MaterialApp(
          home: Builder(builder: (context) {
            something = context.watch<PomodoroStore>();
            return widget;
          }),
        ),
      );

  testWidgets('should initialize "parar" button as disabled',
      (WidgetTester tester) async {
    // pumpWidget() renderiza a UI dado um widget.
    await tester.pumpWidget(makeTestable(Cronometro()));

    final Finder iconFinder = find.byIcon(Icons.stop);

    expect(iconFinder, findsNothing);
  });

  testWidgets(
      'should show button "parar" and hide button "iniciar" when iniciar is cliked',
      (WidgetTester tester) async {
    // pumpWidget() renderiza a UI dado um widget.
    await tester.runAsync(() async {
      await tester.pumpWidget(makeTestable(Cronometro()));

      await tester.tap(find.byKey(Key('botaoIniciar')));

      await tester.pumpAndSettle(const Duration(seconds: 4));

      final Finder iconFinderPlay = find.byIcon(Icons.play_arrow);
      final Finder iconFinderStop = find.byIcon(Icons.stop);

      expect(iconFinderPlay, findsNothing);
      expect(iconFinderStop, findsOneWidget);
    });
  });

  testWidgets(
      'should hide stop button and show start button when restart is clicked',
      (WidgetTester tester) async {
    // pumpWidget() renderiza a UI dado um widget.
    await tester.runAsync(() async {
      await tester.pumpWidget(makeTestable(Cronometro()));

      await tester.tap(find.byKey(Key('botaoIniciar')));

      await tester.pumpAndSettle(const Duration(seconds: 4));

      await tester.tap(find.byKey(Key('botaoReiniciar')));

      await tester.pumpAndSettle(const Duration(seconds: 4));

      final Finder iconFinderPlay = find.byIcon(Icons.play_arrow);
      final Finder iconFinderStop = find.byIcon(Icons.stop);

      expect(iconFinderPlay, findsOneWidget);
      expect(iconFinderStop, findsNothing);
    });
  });

  testWidgets(
      'should disable "EntrataTempo trabalho" widget if the "trabalho" interval',
      (WidgetTester tester) async {
    // pumpWidget() renderiza a UI dado um widget.

    await tester.runAsync(() async {
      await tester.pumpWidget(makeTestable(Pomodoro()));

      something.tipoIntervalo = TipoIntervalo.TRABALHO;

      await tester.tap(find.byKey(Key('botaoIniciar')));

      await tester.pumpAndSettle(const Duration(seconds: 4));

      final entradatempoTrabalho =
          tester.widget<EntradaTempo>(find.byKey(Key('EntradaTempoTrabalho')));

      final entradatempoDescanso =
          tester.widget<EntradaTempo>(find.byKey(Key('EntradaTempoDescanso')));

      expect(entradatempoTrabalho.inc, isNull);
      expect(entradatempoTrabalho.dec, isNull);
      expect(entradatempoDescanso.inc, isNotNull);
      expect(entradatempoDescanso.dec, isNotNull);
    });
  });

  testWidgets(
      'should disable "EntrataTempo descanso" widget if the "descanso" interval',
      (WidgetTester tester) async {
    // pumpWidget() renderiza a UI dado um widget.

    await tester.runAsync(() async {
      await tester.pumpWidget(makeTestable(Pomodoro()));

      something.tipoIntervalo = TipoIntervalo.DESCANSO;

      await tester.tap(find.byKey(Key('botaoIniciar')));

      await tester.pumpAndSettle(const Duration(seconds: 4));

      final entradatempoTrabalho =
          tester.widget<EntradaTempo>(find.byKey(Key('EntradaTempoTrabalho')));

      final entradatempoDescanso =
          tester.widget<EntradaTempo>(find.byKey(Key('EntradaTempoDescanso')));

      expect(entradatempoTrabalho.inc, isNotNull);
      expect(entradatempoTrabalho.dec, isNotNull);
      expect(entradatempoDescanso.inc, isNull);
      expect(entradatempoDescanso.dec, isNull);
    });
  });
}
