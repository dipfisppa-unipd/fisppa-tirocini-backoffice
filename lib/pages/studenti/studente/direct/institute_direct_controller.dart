import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/models/td/institute_tutor_model.dart';
import 'package:unipd_tirocini/pages/studenti/studente/student_controller.dart';

import '../../../../models/students/patch/patch_student_direct.dart';
import '../../../../models/td/direct_model.dart';
import '../../../../repos/students_repo.dart';
import '../../../../utils/utils.dart';


class InstituteDirectController extends GetxController {

    final DirectInternship internship;

    InstituteDirectController(this.internship);

    final _repo = StudentsRepo();
    
    // Tutor 1
    final tutorSchoolCodeCtrl = TextEditingController();
    bool tutorOrder = true;
    final tutorNameCtrl = TextEditingController();
    final tutorSurnameCtrl = TextEditingController();
    final tutorEmailCtrl = TextEditingController();
    final tutorPhoneCtrl = TextEditingController();
    final tutorNotesCtrl = TextEditingController();

    // Tutor 2
    final tutor2SchoolCodeCtrl = TextEditingController();
    bool tutor2order = true;
    final tutor2NameCtrl = TextEditingController();
    final tutor2SurnameCtrl = TextEditingController();
    final tutor2EmailCtrl = TextEditingController();
    final tutor2PhoneCtrl = TextEditingController();
    final tutor2NotesCtrl = TextEditingController();

    @override
    void onInit() {
      if(internship.instituteTutor.length>0){
        tutorNameCtrl.text = internship.instituteTutor.first.firstName??'';
        tutorSurnameCtrl.text = internship.instituteTutor.first.lastName??'';
        tutorEmailCtrl.text = internship.instituteTutor.first.email??'';
        tutorPhoneCtrl.text = internship.instituteTutor.first.phoneNumber??'';
        tutorNotesCtrl.text = internship.instituteTutor.first.notes??'';
        tutorSchoolCodeCtrl.text = internship.instituteTutor.first.schoolCode??'';
        tutorOrder = internship.instituteTutor.first.isPrimary;
        
        if(internship.instituteTutor.length==2){
          tutor2NameCtrl.text = internship.instituteTutor.last.firstName??'';
          tutor2SurnameCtrl.text = internship.instituteTutor.last.lastName??'';
          tutor2EmailCtrl.text = internship.instituteTutor.last.email??'';
          tutor2PhoneCtrl.text = internship.instituteTutor.last.phoneNumber??'';
          tutor2NotesCtrl.text = internship.instituteTutor.last.notes??'';
          tutor2SchoolCodeCtrl.text = internship.instituteTutor.last.schoolCode??'';
          tutor2order = internship.instituteTutor.last.isPrimary;

        }

      }
      super.onInit();
    }

    void onTutorOrderChanged(bool v){
      tutorOrder = v;
      update();
    }

    void onTutor2orderChanged(bool v){
      tutor2order = v;
      update();
    }

    Future<void> patchInstituteTutor(context) async {

      if(tutorNameCtrl.text.isEmpty || tutorSurnameCtrl.text.isEmpty || tutorEmailCtrl.text.isEmpty){
        Utils.showToast(context: context, isWarning: true, text: 'Inserire nome, cognome e email del tutor scolastico');
        return;
      }

      var patch = PatchStudentDirect(
        assignedChoice: internship.assignedChoice,
        isAssignedChoiceConfirmed: internship.isAssignedChoiceConfirmed,
        instituteTutor: [
          // 1
          if(internship.assignedChoice.length>0 && tutorEmailCtrl.text.isNotEmpty)
          InstituteTutor(
            firstName: tutorNameCtrl.text,
            lastName: tutorSurnameCtrl.text,
            email: tutorEmailCtrl.text,
            phoneNumber: tutorPhoneCtrl.text,
            notes: tutorNotesCtrl.text,
            schoolCode: tutorSchoolCodeCtrl.text,
            isPrimary: tutorOrder
          ),

          // 2
          if(internship.assignedChoice.length==2 && tutor2EmailCtrl.text.isNotEmpty)
          InstituteTutor(
            firstName: tutor2NameCtrl.text,
            lastName: tutor2SurnameCtrl.text,
            email: tutor2EmailCtrl.text,
            phoneNumber: tutor2PhoneCtrl.text,
            notes: tutor2NotesCtrl.text,
            schoolCode: tutor2SchoolCodeCtrl.text,
            isPrimary: tutor2order
          ),
        ],
      );

      var res = await _repo.patchStudentDirect(internship.id!, patch);

      res.when(
        (error) => Utils.showToast(context: context, isError: true, text: 'Si è verificato un errore'), 
        (success) {
          Utils.showToast(context: context, text: 'Tutor salvato');

          StudentController.to.reload();
          
        },
      );
    }

    @override
  void onClose() {
    tutorNameCtrl.dispose();
    tutorSurnameCtrl.dispose();
    tutorEmailCtrl.dispose();
    tutorPhoneCtrl.dispose();
    tutorNotesCtrl.dispose();
    tutorSchoolCodeCtrl.dispose();

    tutor2NameCtrl.dispose();
    tutor2SurnameCtrl.dispose();
    tutor2EmailCtrl.dispose();
    tutor2PhoneCtrl.dispose();
    tutor2NotesCtrl.dispose();
    tutor2SchoolCodeCtrl.dispose();
    super.onClose();
  }

}