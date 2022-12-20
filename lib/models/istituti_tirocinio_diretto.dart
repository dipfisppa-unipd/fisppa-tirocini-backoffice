// import 'package:equatable/equatable.dart';

// /// [infanzia] valorizzato solo se [isInfanzia] è false
// class Istituto extends Equatable{
//   final int id;
//   final String nome;
//   final String indirizzo;
//   final bool isInfanzia;
//   final bool isPrimaria;
//   final double latitudine;
//   final double longitudine;

//   const Istituto({required this.latitudine, required this.longitudine, required this.id, required this.nome, required this.indirizzo, this.isInfanzia = true, this.isPrimaria = true});

//   @override
//   // TODO: implement props
//   List<Object?> get props => [id, nome];

// }


// class SceltaTirocinioDiretto extends Equatable{
//   Istituto istituto1;
//   Istituto? istituto2;

//   SceltaTirocinioDiretto({required this.istituto1, this.istituto2});

//   bool get isComplete => (istituto1.isInfanzia || (istituto2 != null && istituto2!.isInfanzia));


//   @override
//   // TODO: implement props
//   List<Object?> get props => [istituto1, istituto2];
// }