import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/pages/studenti/studente/indirect/group_assigned.dart';
import 'package:unipd_tirocini/pages/studenti/studente/indirect/group_unassigned.dart';
import 'package:unipd_tirocini/pages/studenti/studente/student_controller.dart';
import 'package:unipd_tirocini/widgets/loader.dart';
import 'package:unipd_tirocini/widgets/ui/empty_data_box.dart';


class StudentIndirect extends StatelessWidget {
  const StudentIndirect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentController>(
      builder: (ctrl){

        if(ctrl.isLoading) 
          return Loader();

        if(ctrl.student==null) 
          return const EmptyDataBox('Studente non trovato',);

        if(!ctrl.studentHasIndirects)
          return const EmptyDataBox('Non sono presenti tirocini indiretti',);


        return Container(
          height: Get.height,
          width: Get.width,
          child: CustomScrollView(
            slivers: [

              if(ctrl.student!.indirectInternships.length>0)
              for(var i in ctrl.student!.indirectInternships)
                SliverToBoxAdapter(
                  child: !i.isAssignedChoiceConfirmed 
                    ? GroupUnassigned(i.id!) : GroupAssigned(i),
                ),

            ],
          ),
        );

      },
    );
  }
}