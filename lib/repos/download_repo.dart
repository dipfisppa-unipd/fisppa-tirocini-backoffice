
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:misslog/misslog.dart';

import '../services/api_service.dart';


class DownloadRepo {

  final _api = Get.find<ApiService>();

  /// Ritorna l'elenco degli studenti
  /// 
  Future<Uint8List?> exportAll() async {

    String endpoint = '/backoffice/users/internships/export?asXls=true';

    try {
      
      var data = await _api(endpoint,);
      
      if(data!=null){
        return _convertStringToUint8List(data);

      } else {
        MissLog.e("students null");
      }
      
    } catch (e) {
      MissLog.e('Error getStudents: $e', tag: 'StudentsRepo');
    }

    return null;
  }

  Uint8List _convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }

}