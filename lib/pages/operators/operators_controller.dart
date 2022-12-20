import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:unipd_tirocini/models/operators/operators_model.dart';
import 'package:unipd_tirocini/models/user.dart';

import '../../repos/admin_repo.dart';

class OperatorsController extends GetxController with StateMixin<OperatorsModel>{

  final _repo = AdminRepo();
  UserType userTypeFilter = UserType.organizerTutor;

  @override
  void onInit() {
    _getOperatos(userTypeFilter);
    super.onInit();
  }

  void reload() => _getOperatos(userTypeFilter);

  void _getOperatos(UserType userType) async {
    var res = await _repo.getOperators(userTypeFilter);

    if(res.isSuccess()){
      var data = res.getSuccess();
      if(data==null || data.total==0)
        change(null, status: RxStatus.empty());
      else{
        if(data.total>0)
          data.users!.sort((a, b) 
            => a.fullname.compareTo(b.fullname));
        change(data, status: RxStatus.success());       
      }
        
    }else{
      change(null, status: RxStatus.error(res.getError().toString()));
    }
  }

  void onFilterChanged(UserType role) {
    change(null, status: RxStatus.loading());   
    userTypeFilter = role;
    _getOperatos(role);
  }
}