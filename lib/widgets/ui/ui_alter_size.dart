import 'package:flutter/material.dart';


class UISizeAlert extends StatelessWidget {
  const UISizeAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.report, color: Colors.red, size: 36,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text('Attenzione, la dimensione dello schermo non consente una corretta visualizzazione dei dati'),
        ),
      ],
    );
  }
}