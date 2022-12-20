import 'package:flutter/material.dart';


class Logo extends StatelessWidget {

  final double size;

  const Logo({this.size = 250, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/logo.png', height: size, width: size,);
  }
}