import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ValutazioniController extends GetxController{
  final relazioneCtrl = TextEditingController();
  RxDouble voto = 0.0.obs;

  
  RxBool isSection1Open = false.obs;
  RxBool isSection2Open = false.obs;
  RxBool isSection3Open = false.obs;
  RxBool isSection4Open = false.obs;
}