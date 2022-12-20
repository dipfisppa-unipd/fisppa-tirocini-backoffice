import 'package:flutter/material.dart';


class EmptyDataBox extends StatelessWidget {

  final String message;

  const EmptyDataBox(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: Text(message, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
    );
  }
}