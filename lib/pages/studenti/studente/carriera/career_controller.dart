import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/models/students/career_model.dart';
import 'package:unipd_tirocini/pages/studenti/studente/student_controller.dart';
import 'package:unipd_tirocini/utils/utils.dart';


class CareerController extends GetxController {

  final AcademicYear? academicYear;

  CareerController([this.academicYear]);

  bool isReadOnly = true;

  final uniOriginCtrl = TextEditingController();
  final uniCityCtrl = TextEditingController();

  bool inErasmus = false;
  // erasmus
  final universityCtrl = TextEditingController();
  final stateCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final erasmusNoteCtrl = TextEditingController();

  bool isWorking = false;
  // job
  bool reductionRight=false;
  bool addNewJob = false;
  bool isPrimary = true;
  final roleCtrl = TextEditingController();
  final contractTypeCtrl = TextEditingController();
  final durationCtrl = TextEditingController();
  final weekScheduleCtrl = TextEditingController();
  final percentReductionCtrl = TextEditingController();
  final schoolCodeCtrl = TextEditingController();
  final jobNotesCtrl = TextEditingController();

  // New career
  final calendarYearCtrl = TextEditingController();

  // temp
  
  
  void toggleNewJob(){
    addNewJob = !addNewJob;
    update();
  }
  void togglePrimary(bool v){
    isPrimary = v;
    update();
  }

  @override
  void onInit() {

    if(academicYear!=null){

      uniOriginCtrl.text = academicYear!.universityOfOrigin ?? '';
      uniCityCtrl.text = academicYear!.universityCity ?? '';

      inErasmus = academicYear!.erasmus!=null 
        && academicYear!.erasmus!.university!=null 
        && academicYear!.erasmus!.university!.isNotEmpty;

      universityCtrl.text = academicYear!.erasmus?.university ?? '';
      stateCtrl.text = academicYear!.erasmus?.state ?? '';
      addressCtrl.text = academicYear!.erasmus?.address ?? '';
      emailCtrl.text = academicYear!.erasmus?.email ?? '';
      erasmusNoteCtrl.text = academicYear!.erasmus?.notes ?? '';

      isWorking = academicYear!.jobs.isNotEmpty;
      reductionRight = academicYear!.reductionRight;
      percentReductionCtrl.text = academicYear!.reductionPercentage.toString();

      

    }
    

    super.onInit();
  }

  void toggleReadOnly(){
    isReadOnly = !isReadOnly;
    update();
  }

  void toggleErasmus(bool? v){
    inErasmus = v ?? false;
    update();
  }

  void toggleIsWorking(bool? v){
    isWorking = v ?? false;
    update();
  }

  void toggleReductionRight(bool? v){
    reductionRight = v ?? false;
    update();
  }

  Future<void> saveCareer(context) async {

    int? duration = int.tryParse(durationCtrl.text);
    int? percent = int.tryParse(percentReductionCtrl.text);
    int? weekSchedule = int.tryParse(weekScheduleCtrl.text);

    if(addNewJob){

      if(schoolCodeCtrl.text.isEmpty){
        Utils.showToast(context: context, isWarning: true, text: 'Indicare il codice della scuola');
        return;
      }

      if(duration==null){
        Utils.showToast(context: context, isWarning: true, text: 'La durata del contratto non è valida');
        return;
      }
      if(percent==null){
        Utils.showToast(context: context, isWarning: true, text: 'La percentuale di riduzione non è valida');
        return;
      }
      if(weekSchedule==null){
        Utils.showToast(context: context, isWarning: true, text: 'Le ore settimanali non sono valide');
        return;
      }
      

    }

    List<Job> jobs = [];
    jobs.addAll(academicYear!.jobs);
    Job? newJob;

    if(schoolCodeCtrl.text.isNotEmpty){
      newJob = Job(
        role: roleCtrl.text,
        contractDuration: duration!,
        contractType: contractTypeCtrl.text,
        schoolDegree: isPrimary ? 'primaria' : 'infanzia',
        weeklySchedule: weekSchedule!,
        schoolCode: schoolCodeCtrl.text,
        notes: jobNotesCtrl.text,
        workLocation: '',
      );
      jobs.add(newJob);
    }

    AcademicYear edited = academicYear!.copyWith(
      universityOfOrigin: uniOriginCtrl.text,
      universityCity: uniCityCtrl.text,
      reductionPercentage: int.tryParse(percentReductionCtrl.text) ?? 0,
      reductionRight: reductionRight,
      erasmus: academicYear!.erasmus!.copyWith(
        address: addressCtrl.text,
        email: emailCtrl.text,
        state: stateCtrl.text,
        university: universityCtrl.text,
        notes: erasmusNoteCtrl.text,
      ),
      jobs: jobs,
    );

    bool success = await StudentController.to.saveCareer(context, edited);

    if(success && addNewJob){
      academicYear!.jobs.add(newJob!);
      addNewJob = false;
      // Relative solo all'aggiunta di un nuovo lavoro

      clearNewJobFields();
    }
  }

  void clearNewJobFields(){
    isPrimary = true;
    schoolCodeCtrl.clear();
    roleCtrl.clear();
    contractTypeCtrl.clear();
    durationCtrl.clear();
    weekScheduleCtrl.clear();
    jobNotesCtrl.clear();
    update();
  }
  
  void pickDate(context) async {

    final choice = await Utils.pickDate(context, maxYear: DateTime.now().year+1);

    if(choice!=null){
      calendarYearCtrl.text = '${choice.year}';
      update();
    }
  }

  Future<void> addCareer(context) async {
    if(calendarYearCtrl.text.isEmpty){
      Utils.showToast(context: context, isWarning: true, text: 'Selezionare l\'anno di carriera');
      return;
    }

    int? careerYear = int.tryParse(calendarYearCtrl.text);

    if(careerYear==null){
      Utils.showToast(context: context, isWarning: true, text: 'L\'anno selezionato non è valido');
    }else{
      StudentController.to.addCareer(context, careerYear);
    }

    
  }

  int totalDaysOfWork(){
    int total = 0;

    if(academicYear!=null)
    for(var job in academicYear!.jobs){
      total += job.contractDuration;
    }
    return total;
  }

  int get totalJobs => academicYear?.jobs.length ?? 0;

  // endgame
  @override
  void onClose() {
    uniOriginCtrl.dispose();
    uniCityCtrl.dispose();

    universityCtrl.dispose();
    stateCtrl.dispose();
    addressCtrl.dispose();
    emailCtrl.dispose();
    erasmusNoteCtrl.dispose();

    roleCtrl.dispose();
    contractTypeCtrl.dispose();
    durationCtrl.dispose();
    weekScheduleCtrl.dispose();
    percentReductionCtrl.dispose();
    schoolCodeCtrl.dispose();
    jobNotesCtrl.dispose();

    calendarYearCtrl.dispose();

    super.onClose();
  }
}