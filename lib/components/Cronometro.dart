import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/CronometroBotao.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class Cronometro extends StatelessWidget {
  const Cronometro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Observer(builder: (_) {
      return Container(
        color: store.estaTrabalhando() ? Colors.red : Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              store.estaTrabalhando()
                  ? 'Hora de Trabalhar'
                  : 'Hora de Descansar',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '${store.hora.toString().padLeft(2, '0')}:${store.minuto.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 120, color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!store.iniciado)
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Cronometrobotao(
                        key: Key("botaoIniciar"),
                        texto: 'Iniciar',
                        icone: Icons.play_arrow,
                        click: store.iniciar,
                      ),
                    ),
                  if (store.iniciado)
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Cronometrobotao(
                          texto: 'Parar',
                          icone: Icons.stop,
                          click: store.parar),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Cronometrobotao(
                        texto: 'Reiniciar',
                        icone: Icons.refresh,
                        click: store.reiniciar),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
