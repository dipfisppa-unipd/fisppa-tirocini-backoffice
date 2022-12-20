import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class ErrorScreen extends StatelessWidget {

  final GoRouterState? errorState;
  
  const ErrorScreen({ Key? key, this.errorState }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Ooops... 404!'),
      ),
    );
  }
}