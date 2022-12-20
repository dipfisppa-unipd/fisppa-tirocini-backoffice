import 'package:get/get.dart';


class CustomDrawerController extends GetxController {

  static CustomDrawerController get to => Get.find();

  final isDrawerOpen = true.obs;
  final index = 0.obs;


}