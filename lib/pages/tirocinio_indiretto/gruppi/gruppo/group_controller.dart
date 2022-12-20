import 'package:get/get.dart';
import 'package:unipd_tirocini/models/ti/group_model.dart';


import '../../../../repos/students_repo.dart';
import '../../../../repos/ti_repo.dart';
import '../../../../utils/utils.dart';

class GroupController extends GetxController{

  final String? gid;
  int internshipYear;

  GroupController({this.gid, this.internshipYear=1});

  final _repo = TIRepo();
  final _studentsRepo = StudentsRepo();

  GroupModel? group;

  String get coordinatorTutor => group?.coordinatorTutor?.fullname!='nd' ? group?.coordinatorTutor?.fullname??'nd' : group?.coordinatorTutor?.email??'nd';
  String get organizerTutor => group?.organizerTutor?.fullname!='nd' ? group?.organizerTutor?.fullname??'nd' : group?.organizerTutor?.email??'nd';

  @override
  void onInit() {
    if(gid!=null){
      getGroupDetails();
    }
    super.onInit();
  }

  void changeInternshipYear(int i){
    internshipYear = i;
    getGroupDetails();
  }

  void getGroupDetails() async {
    group = null;
    update();

    group = await _repo.getGroupDetails(gid: gid!, internshipYear: internshipYear);

    if(group!=null && group!.indirectInternships!=null && group!.indirectInternships!.isNotEmpty){
      group!.indirectInternships!.sort((a,b) => a.enhancedUser!.fullname.compareTo(b.enhancedUser!.fullname));
    }
    

    update();
  }

  int countInternshipSubscriptions() {
    if(group==null || group!.indirectInternships==null)
      return 0;
    
    return group!.indirectInternships!.length;
  }

  // Future<void> assignGroup(context, String internshipId, String groupId) async {
  //   var res = await _repo.patchStudentIndirect(indirectId, custom: {'assignedChoice': gid});

  //   res.when(
  //     (error) => Utils.showToast(context: context, isError: true, text: 'Si è verificato un errore'), 
  //     (success) {
  //       Utils.showToast(context: context, text: 'Assegnato al gruppo');
        
  //       _getStudent();
  //     },
  //   );
  // }

  Future<void> confirmGroupAssignment(context, String internshipId, {bool confirm=true}) async {
    var res;

    if(confirm){
      res = await _studentsRepo.patchStudentIndirect(internshipId, custom: {'isAssignedChoiceConfirmed': true,});
    }else{
      res = await _studentsRepo.patchStudentIndirect(internshipId, custom: {'assignedChoice': null, 'isAssignedChoiceConfirmed': false,});
    }

    res.when(
      (error) => Utils.showToast(context: context, isError: true, text: 'Errore: $error'), 
      (success) {
        Utils.showToast(context: context, text: confirm ? 'Confermato per il gruppo' : '---');
        
        getGroupDetails();
      },
    );
  }

}