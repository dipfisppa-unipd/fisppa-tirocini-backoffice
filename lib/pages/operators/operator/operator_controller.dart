import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/models/user.dart';
import 'package:unipd_tirocini/pages/operators/operators_controller.dart';

import '../../../repos/admin_repo.dart';
import '../../../utils/utils.dart';


class OperatorController extends GetxController {

  final _repo = AdminRepo();
  final emailCtrl = TextEditingController();

  bool isAdmin = false;
  UserType userType = UserType.organizerTutor;

  void onRoleChanged(UserType ut){
    userType = ut;
    if(userType==UserType.superadmin){
      isAdmin = true;
    }else{
      isAdmin = false;
    }
    update();
  }

  void onAdminChanged(context, bool v){
    if(!v && userType==UserType.superadmin){
      Utils.showToast(context: context, isWarning: true, text: 'Non disattivabile per il ruolo Admin');
    }
    isAdmin = v;
    update();
  }

  Future<void> saveOperator(context) async {

    if(emailCtrl.text.isEmpty || !emailCtrl.text.isEmail){
      Utils.showToast(context: context, isWarning: true, text: 'Inserire una email valida');
      return;
    }

    if(!emailCtrl.text.endsWith('@unipd.it')){
      Utils.showToast(context: context, isWarning: true, text: 'Utilizzare solo email @unipd.it');
      return;
    }

    var body = {
      "email": emailCtrl.text.toLowerCase(),
      "isAdmin": isAdmin,
      "userType": userType.index,
    };

    var res = await _repo.createOperator(body);

    res.when(
      (error) => Utils.showToast(context: context, isError: true, text: 'Errore: $error'), 
      (success) {
        Utils.showToast(context: context, text: 'Operatore creato');
        Get.find<OperatorsController>().reload();
      }
    );
  }

  // endgame
  @override
  void onClose() {
    emailCtrl.dispose();
    super.onClose();
  }
}