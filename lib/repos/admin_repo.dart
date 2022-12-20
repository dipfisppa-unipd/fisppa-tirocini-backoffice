import 'package:get/get.dart';
import 'package:misslog/misslog.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:unipd_tirocini/models/operators/operators_model.dart';
import 'package:unipd_tirocini/models/user.dart';

import '../services/api_service.dart';

class AdminRepo {

  final _api = Get.find<ApiService>();

  /// Return the OPTIONS for institutes
  /// 
  Future<Result<Exception, OperatorsModel?>> getOperators(UserType userType) async {

    String endpoint = '/backoffice/users?userType=${userType.index}';

    try {
      
      var data = await _api(endpoint);
      
      if(data!=null){
        
        return Success(OperatorsModel.fromMap(data));

      }
      
    } catch (e) {
      print(e);
      MissLog.e('Error getOperators: $e', tag: 'AdminRepo');
      return Error(Exception('$e'));
    }

    return Success(null);
  }

  Future<Result<Exception, bool>> createOperator(Map body) async {

    String endpoint = '/backoffice/users/user';

    try {
      
      var data = await _api(endpoint, 
        method: ApiMethod.POST,
        params: body,
      );
      
      if(data!=null){
        return Success(data['email']!=null);
      }
      
    } catch (e) {
      MissLog.e('Error createOperator: $e', tag: 'AdminRepo');
      return Error(Exception('$e'));
    }

    return Success(false);
  }

}