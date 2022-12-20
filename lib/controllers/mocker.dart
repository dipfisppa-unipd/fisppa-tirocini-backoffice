import 'dart:math';

import 'package:get/get.dart';


class Mocker extends GetxController {

  static Mocker get to => Get.find();
  Random random = Random();

  final gruppi = [
    'Padova centro',
    'Padova provincia',
    'Venezia',
    'Treviso',
    'Vicenza',
    'TOL'
  ];

  final istituti = [
    'E. De Amicis',
    'Guglielmo Marconi',
    'Istituto Leopardi',
    'Salvo D\'Acquisto',
    'Zanella',
    'Tommaseo',
    'Istituto Donatello',
    'Istituto Ferrari',
    'Don Bosco'
  ];

  String randomGruppo(){
    Random random = Random();
    int r = random.nextInt(gruppi.length);
    return gruppi[r];
  } 

  String randomIstituto(){
    
    int r = random.nextInt(istituti.length);
    return istituti[r];
  } 
}