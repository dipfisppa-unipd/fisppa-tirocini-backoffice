import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/models/enums/student_sections.dart';
import 'package:unipd_tirocini/pages/studenti/studente/anagrafica/student_registry.dart';
import 'package:unipd_tirocini/pages/studenti/studente/carriera/student_career_screen.dart';
import 'package:unipd_tirocini/pages/studenti/studente/student_controller.dart';
import 'package:unipd_tirocini/pages/studenti/studente/valutazioni/valutazioni.dart';
import 'package:unipd_tirocini/widgets/containers/details_screen_shell.dart';
import 'package:unipd_tirocini/widgets/loader.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/data_box.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/navigation_button.dart';

import 'direct/student_direct_internship.dart';
import 'indirect/student_indirect_internship.dart';


class StudentDetailsScreen extends StatelessWidget {

  final String sid;
  const StudentDetailsScreen({required this.sid, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentController>(
        init: StudentController(sid: sid),
        builder: (ctrl) {

          if(ctrl.isLoading)
            return Scaffold(
              body: LoaderPro('Caricamento studente... '),
            );

          if(ctrl.student==null){
            return Scaffold(
              body: Center(child: Text('Studente non trovato')),
            );
          }

          return DetailsScreenShell(
              dataBox: DataBox(
                title: ctrl.student!.fullname, 
                data: [
                  DataBoxRow(label: "Matricola studente", content: ctrl.student!.university!.studentNumber!),
                  DataBoxRow(label: "Crediti universitari", content: ctrl.student!.university!.credits.toString()),
                  DataBoxRow(label: "Annualità tirocinio", content: ctrl.student!.getInternshipYear().toString()), 
                  DataBoxRow(label: "Gruppo tirocinio", content: ctrl.student!.getConfirmedIndirect(getLast: true)), 
                  DataBoxRow(label: "Istituto tirocinio", content: ctrl.student!.getConfirmedDirect(getLast: true), skipLastDivider: true,), 
                ],
                actions: [
                  NavigationButton(text: "Anagrafica", 
                    onTap: (){ ctrl.changeSection(StudentSections.anagrafica);}, 
                    isActive: ctrl.section == StudentSections.anagrafica ? true : false),
                  
                  NavigationButton(text: "Carriera", 
                    onTap: (){ ctrl.changeSection(StudentSections.carriera);}, 
                    isActive: ctrl.section == StudentSections.carriera ? true : false),
                 
                  NavigationButton(text: "Tirocinio Indiretto", 
                    onTap: (){ ctrl.changeSection(StudentSections.tirocinio_indiretto);}, 
                    isActive: ctrl.section == StudentSections.tirocinio_indiretto ? true : false),

                  NavigationButton(text: "Tirocinio Diretto", 
                    onTap: (){ ctrl.changeSection(StudentSections.tirocinio_diretto);}, 
                    isActive: ctrl.section == StudentSections.tirocinio_diretto ? true : false),
                  
                  NavigationButton(text: "Valutazioni", 
                    onTap: (){ ctrl.changeSection(StudentSections.valutazioni);}, 
                    isActive: ctrl.section == StudentSections.valutazioni ? true : false),
                ],
              ),
              
              content: LayoutBuilder(
                builder: (_, __) {
                  
                  switch (ctrl.section) {
                    case StudentSections.anagrafica :
                      return StudentRegistry();
                    case StudentSections.carriera :
                        return StudentCareer();
                    case StudentSections.tirocinio_diretto :
                      return StudentDirect();
                    case StudentSections.tirocinio_indiretto :
                        return StudentIndirect();
                    case StudentSections.valutazioni :
                        return Valutazioni();
                    default: return StudentRegistry();
                  }
                } 
              ),
          );
        }

    
    );
  }
}

