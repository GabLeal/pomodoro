import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro/store/pomodoro.store.dart';

main() {
  group('Store Pomodoro teste', () {
    PomodoroStore store = PomodoroStore();

    test('check pomodoro "iniciado" is FALSE', () {
      expect(store.iniciado, false);
    });

    test('check pomodoro "cronometro" is null', () {
      expect(store.cronometro, isNull);
    });

    test('Initializar pomodoro', () {
      store.iniciar();

      expect(store.iniciado, true);
      expect(store.cronometro, isNotNull);
    });

    test('Stop pomodoro', () {
      store.iniciar();
      store.parar();
      expect(store.iniciado, false);
    });

    test('Refresh pomodoro', () {
      store.reiniciar();

      expect(store.iniciado, false);
      expect(store.minuto, 0);
    });

    test('Increment work hours pomodoro', () {
      store.tempoTrabalho = 1;

      store.incrementarTempoTrabalho();
      expect(store.tempoTrabalho, 2);
    });

    test('Decrement work hours pomodoro', () {
      store.tempoTrabalho = 0;

      store.decrementarTempoTrabalho();
      expect(store.tempoTrabalho, 0);
    });

    test('Increment rest hours pomodoro', () {
      store.tempoDescanso = 1;

      store.incrementarTempoDescanso();
      store.incrementarTempoDescanso();
      store.incrementarTempoDescanso();
      expect(store.tempoDescanso, 4);
    });

    test('Decrement rest hours pomodoro', () {
      store.tempoDescanso = 0;

      store.decrementarTempoDescanso();
      expect(store.tempoTrabalho, 0);
    });
  });
}
