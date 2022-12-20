
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:misslog/misslog.dart';
import 'package:multiple_result/multiple_result.dart';

import '../models/students/patch/patch_student_direct.dart';
import '../models/students/students_model.dart';
import '../services/api_service.dart';



class StudentsRepo {

  final _api = Get.find<ApiService>();

  /// Ritorna l'elenco degli studenti
  /// 
  Future<StudentsModel?> getStudents({int size=20, int page=1, int yearOfStudy=0, String text=''}) async {

    String endpoint = '/backoffice/users/students?size=$size&page=$page';

    if(yearOfStudy>0 && text.isEmpty) endpoint += '&yearOfStudy=$yearOfStudy';

    if(text.isNotEmpty) endpoint += '&search=$text';

    try {
      
      var data = await _api(endpoint);
      
      if(data!=null){
        
        return StudentsModel.fromMap(data);

      } else {
        MissLog.e("students null");
      }
      
    } catch (e) {
      MissLog.e('Error getStudents: $e', tag: 'StudentsRepo');
    }

    return null;
  }

  /// Ritorna lo studente
  /// 
  Future<Student?> getStudent(String sid) async {

    String endpoint = '/backoffice/users/students/$sid';

    try {
      
      var data = await _api(endpoint);
      
      if(data!=null){
        
        return Student.fromMap(data);

      } else {
        MissLog.e("student null");
      }
      
    } catch (e) {
      MissLog.e('Error getStudent: $e', tag: 'StudentsRepo');
    }

    return null;
  }

  /// PATCH indirect internship
  /// 
  /// [iid] is the indirect internship _id
  /// 
  /// [patch] or [custom] are mandatory
  /// 
  Future<Result<Exception, bool>> patchStudentIndirect(String iid, {Map<String, dynamic>? custom} ) async {

    String endpoint = '/backoffice/internships/indirect';

    if(custom==null){
      return Error(Exception('Errore: dato della modifica assente'));
    }

    try {
      
      var data = await _api(endpoint,
        method: ApiMethod.PATCH,
        params: {
          "id": iid,
          "data": custom
        }
      );
      
      return Success(data!=null && data['_id']!=null); // check if the response has the user id

      
    } catch (e) {
      print(e);
      MissLog.e('Error patchStudentIndirect: $e', tag: 'StudentsRepo');
      return Error(Exception('Errore modifica studente: $e'));
    }
  }

  /// PATCH indirect internship
  /// 
  /// [did] is the direct internship _id
  /// 
  Future<Result<Exception, bool>> patchStudentDirect(String did, PatchStudentDirect patch, {bool keepNullValues=false}) async {

    String endpoint = '/backoffice/internships/direct';

    try {

      var body = patch.toMap();
      if(!keepNullValues)
        body.removeWhere((key, value) => value==null);

      if(kDebugMode) print(body);
      
      var data = await _api(endpoint,
        method: ApiMethod.PATCH,
        params: {
          "id": did,
          "data": body
        }
      );
      
      return Success(data!=null && data['user_id']!=null); // check if the response has the user id

      
    } catch (e) {
      print(e);
      MissLog.e('Error patchStudentDirect: $e', tag: 'StudentsRepo');
      return Error(Exception('Errore modifica studente: $e'));
    }
  }

  /// PUT Edit student info
  /// 
  Future<Result<Exception, bool>> editStudent(String sid, Student student) async {

    if(student.id==null || student.id!.isEmpty){
      return Error(Exception('Errore: studente senza id'));
    }

    String endpoint = '/backoffice/users/students/student';

    try {

      var body = student.toMap();
      body.removeWhere((key, value) => value==null);

      if(kDebugMode) print(body);
      
      var data = await _api(endpoint,
        method: ApiMethod.PATCH,
        params: {
          "id": sid,
          "data": body,
        },
      );
      
      return Success(data!=null && data['_id']!=null); // check if the response has the user id

    } catch (e) {
      print(e);
      MissLog.e('Error patchStudentIndirect: $e', tag: 'StudentsRepo');
      return Error(Exception('Errore modifica studente: $e'));
    }
  }

// end
}