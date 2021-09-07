import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro/store/pomodoro.store.dart';

main() {
  group('Store Pomodoro teste', () {
    late PomodoroStore store;

    setUp(() {
      store = PomodoroStore();
    });

    test('should check pomodoro "iniciado" is FALSE', () {
      expect(store.iniciado, false);
    });

    test('should check pomodoro "cronometro" is null', () {
      expect(store.cronometro, isNull);
    });

    test('should initialize pomodoro', () {
      store.iniciar();

      expect(store.iniciado, true);
      expect(store.cronometro, isNotNull);
    });

    test('should stop pomodoro', () {
      store.iniciar();
      store.parar();
      expect(store.iniciado, false);
    });

    test('should refresh pomodoro', () {
      store.iniciar();
      store.reiniciar();

      expect(store.iniciado, false);
      expect(store.minuto, 0);
    });

    test('should increment work hours pomodoro', () {
      store.tempoTrabalho = 1;

      store.incrementarTempoTrabalho();
      expect(store.tempoTrabalho, 2);
    });

    test('should decrement work hours pomodoro', () {
      store.tempoTrabalho = 0;

      store.decrementarTempoTrabalho();
      expect(store.tempoTrabalho, 0);
    });

    test('should increment rest hours pomodoro', () {
      store.iniciar();
      store.tempoDescanso = 1;

      store.incrementarTempoDescanso();
      store.incrementarTempoDescanso();
      store.incrementarTempoDescanso();
      expect(store.tempoDescanso, 4);
    });

    test('should decrement rest hours pomodoro', () {
      store.iniciar();
      store.tempoDescanso = 0;

      store.decrementarTempoDescanso();
      expect(store.tempoDescanso, 0);
    });
  });
}
