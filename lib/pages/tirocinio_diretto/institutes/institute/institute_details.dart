// https://xd.adobe.com/view/52e4e83a-a5a2-4558-a64d-bc8ec69b71e7-07b7/screen/f7198d77-490c-4053-867c-84e99bc54bf1

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/pages/tirocinio_diretto/institutes/institute/institute_students_list.dart';
import 'package:unipd_tirocini/widgets/containers/details_screen_shell.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/data_box.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/navigation_button.dart';

import '../../../../widgets/loader.dart';
import 'institute_controller.dart';
import 'institute_info.dart';

class InstituteDetails extends StatelessWidget {

  const InstituteDetails({required this.code,  Key? key }) : super(key: key);

  final String code;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstituteController>(
      init: InstituteController(iid: code.isEmpty ? null : code),
      builder: (ctrl) {

        if(ctrl.isLoading) 
          return Scaffold(body: LoaderPro('Caricamento istituto...'));

        if(!ctrl.isNewInstitute && ctrl.institute==null)
          return Scaffold(body: Center(child: Text('Istituto non trovato')));
        
        var institute = ctrl.institute!;

        return DetailsScreenShell(
          dataBox: DataBox(
            title: institute.name.isEmpty ? 'Nuovo istituto' : institute.name,  
            data: [
              DataBoxRow(label: "Codice Meccanografico", content: institute.code), 
              DataBoxRow(label: "Ist. Riferimento", content: institute.referenceInstituteName), 
              DataBoxRow(label: "Tipologia", content: institute.educationDegree), 
              DataBoxRow(label: "Città", content: '${institute.city} (${institute.province})'), 
              DataBoxRow(label: "Indirizzo", content: '${institute.address} ${institute.cap}'), 
              DataBoxRow(label: "Scadenza Convenzione", content: institute.conventionEnds()), 
            ], 
            
            actions: [
              if(!ctrl.isNewInstitute)
                NavigationButton(text: "Studenti", onTap: (){
                  ctrl.toggleShowStudentList();
                }, isActive: ctrl.showStudentsList),

              NavigationButton(text: "Dati", onTap: (){
                ctrl.toggleShowStudentList();
              }, isActive: !ctrl.showStudentsList),
            ],
          ),

          content: ctrl.showStudentsList ? InstituteStudentsList() : InstituteInfo(),
        );
      }
    );
  }
}