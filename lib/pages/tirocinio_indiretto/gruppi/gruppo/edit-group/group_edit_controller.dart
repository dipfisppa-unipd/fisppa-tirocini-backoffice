import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/models/user.dart';

import '../../../../../models/operators/operators_model.dart';
import '../../../../../models/ti/group_model.dart';
import '../../../../../repos/admin_repo.dart';
import '../../../../../repos/ti_repo.dart';
import '../../../../../utils/utils.dart';

/// {
///  "name": "Test2",
///  "foundationYear": 2022,
///  "territoriality_id": "629956825696061ff9d22645",
///  "coordinatorTutor": "prova tutor", 
///  "organizerTutor": "prova tutor"
/// }
/// 
/// These are the only data needed to create and edit a group.
/// 
/// The internshipYear it's now calucalted through the foundationYear
/// 
class GroupEditController extends GetxController {

  final String? gid;
  int? internshipYear;

  GroupEditController({this.gid, this.internshipYear});

  final _repo = TIRepo();
  final AdminRepo _adminRepo = AdminRepo();

  GroupModel? group;
  OperatorsModel? coordinatorsTutors, organizerTutors;
  
  String tutorCoordinatoreId = '';
  String tutorOrganizzatoreId = '';

  String selectedTerritorialityId = '';

  final denominazioneController = TextEditingController();
  final foundationYearCtrl = TextEditingController();

  final notesGroupCtrl = TextEditingController();

  @override
  void onInit() {
    foundationYearCtrl.text = (DateTime.now().year).toString();
    _getTutors();
    
    super.onInit();
  }

  Future<void> _getTutors() async {
    var data1 = await _adminRepo.getOperators(UserType.coordinatorTutor);
    var data2 = await _adminRepo.getOperators(UserType.organizerTutor);

    if(data1.isSuccess()){
      coordinatorsTutors = data1.getSuccess();
      if(coordinatorsTutors!.users!=null && coordinatorsTutors!.users!=null && coordinatorsTutors!.users!.isNotEmpty)
        coordinatorsTutors!.users!.sort(((a, b) => a.fullname.compareTo(b.fullname)));
    }
      
    if(data2.isSuccess()){
      organizerTutors = data2.getSuccess();
      if(organizerTutors!.users!=null && organizerTutors!.users!=null)
        organizerTutors!.users!.sort(((a, b) => a.fullname.compareTo(b.fullname)));
    }

    if(gid!=null){
      _getGroupDetails();
    }else{
      update();
    }
    
  }

  void _getGroupDetails() async {
    group = await _repo.getGroupDetails(gid: gid!, internshipYear: internshipYear ?? 1);

    if(group!=null){
      denominazioneController.text = group!.name ?? '';
      selectedTerritorialityId = group!.territorialityId ?? '';
      foundationYearCtrl.text = group!.foundationYear.toString();
      tutorCoordinatoreId = group!.coordinatorTutor?.id ?? '';
      tutorOrganizzatoreId = group!.organizerTutor?.id ?? '';
      notesGroupCtrl.text = group!.notes ?? '';

      internshipYear = DateTime.now().year - group!.foundationYear;
    }
    
    update();
  }

  void changeTerritoriality(String s){
    selectedTerritorialityId = s;
    update();
  }

  void changeInternshipYear(int i){
    internshipYear = i;
    update();
  }

  void pickDate(context) async {
    var picked = await Utils.pickDate(context);

    if(picked!=null){
      foundationYearCtrl.text = picked.year.toString();
      update();
    }
  }

  void onTutorChanged(UserType usertype, String value){
    if(usertype==UserType.coordinatorTutor){
      tutorCoordinatoreId = value;
    }else if(usertype==UserType.organizerTutor){
      tutorOrganizzatoreId = value;
    }
    update();
  }

  Future<String?> onSaveGroup() async {
    
    if(kDebugMode){
      print('----');
      print('GID: $gid');
      print('internship year: $internshipYear');
      print('calendar year: ${foundationYearCtrl.text}');
      print(selectedTerritorialityId);
      print(denominazioneController.text);
      print('organizerId: $tutorOrganizzatoreId');
      print('coordinatore: $tutorCoordinatoreId');
      print('----');
    }

    if(gid!=null){
      Map<String, dynamic> body = {
        "name": denominazioneController.text,
        "territoriality_id": selectedTerritorialityId,
        "coordinatorTutor": tutorCoordinatoreId,
        "organizerTutor": tutorOrganizzatoreId,
        "notes": notesGroupCtrl.text,
      };

      body.removeWhere((key, value) => value==null);

      return await _repo.patchGroup(gid!, body);


    }else{ // creazione nuovo gruppo

      String? res = await _repo.createGroup(GroupModel(
        foundationYear: int.tryParse(foundationYearCtrl.text) ?? DateTime.now().year,
        territorialityId: selectedTerritorialityId,
        name: denominazioneController.text,
        notes: notesGroupCtrl.text,
        coordinatorTutorId: tutorCoordinatoreId,
        organizerTutorId: tutorOrganizzatoreId,
      ));

      return res;
    }
  }

  // endgame
  @override
  void onClose() {
    denominazioneController.dispose();
    foundationYearCtrl.dispose();
    super.onClose();
  }
}