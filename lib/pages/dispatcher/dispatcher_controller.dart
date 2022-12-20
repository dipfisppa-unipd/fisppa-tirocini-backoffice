import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/auth_controller.dart';


class DispatcherController extends GetxController {

  final context;

  DispatcherController(this.context,);

  @override
  void onInit() {
    checkAuth();
    super.onInit();
  }

  void checkAuth() async {
    await Future.delayed(Duration(seconds: 2));

    var token = await AuthController.to.refreshAccessToken();

    if(token==null){
      GoRouter.of(context).goNamed('login');
    }else{
      AuthController.to.decodeToken(token, context: context);
    }
  }
  
  
}
