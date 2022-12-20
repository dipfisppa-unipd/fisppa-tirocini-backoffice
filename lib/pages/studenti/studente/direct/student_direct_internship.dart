import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/pages/studenti/studente/student_controller.dart';
import 'package:unipd_tirocini/widgets/loader.dart';

import '../../../../widgets/ui/empty_data_box.dart';
import 'institute_assigned.dart';
import 'institute_unassigned.dart';


class StudentDirect extends StatelessWidget {
  const StudentDirect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentController>(
      builder: (ctrl){

        if(ctrl.isLoading) 
          return const Loader();

        if(ctrl.student==null) 
          return const EmptyDataBox('Studente non trovato',);

        if(!ctrl.studentHasDirects)
          return const EmptyDataBox('Non sono presenti tirocini diretti',);


        return Container(
          height: Get.height,
          width: Get.width,
          child: CustomScrollView(
            slivers: [

              for(var i in ctrl.student!.directInternships)
                SliverToBoxAdapter(
                  child: !i.isAssignedChoiceConfirmed 
                    ? InstituteUnassigned(i) : InstituteAssigned(i),
                ),

            ],
          ),
        );

      },
    );
  }
}