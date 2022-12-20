import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:unipd_tirocini/models/td/direct_model.dart';
import 'package:unipd_tirocini/models/td/institute_model.dart';
import 'package:unipd_tirocini/repos/td_repo.dart';
import 'package:unipd_tirocini/utils/utils.dart';

import '../../../../models/students/patch/patch_student_direct.dart';
import '../../../../repos/students_repo.dart';


class InstituteController extends GetxController{

  final String? iid;

  static InstituteController get to => Get.find();

  InstituteController({this.iid});

  final _repo = TDRepo();
  final _studentsRepo = StudentsRepo(); // used to assign students to institute
  Institute? institute;
  bool isLoading = true;
  bool isReadOnly = true;
  bool showStudentsList = true;

  final nameCtrl = TextEditingController();
  final codeCtrl = TextEditingController();
  final referenceCodeCtrl = TextEditingController();
  final ivaCtrl = TextEditingController();
  final ibanCtrl = TextEditingController();

  String region='', schoolType='', educationDegree='';
  String province='', geoZone='';

  final addressCtrl = TextEditingController();
  final capCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final stateCtrl = TextEditingController();

  final phoneCtrl = TextEditingController();
  final faxCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final pecCtrl = TextEditingController();
  final siteCtrl = TextEditingController();

  final conventionExpireCtrl = TextEditingController();
  final conventionStartCtrl = TextEditingController();
  DateTime? _conventionExpireDate;
  DateTime? _conventionStartDate;

  Map<int, List<DirectInternship>> groupedInternships = {};

  bool get isNewInstitute => iid==null;
  bool get hasInternships => !isNewInstitute && institute!.directInternships.isNotEmpty;

  @override
  void onInit() {
    _getInstitute();
    
    showStudentsList = !isNewInstitute;
    isReadOnly = !isNewInstitute;
    super.onInit();
  }

  void reload() => _getInstitute();

  void _getInstitute() async {

    groupedInternships.clear();

    if(isNewInstitute) {
      isLoading = false;
      institute = Institute();
      update();
      return;
    }
    
    var result = await _repo.getInstitute(iid!);

    if(result.isSuccess()) 
      institute = result.getSuccess();

    if(institute!=null){
      nameCtrl.text = institute!.name;
      codeCtrl.text = institute!.code;
      referenceCodeCtrl.text = institute!.referenceInstituteCode;

      region = institute!.region; 
      schoolType = institute!.schoolType; 
      educationDegree = institute!.educationDegree;

      ivaCtrl.text  = institute!.vatNumber;
      ibanCtrl.text = institute!.iban;

      addressCtrl.text = institute!.address;
      capCtrl.text = institute!.cap;
      cityCtrl.text = institute!.city;
      province = institute!.province;
      stateCtrl.text = institute!.state;
      geoZone = institute!.geographicArea;

      phoneCtrl.text = institute!.phoneNumber;
      faxCtrl.text = institute!.fax;
      emailCtrl.text = institute!.email ?? '';
      pecCtrl.text = institute!.pec ?? '';
      siteCtrl.text = institute!.website;

      conventionExpireCtrl.text = institute!.conventionEnds();
      conventionStartCtrl.text = institute!.conventionStarts();

      _conventionExpireDate = institute!.convention?.endDate;
      _conventionStartDate = institute!.convention?.startDate;

      if(institute!.directInternships.isNotEmpty){
        institute!.directInternships.sort(((a, b) => a.calendarYear!>b.calendarYear! ? 0:1));

        institute!.directInternships.forEach((element) { 

          groupedInternships.update(element.calendarYear!, (value) {
            value.add(element);
            return value;
          } , ifAbsent: () => [element]);

          // if(groupedInternships.containsKey(element.calendarYear)){
          //   groupedInternships[element.calendarYear]!.add(element);
          // }else{
          //   groupedInternships[element.calendarYear!] = [];
          //   groupedInternships[element.calendarYear]!.add(element);
          // }

        });
        
      }

      // ordina per scelta
      groupedInternships.forEach((key, value) { 
        groupedInternships[key]!.sort((a, b) => a.enhancedUser!.fullname.compareTo(b.enhancedUser!.fullname),);
      });
        

    }
    
    isLoading = false;
    update();
  }

  void toggleShowStudentList(){
    showStudentsList = !showStudentsList;
    update();
  }

  void toggleReadOnly(bool v){
    isReadOnly = !isReadOnly;
    update();
  }

  void setRegion(String? s){
    region = s ?? '';
    institute!.patcher.add('region', s);
                          
    update();
  }

  void setProvince(String? s){
    province = s ?? '';
    institute!.patcher.add('province', s);
                          
    update();
  }

  void setGeoZone(String? s){
    geoZone = s ?? '';
    institute!.patcher.add('geographicArea', s);
    update();
  }

  void setSchoolType(String? s){
    schoolType = s ?? '';
    institute!.patcher.add('schoolType', s);
    update();
  }

  void setEducationDegree(String? s){
    educationDegree = s ?? '';
    institute!.patcher.add('educationDegree', s);
    update();
  }

  void pickDate(context,{ bool isEnd=false}) async {
    var res = await Utils.pickDate(context, full: true);

    if(res!=null && isEnd){
      _conventionExpireDate = res;
      conventionExpireCtrl.text = Utils.formatDatePdf(res);
      
    }else if(res!=null && !isEnd){
      _conventionStartDate = res;
      conventionStartCtrl.text = Utils.formatDatePdf(res);
    }

    if(res!=null){
      institute!.patcher.add('convention', {
        "startDate": _conventionStartDate?.toIso8601String(),
        "endDate": _conventionExpireDate?.toIso8601String(),
      });
    }
  }

  Future<void> saveInstitute(context) => isNewInstitute ? _create(context) : _save(context);

  Future<void> _save(context) async {
    if(institute==null){
      Utils.showToast(context: context, isWarning: true, text: 'Impossibile salvare l\'istituto');
      return;
    }

    
    if(institute!.patcher.body.length==0){
      Utils.showToast(context: context, isWarning: true, text: 'Nessuna modifica da salvare');
      return;
    }

    var res = await _repo.patchInstitute(iid!, institute!.patcher.body);

    res.when(
      (error) => Utils.showToast(isError: true, context: context, text: 'Si è verificato un errore'), 
      (success) {
        Utils.showToast(context: context, text: 'Salvataggio effettuato');
        _getInstitute();
      }
    );

  }

  Future<void> _create(BuildContext context) async {
    if(nameCtrl.text.isEmpty){
      Utils.showToast(context: context, isWarning: true, text: 'Nome obbligatorio');
      return;
    }

    if(codeCtrl.text.isEmpty || referenceCodeCtrl.text.isEmpty){
      Utils.showToast(context: context, isWarning: true, text: 'Codici meccanografico obbligatori');
      return;
    }

    if((_conventionStartDate==null && _conventionExpireDate!=null) || (_conventionStartDate!=null && _conventionExpireDate==null)){
      Utils.showToast(context: context, isWarning: true, text: 'Indicare entrambe le date della convenzione o nessuna');
      return;
    }

    if(cityCtrl.text.isEmpty){
      Utils.showToast(context: context, isWarning: true, text: 'Comune obbligatorio');
      return;
    }

    if(schoolType.isEmpty || educationDegree.isEmpty){
      Utils.showToast(context: context, isWarning: true, text: 'Selezionare tipo di scuola e grado');
      return;
    }

    institute = Institute(
      code: codeCtrl.text,
      referenceInstituteCode: referenceCodeCtrl.text,
      name: nameCtrl.text,
      region: region, 
      educationDegree: educationDegree,
      schoolType: schoolType,
      city: cityCtrl.text,
      province: province,
      address: addressCtrl.text,
      cap: capCtrl.text,
      email: GetUtils.isEmail(emailCtrl.text) ? emailCtrl.text : null,
      pec: GetUtils.isEmail(pecCtrl.text) ? pecCtrl.text : null,
      website: siteCtrl.text,
      isHeadOffice: educationDegree=='ISTITUTO COMPRENSIVO',
      geographicArea: geoZone,
      state: 'ITALIA',
      iban: ibanCtrl.text,
      vatNumber: ivaCtrl.text,
      fax: faxCtrl.text,
      phoneNumber: phoneCtrl.text,
      convention: _conventionStartDate!=null && _conventionExpireDate!=null 
        ? Convention(startDate: _conventionStartDate, endDate: _conventionExpireDate) : null,
    );
    
    
    var res = await _repo.postInstitute(institute!);

    if(res.isSuccess() && res.getSuccess()!=null){
      Utils.showToast(context: context, text: 'Istituto salvato');
      context.goNamed('istituto', params: {'code': codeCtrl.text});
    }else{
      Utils.showToast(context: context, isError: true, text: 'Si è verificato un errore');
      print(res.getError());
    }
    
  }

  // Convention
  void deleteConvention(context) async {
    var res = await _repo.patchInstitute(iid!, {
      "convention": null
    });

    res.when(
      (error) => Utils.showToast(isError: true, context: context, text: 'Si è verificato un errore'), 
      (success) {
        Utils.showToast(context: context, text: 'Convenzione rimossa');
        _getInstitute();
      }
    );
  }

  // ASSIGN STUDENT TO INSTITUTE --------

  Future<void> assignStudent(context, DirectInternship directInternship, String instituteCode, {bool reloadPage=false}) async {

    List<String> choices = [];
    choices.addAll(directInternship.assignedChoice);

    if(!choices.contains(instituteCode)){
      choices.add(instituteCode);
    }

    var patch = PatchStudentDirect(
      assignedChoice: choices, 
      isAssignedChoiceConfirmed: false,
    );

    if(kDebugMode)
      print(patch.toJson());

    var res = await _studentsRepo.patchStudentDirect(directInternship.id!, patch);

    res.when(
      (error) => Utils.showToast(context: context, isError: true, text: 'Si è verificato un errore'), 
      (success) {
        Utils.showToast(context: context, text: 'Assegnazione effettuata');

        if(reloadPage){
          reload();
        }else{
          update();
        }
        
      },
    );
  }
  

  // endgame
  @override
  void onClose() {
    nameCtrl.dispose();
    codeCtrl.dispose();
    referenceCodeCtrl.dispose();
    ivaCtrl.dispose();
    ibanCtrl.dispose();

    addressCtrl.dispose();
    capCtrl.dispose();
    cityCtrl.dispose();
    stateCtrl.dispose();

    phoneCtrl.dispose();
    faxCtrl.dispose();
    emailCtrl.dispose();
    pecCtrl.dispose();
    siteCtrl.dispose();

    conventionStartCtrl.dispose();
    conventionExpireCtrl.dispose();
    super.onClose();
  }
}