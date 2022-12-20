import 'package:get/get.dart';
import 'package:misslog/misslog.dart';

import '../models/ti/group_model.dart';
import '../models/ti/territoriality_model.dart';
import '../services/api_service.dart';

/// Tirocinio Indiretto Repository
/// 
class TIRepo {

  final _api = Get.find<ApiService>();

  /// Ritorna l'utente/studente loggato
  /// 
  Future<List<GroupModel>> getGroups({int internshipYear=0}) async {

    List<GroupModel> groups = [];

    String endpoint = '/territorialities/groups';

    if(internshipYear>0) endpoint += '?internshipYear=$internshipYear';

    try {
      
      var data = await _api(endpoint);
      
      if(data!=null){
        
        for(var d in data)
        groups.add(GroupModel.fromMap(d));

      } else {
        MissLog.e("data null");
      }
      
    } catch (e) {
      MissLog.e('Error getGroups: $e', tag: 'TIRepo');
    }

    return groups;
  }

  Future<List<TerritorialityModel>> getTerritorialities() async {

    List<TerritorialityModel> res = [];

    String endpoint = '/territorialities';

    try {
      
      var data = await _api(endpoint);
      
      if(data!=null){
        
        for(var d in data)
        res.add(TerritorialityModel.fromMap(d));

      } else {
        MissLog.e("data null");
      }
      
    } catch (e) {
      MissLog.e('Error getTerritorialities: $e', tag: 'TIRepo');
    }

    return res;
  }

  Future<String?> createGroup(GroupModel group) async {

    try {
      
      var res = await _api('/backoffice/territorialities/groups/group', 
        method: ApiMethod.POST,
        params: group.toMap()
      );
      
      return res!=null ? res['_id'] : null;
      
    } catch (e) {
      print(e);
      MissLog.e('Error createGroup: $e', tag: 'TIRepo');
    }

    return null;

  }

  Future<String?> patchGroup(String gid, dynamic body) async {

    try {
      print({
          "id": gid,
          "data": body
        }.toString());
      
      var res = await _api('/backoffice/territorialities/groups/group', 
        method: ApiMethod.PATCH,
        params: {
          "id": gid,
          "data": body
        }
      );
      
      return res!=null ? res['_id'] : null;
      
    } catch (e) {
      MissLog.e('Error patchGroup: $e', tag: 'TIRepo');
    }

    return null;

  }

  Future<GroupModel?> getGroupDetails({required String gid, int internshipYear=0}) async {


    String endpoint = '/backoffice/territorialities/groups/$gid';

    if(internshipYear>0) endpoint += '?internshipYear=$internshipYear';

    try {
      
      var data = await _api(endpoint);
      
      if(data!=null){
        
        return GroupModel.fromMap(data);

      } else {
        MissLog.e("data null");
      }
      
    } catch (e) {
      MissLog.e('Error getGroups: $e', tag: 'TIRepo');
    }

    return null;
  }
}