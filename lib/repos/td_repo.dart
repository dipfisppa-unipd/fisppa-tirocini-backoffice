import 'package:get/get.dart';
import 'package:misslog/misslog.dart';
import 'package:multiple_result/multiple_result.dart';

import '../models/td/institute_model.dart';
import '../models/td/institute_options.dart';
import '../services/api_service.dart';

/// Tirocinio Indiretto Repository
/// 
class TDRepo {

  final _api = Get.find<ApiService>();

  /// Return the OPTIONS for institutes
  /// 
  Future<Result<Exception, InstituteOptions?>> getInstitutesOptions() async {

    String endpoint = '/backoffice/institutes/options';

    try {
      
      var data = await _api(endpoint);
      
      if(data!=null){
        
        return Success(InstituteOptions.fromMap(data));

      }
      
    } catch (e) {
      Error(e);
      MissLog.e('Error getInstitutesOptions: $e', tag: 'TDRepo');
    }

    return Success(null);
  }

  /// Ritorna tutti gli istituti se [showStudents] false
  /// Altrimenti solo gli instituti con studenti che ne hanno fatto richiesta,
  /// sono assegnati e/o confermati
  /// 
  Future<Result<Exception, InstitutesModel?>> getInstitutes({
    bool showStudents=false, 
    int size=20, int page=1, 
    String schoolType='', 
    String terms='',
    bool confirmedOnly=false, 
    bool assignedOnly=false, 
    bool unassignedOnly=false,
    int? calendarYear,
    }) async {

    String endpoint = showStudents ? '/backoffice/institutes/students?size=$size&page=$page' 
                                   : '/backoffice/institutes?size=$size&page=$page';

    if(schoolType.isNotEmpty)
      endpoint += '&educationDegree=$schoolType';

    if(terms.isNotEmpty)
      endpoint += '&text=$terms';

    if(unassignedOnly)
      endpoint += '&unAssignedOnly=$unassignedOnly';
    
    if(assignedOnly)
      endpoint += '&assignedOnly=$assignedOnly';

    if(confirmedOnly)
      endpoint += '&confirmedOnly=$confirmedOnly';
    
    if(showStudents && calendarYear!=null)
      endpoint += '&internshipCalendarYear=$calendarYear';
    

    try {
      
      var data = await _api(endpoint);
      
      if(data!=null){
        
        return Success(InstitutesModel.fromMap(data));

      }
      
    } catch (e) {
      print(e);
      return Error(Exception('Si è verificato un errore: $e'));
    }

    return Success(null);
  }

  /// Ritorna l'utente/studente loggato
  /// 
  Future<Result<Exception, Institute?>> getInstitute(String iid) async {

    String endpoint = '/backoffice/institutes/$iid';

    try {
      
      var data = await _api(endpoint);
      
      if(data!=null){
        
        return Success(Institute.fromMap(data));

      } else {
        
        MissLog.e("data null");
      }
      
    } catch (e) {
      Error('$e');
      MissLog.e('Error getInstitute: $e', tag: 'TDRepo');
    }

    return Success(null);
  }

  /// Ritorna l'utente/studente loggato
  /// 
  Future<Result<Exception, Institute?>> postInstitute(Institute institute) async {

    String endpoint = '/backoffice/institutes/institute';

    try {

      var body = institute.toMap();
      body.removeWhere((key, value) => value==null || value=='');
      if(body.length==0) 
        return Error(Exception('Nessun dato da salvare'));
      
      var data = await _api(endpoint, 
        method: ApiMethod.POST,
        params: body
      );
      
      if(data!=null){
        
        return Success(Institute.fromMap(data));

      }
      
    } catch (e) {
      
      print(e);
      MissLog.e('Error postInstitute: $e', tag: 'TDRepo');
      return Error(Exception(e));
    }

    return Success(null);
  }

  /// Ritorna l'utente/studente loggato
  /// 
  Future<Result<Exception, bool>> patchInstitute(String code, Map<String, dynamic> patch) async {

    if(code.isEmpty){
      return Error(Exception('Codice meccanografico mancante'));
    }

    String endpoint = '/backoffice/institutes/institute';

    patch.removeWhere((key, value) => value==null || value=='');
    if(patch.length==0) 
      return Error(Exception('Nessun dato da salvare'));
    
    try {
      
      var data = await _api(endpoint, 
        method: ApiMethod.PATCH,
        params: {
          "code": code,
          "data": patch
        }
      );
      
      if(data!=null){
        
        return Success(true);

      }
      
    } catch (e) {
      
      print(e);
      MissLog.e('Error postInstitute: $e', tag: 'TDRepo');
      return Error(Exception(e));
    }

    return Success(false);
  }

// end
}