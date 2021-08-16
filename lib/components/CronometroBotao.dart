import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Cronometrobotao extends StatefulWidget {
  final String texto;
  final IconData icone;
  final void Function()? click;

  const Cronometrobotao({
    Key? key,
    required this.texto,
    required this.icone,
    this.click,
  }) : super(key: key);

  @override
  _CronometrobotaoState createState() => _CronometrobotaoState();
}

class _CronometrobotaoState extends State<Cronometrobotao> {
  late final bool? isWebMobile;
  @override
  void initState() {
    isWebMobile = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            textStyle: TextStyle(fontSize: isWebMobile! ? 25 : 15)),
        onPressed: widget.click,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(
                widget.icone,
                size: 35,
              ),
            ),
            Text(widget.texto)
          ],
        ));
  }
}
