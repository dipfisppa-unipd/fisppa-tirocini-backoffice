import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Patcher extends Equatable{

  final id;

  Patcher({this.id});

  Map<String, dynamic> _body = {};

  Map<String, dynamic> get body => _body;

  void add(String key, dynamic value){
    _body.update(key, (v) => value, ifAbsent: ()=>value);
  }
  
  @override
  List<Object?> get props => [id, _body]; 

}