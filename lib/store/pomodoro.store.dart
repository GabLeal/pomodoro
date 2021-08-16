import 'dart:async';

import 'package:mobx/mobx.dart';
part 'pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum TipoIntervalo { DESCANSO, TRABALHO }

abstract class _PomodoroStore with Store {
  @observable
  bool iniciado = false;

  @observable
  int hora = 0;

  @observable
  int minuto = 0;

  @observable
  int tempoTrabalho = 2;

  @observable
  int tempoDescanso = 1;

  @observable
  TipoIntervalo tipoIntervalo = TipoIntervalo.TRABALHO;

  Timer? cronometro;

  bool _terminouContagemRegressiva() {
    return hora == 0 && minuto == 0;
  }

  void _contagemRegressiva() {
    if (minuto == 0) {
      minuto = 59;
      hora--;
    } else {
      minuto--;
    }
  }

  @action
  void iniciar() {
    iniciado = true;
    cronometro = Timer.periodic(Duration(microseconds: 50), (timer) {
      if (_terminouContagemRegressiva()) {
        _trocarTipoIntervalo();
      } else {
        _contagemRegressiva();
      }
    });
  }

  @action
  void parar() {
    iniciado = false;
    cronometro!.cancel();
  }

  @action
  void reiniciar() {
    parar();
    hora = estaTrabalhando() ? tempoTrabalho : tempoDescanso;
    minuto = 0;
  }

  @action
  void incrementarTempoTrabalho() {
    tempoTrabalho++;
    if (estaTrabalhando()) {
      reiniciar();
    }
  }

  @action
  void decrementarTempoTrabalho() {
    if (tempoTrabalho > 1) tempoTrabalho--;
    if (estaTrabalhando()) {
      reiniciar();
    }
  }

  @action
  void incrementarTempoDescanso() {
    tempoDescanso++;
    if (estaDescansando()) {
      reiniciar();
    }
  }

  @action
  void decrementarTempoDescanso() {
    if (tempoDescanso > 1) tempoDescanso--;
    if (estaDescansando()) {
      reiniciar();
    }
  }

  bool estaTrabalhando() {
    return tipoIntervalo == TipoIntervalo.TRABALHO;
  }

  bool estaDescansando() {
    return tipoIntervalo == TipoIntervalo.DESCANSO;
  }

  void _trocarTipoIntervalo() {
    if (estaTrabalhando()) {
      tipoIntervalo = TipoIntervalo.DESCANSO;
      hora = tempoDescanso;
    } else {
      tipoIntervalo = TipoIntervalo.TRABALHO;
      hora = tempoTrabalho;
    }

    minuto = 0;
  }
}