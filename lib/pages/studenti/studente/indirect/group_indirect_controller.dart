import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/pages/studenti/studente/student_controller.dart';
import 'package:unipd_tirocini/repos/ti_repo.dart';
import 'package:unipd_tirocini/utils/utils.dart';

import '../../../../models/ti/group_model.dart';
import '../../../../models/ti/indirect_model.dart';
import '../../../../repos/students_repo.dart';


class GroupIndirectController extends GetxController{

  final IndirectInternship indirect;

  GroupIndirectController(this.indirect);

  final _repo = StudentsRepo();
  final _tiRepo = TIRepo();
  
  bool isProjectApproved = false;
  final valutazioneController = TextEditingController();
  final evaluation = 0.obs; // from 0 to 3

  final voteLabel = const ['Sufficiente', 'Buono', 'Distinto', 'Ottimo'];

  Map<String, dynamic> patch = {};
  
  bool isLoadingGroupDetails = true;
  GroupModel? group;

  @override
  void onInit() {
    isProjectApproved = indirect.isProjectApproved;
    evaluation.value = indirect.evaluation;
    valutazioneController.text = indirect.internalNotes;
    getGroupDetails();
    super.onInit();
  }

  void getGroupDetails() async {
    
    group = await _tiRepo.getGroupDetails(gid: indirect.assignedChoice!, internshipYear: indirect.internshipYear!);
    isLoadingGroupDetails = false;
    update();
  }

  void toggleProjectApproved(){
    isProjectApproved = !isProjectApproved;
    if(indirect.isProjectApproved!=isProjectApproved){
      patch['isApproved'] = isProjectApproved;
    }else{
      patch.removeWhere((key, value) => key=='isApproved');
    }
    update();
  }

  void editVote(double v){
    evaluation.value = v.toInt();
    if(indirect.evaluation!=evaluation()){
      patch['evaluation'] = evaluation.value;
    }else{
      patch.removeWhere((key, value) => key=='evaluation');
    }
  }

  Future<void> onSave(context) async {
    patch['internalNotes'] = valutazioneController.text;

    var res = await _repo.patchStudentIndirect(indirect.id!, custom: patch);

    res.when(
      (error) => Utils.showToast(context: context, isError: true, text: 'Si è verificato un errore'), 
      (success) {
        Utils.showToast(context: context, text: 'Salvataggio effettuato');
        StudentController.to.reload();
      },
    );
  }

  // Endgame ---
  @override
  void onClose() {
    
    valutazioneController.dispose();
    super.onClose();
  }
}