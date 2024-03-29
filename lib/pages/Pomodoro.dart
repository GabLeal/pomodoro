import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/Cronometro.dart';
import 'package:pomodoro/components/EntradaTempo.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Cronometro()),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Observer(builder: (_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    EntradaTempo(
                      key: Key('EntradaTempoTrabalho'),
                      titulo: 'Trabalho',
                      valor: store.tempoTrabalho,
                      inc: store.bloquearBotoesTempoTrabalho
                          ? null
                          : store.incrementarTempoTrabalho,
                      dec: store.iniciado && store.estaTrabalhando()
                          ? null
                          : store.decrementarTempoTrabalho,
                    ),
                    EntradaTempo(
                      key: Key('EntradaTempoDescanso'),
                      titulo: 'Descanso',
                      valor: store.tempoDescanso,
                      inc: store.bloquearBotoesTempoDescanso
                          ? null
                          : store.incrementarTempoDescanso,
                      dec: store.iniciado && store.estaDescansando()
                          ? null
                          : store.decrementarTempoDescanso,
                    )
                  ],
                );
              }))
        ],
      ),
    );
  }
}
