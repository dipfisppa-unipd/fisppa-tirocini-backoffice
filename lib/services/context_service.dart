import 'package:flutter/material.dart';



abstract class GetContext {

  static GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  static BuildContext? get find  => key.currentContext;

  
}