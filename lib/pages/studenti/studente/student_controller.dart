
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/models/enums/student_sections.dart';
import 'package:unipd_tirocini/models/students/career_model.dart';
import 'package:unipd_tirocini/models/students/patch/patch_student_direct.dart';
import 'package:unipd_tirocini/repos/ti_repo.dart';
import 'package:unipd_tirocini/utils/utils.dart';

import '../../../models/students/students_model.dart';
import '../../../models/td/institute_model.dart';
import '../../../models/ti/group_model.dart';
import '../../../repos/students_repo.dart';

class StudentController extends GetxController{

  static StudentController get to => Get.find();

  final String sid;

  StudentController({required this.sid});

  final _repo = StudentsRepo();
  final _repoTI = TIRepo();
  
  bool isReadOnly = true;
  bool isLoading = true;
  Student? student, _studentCopy; // studentCopy is used for edited version
  List<GroupModel> groups = [];

  StudentSections section = StudentSections.anagrafica;
  int currentYear = DateTime.now().year;

  final nomeCtrl = TextEditingController();
  final cognomeCtrl = TextEditingController();
  final corsoDiLaureaCtrl = TextEditingController();
  final matricolaCtrl = TextEditingController();
  final earnedCreditsCtrl = TextEditingController();
  
  int annoDiTirocinio = 0;
  int annoDiCorso = 0;
  final customInstituteCodeCtrl = TextEditingController();
  

  final indirizzoDomCtrl = TextEditingController();
  final capDomCtrl = TextEditingController();
  final comuneDomCtrl = TextEditingController();
  final provinciaDomCtrl = TextEditingController();
  // final nazioneDomCtrl = TextEditingController();


  final indirizzoResCtrl = TextEditingController();
  final capResCtrl = TextEditingController();
  final comuneResCtrl = TextEditingController();
  final provinciaResCtrl = TextEditingController();
  // final nazioneResCtrl = TextEditingController();

  final cellulareCtrl = TextEditingController();
  final emailIstituzionaleCtrl = TextEditingController();
  final emailPersonaleCtrl = TextEditingController();
  final noteCtrl = TextEditingController();

  RxBool isDomDiversoRes = false.obs;

  bool get studentHasIndirects =>  student!.indirectInternships.length>0;
  bool get studentHasDirects => student!.directInternships.length>0;
  

  @override
  void onInit() {
    _getStudent();
    super.onInit();
  }

  void reload() => _getStudent();

  void _getStudent() async {
    student = await _repo.getStudent(sid);
    
    if(student!=null){
      _studentCopy = student!.copyWith(
        registry: student!.registry?.copyWith(),
        university: student!.university?.copyWith(),
        email: emailPersonaleCtrl.text,
        career: student!.career?.copyWith(),
      );

      if(_studentCopy!.career!=null){
        _studentCopy!.career!.academicYears.sort(((a, b) => a.calendarYear!<b.calendarYear! ? 1 : 0));
      }

      nomeCtrl.text = student!.registry!.firstName!;
      cognomeCtrl.text = student!.registry!.lastName!;
      matricolaCtrl.text = student!.university!.studentNumber!;
      earnedCreditsCtrl.text = student!.university?.credits.toString() ?? '0';
      annoDiTirocinio = student!.getInternshipYear();
      annoDiCorso = student!.academicYear();
      
      // domicile
      indirizzoDomCtrl.text = student!.registry!.domicile!.street!;
      capDomCtrl.text = student!.registry!.domicile!.cap!;
      comuneDomCtrl.text = student!.registry!.domicile!.city!;
      provinciaDomCtrl.text = student!.registry!.domicile!.province!;

      // residence
      indirizzoResCtrl.text = student!.registry!.residence!.street!;
      capResCtrl.text = student!.registry!.residence!.cap!;
      comuneResCtrl.text = student!.registry!.residence!.city!;
      provinciaResCtrl.text = student!.registry!.residence!.province!;

      isDomDiversoRes.value = student!.registry!.domicile != student!.registry!.residence;
      
      cellulareCtrl.text = student!.registry!.cellNumber!;
      emailIstituzionaleCtrl.text = student!.email!;
      emailPersonaleCtrl.text = student!.registry!.personalEmail!;

      noteCtrl.text = student!.university?.earnedCreditsNotes ?? '';

      if(studentHasIndirects){
        student!.indirectInternships = student!.indirectInternships.reversed.toList();
        _checkIndirectStatus();
      }

      if(studentHasDirects){
        student!.directInternships = student!.directInternships.reversed.toList();
      }
        
    }

    isLoading = false;
    update();
  }

  void changeSection(StudentSections s ){
    section = s;
    update();
  }

  void toggleReadOnly(){
    isReadOnly = !isReadOnly;
    update();
  }

  void changeInternshipYear(int i){
    annoDiTirocinio = i;
    update();
  }

  /// check if the student has indirect internships in
  /// unassigned status. 
  /// If found, then load all the groups for that year
  void _checkIndirectStatus() async {
    
    var internship = student!.indirectInternships.firstWhereOrNull((element) => !element.isAssignedChoiceConfirmed);

    if(internship!=null && internship.internshipYear!=null){
      groups = await _repoTI.getGroups(internshipYear: internship.internshipYear!);
      update();
    }
    
  }

  Future<void> assignGroup(context, String indirectId, String gid) async {

    var res = await _repo.patchStudentIndirect(indirectId, custom: {'assignedChoice': gid});

    res.when(
      (error) => Utils.showToast(context: context, isError: true, text: 'Si è verificato un errore'), 
      (success) {
        Utils.showToast(context: context, text: 'Assegnato al gruppo');
        
        _getStudent();
      },
    );

  }

  Future<void> unassignGroup(context, String indirectId, String gid) async {
    Map<String, dynamic> patch = {
      'assignedChoice': null,
      'isAssignedChoiceConfirmed': false,
    };

    var res = await _repo.patchStudentIndirect(indirectId, custom: patch);

    res.when(
      (error) => Utils.showToast(context: context, isError: true, text: 'Si è verificato un errore'), 
      (success) {
        Utils.showToast(context: context, text: 'Rimosso dal gruppo');
        
        _getStudent();
      },
    );
  }

  Future<void> confirmGroupAssignment(context, String indirectId, String gid, {bool confirm=true}) async {

    var res;

    if(confirm){
      res = await _repo.patchStudentIndirect(indirectId, custom: {'isAssignedChoiceConfirmed': true,});
    }else{
      res = await _repo.patchStudentIndirect(indirectId, custom: {'assignedChoice': null, 'isAssignedChoiceConfirmed': false,});
    }


    res.when(
      (error) => Utils.showToast(context: context, isError: true, text: 'Si è verificato un errore'), 
      (success) {
        Utils.showToast(context: context, text: confirm ? 'Confermato Tirocinio Indiretto' : 'Tirocinio modificabile');
        
        _getStudent();
      },
    );
  }

  
  Future<void> unassignInstitute(context, String iid, String code) async {
    List<String> assignedCodes = [];
    var direct = student!.directInternships.firstWhereOrNull((element) => element.id==iid);

    if(direct!=null){
      assignedCodes.addAll(direct.assignedChoice);
    }

    if(assignedCodes.isNotEmpty)
      assignedCodes.removeWhere((element) => element==code);

    var patch = PatchStudentDirect(
      assignedChoice: assignedCodes, 
      isAssignedChoiceConfirmed: false,
      instituteTutor: null,
    );

    var res = await _repo.patchStudentDirect(iid, patch, keepNullValues: true);

    res.when(
      (error) => Utils.showToast(context: context, isError: true, text: 'Si è verificato un errore'), 
      (success) {
        Utils.showToast(context: context, text: 'Rimossa assegnazione');
        var index = student!.directInternships.indexOf(direct!);
        student!.directInternships[index].assignedChoice.removeWhere((e)=>e==code);
        student!.directInternships[index].enhancedAssignedChoice!.removeWhere((e)=> e.code==code);
        update();
      },
    );
  }

  /// Assign, but not confirm, this institute with [code] (codice meccanografico)
  /// to the student
  /// 
  /// [iid] direct internship id
  /// [institute] institute where the student is assigned
  /// 
  Future<void> assignInstitute(context, String iid, Institute institute, {bool reload=false}) async {

    List<String> assignedCodes = [];
    var direct = student!.directInternships.firstWhereOrNull((element) => element.id==iid);

    if(direct!=null && direct.assignedChoice.isNotEmpty){
      assignedCodes.addAll(direct.assignedChoice);
    }

    if(assignedCodes.length==2){
      Utils.showToast(context: context, isWarning: true, text: 'Attenzione, ci sono già 2 istituti');
      return;
    }

    if(!assignedCodes.contains(institute.code)){
      assignedCodes.add(institute.code);
    }

    var patch = PatchStudentDirect(
      assignedChoice: assignedCodes, 
      isAssignedChoiceConfirmed: false,
    );

    var res = await _repo.patchStudentDirect(iid, patch);

    res.when(
      (error) => Utils.showToast(context: context, isError: true, text: 'Si è verificato un errore'), 
      (success) {
        Utils.showToast(context: context, text: 'Assegnazione effettuata');

        if(reload){
          _getStudent();
        }else{
          var index = student!.directInternships.indexOf(direct!);
          student!.directInternships[index].assignedChoice.clear();
          student!.directInternships[index].assignedChoice.addAll(assignedCodes);
          student!.directInternships[index].enhancedAssignedChoice!.add(institute);
          update();
        }
        
      },
    );

  }

  Future<void> assignInstituteFromCode(context, String iid,) async {
    if(customInstituteCodeCtrl.text.isEmpty){
      Utils.showToast(context: context, isWarning: true, text: 'Inserire il codice meccanografico');
      return;
    }

    await assignInstitute(context, iid, Institute(code: customInstituteCodeCtrl.text, name: ''), reload: true);
  }

  /// The assignment is for both institutes (in case of 2)
  /// 
  Future<void> confirmInstituteAssignment(context, String iid, {bool confirm=true}) async {

    List<String> assignedCodes = [];
    var direct = student!.directInternships.firstWhereOrNull((element) => element.id==iid);

    if(direct!=null && direct.assignedChoice.isNotEmpty){
      assignedCodes.addAll(direct.assignedChoice);
    }

    if(assignedCodes.length==0){
      Utils.showToast(context: context, isWarning: true, text: 'Attenzione, nessun istituto assegnato');
      return;
    }

    var patch = PatchStudentDirect(
      assignedChoice: assignedCodes, 
      isAssignedChoiceConfirmed: confirm,
      instituteTutor: []
    );

    var res = await _repo.patchStudentDirect(iid, patch, keepNullValues: !confirm);

    res.when(
      (error) => Utils.showToast(context: context, isError: true, text: 'Si è verificato un errore'), 
      (success) {
        Utils.showToast(context: context, text: confirm ? 'Tirocinio diretto confermato' : 'Tirocinio diretto modificabile');
        isLoading = true;
        update();
        _getStudent();
      },
    );
    
  }


  /// Edit user info
  /// 
  
  Future<void> addCareer(context, int careerYear) async {
    var academicYear = AcademicYear(
      calendarYear: careerYear,
      universityCity: '',
      universityOfOrigin: '',
      erasmus: Erasmus.empty(),
      jobs: [],
    );

    if(_studentCopy!.career==null || _studentCopy!.career!.academicYears.length==0){
      _studentCopy!.career = Career(
        inProgress: true,
        finalNotes: '',
        finalScore: 0,
        academicYears: [academicYear],
      );
    }else{
      
      var found = _studentCopy!.career!.academicYears.firstWhereOrNull((element) => element.calendarYear==careerYear);
      if(found!=null){
        Utils.showToast(context: context, isError: true, text: 'Esiste già una carriera per il $careerYear');
        return;
      }

      await saveCareer(context, academicYear);

    }
    
  }

  Future<bool> saveCareer(context, AcademicYear academicYear) async {
    var found = _studentCopy!.career!.academicYears.firstWhereOrNull((element) => element.calendarYear==academicYear.calendarYear);
    if(found!=null){
      var index = _studentCopy!.career!.academicYears.indexOf(found);
      _studentCopy!.career!.academicYears[index] = academicYear;
    }else{
      _studentCopy!.career!.academicYears.add(academicYear);
    }

    return await editStudent(context);
  }

  Future<bool> editStudent(context) async {

    _studentCopy = _studentCopy!.copyWith(
      registry: _studentCopy!.registry!.copyWith(
        firstName: nomeCtrl.text,
        lastName: cognomeCtrl.text,
        cellNumber: cellulareCtrl.text,
        personalEmail: emailPersonaleCtrl.text,
        domicile: _studentCopy!.registry!.domicile!.copyWith(
          city: comuneDomCtrl.text,
          cap: capDomCtrl.text,
          province: provinciaDomCtrl.text,
          street: indirizzoDomCtrl.text,
        ),
        residence: _studentCopy!.registry!.residence!.copyWith(
          city: comuneResCtrl.text,
          cap: capResCtrl.text,
          province: provinciaResCtrl.text,
          street: indirizzoResCtrl.text,
        )
      ),
      university: _studentCopy!.university!.copyWith(
        earnedCreditsNotes: noteCtrl.text,
        earnedCreditsNumber: int.tryParse(earnedCreditsCtrl.text),
      ),
    );
    
    var res = await _repo.editStudent(student!.id!, _studentCopy!);

    res.when(
      (error) => Utils.showToast(context: context, isError: true, text: 'Si è verificato un errore'), 
      (success) {
        Utils.showToast(context: context, text: 'Salvataggio effettuato');
        _getStudent();
      }
    );

    return res.isSuccess();
  }

  // Endgame ---
  @override
  void onClose() {
    nomeCtrl.dispose();
    cognomeCtrl.dispose();
    corsoDiLaureaCtrl.dispose();
    matricolaCtrl.dispose();
    earnedCreditsCtrl.dispose();

    indirizzoDomCtrl.dispose();
    capDomCtrl.dispose();
    comuneDomCtrl.dispose();
    provinciaDomCtrl.dispose();
    // nazioneDomCtrl.dispose();

    indirizzoResCtrl.dispose();
    capResCtrl.dispose();
    comuneResCtrl.dispose();
    provinciaResCtrl.dispose();
    // nazioneResCtrl.dispose();
    
    cellulareCtrl.dispose();
    emailIstituzionaleCtrl.dispose();
    emailPersonaleCtrl.dispose();
    noteCtrl.dispose();

    customInstituteCodeCtrl.dispose();
    super.onClose();
  }
}