import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/models/td/direct_model.dart';
import 'package:unipd_tirocini/pages/studenti/studente/student_controller.dart';
import 'package:unipd_tirocini/widgets/containers/white_box.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/btn_primary.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/form_text_field.dart';

import '../../../../utils/utils.dart';
import 'institute_direct_controller.dart';


class InstituteAssigned extends StatelessWidget {

  final DirectInternship internship;

  InstituteAssigned(this.internship, {Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstituteDirectController>(
      init: InstituteDirectController(internship),
      builder: (ctrl) {

        if(internship.id==null || !internship.isAssignedChoiceConfirmed) 
          return Center(child: Text('Tirocinio diretto non trovato o  non confermato'));

        if(internship.assignedChoice.isEmpty)
          return Center(child: Text('Mancano i dati del tirocinio diretto'));

        return WhiteBox(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(60, 50, 60, 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Tirocinio Diretto", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                    Text("${internship.calendarYear!-1}/${internship.calendarYear!}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  child: const Divider(),
                ),
  
                const Text("Istituto/i assegnato/i allo studente", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  color: Color(0xFFF9FAFB),
                  child: Row( 
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: (){
                                      GoRouter.of(context).push('/istituti/istituto/${internship.enhancedAssignedChoice?.first.code}');
                                    },
                                    icon: Icon(Icons.link),
                                  ),
                                  Text('${internship.enhancedAssignedChoice?.first.name}', style: TextStyle(fontSize: 14)),
                                ],
                              ),
                            ),
                            if(internship.enhancedAssignedChoice!=null && internship.enhancedAssignedChoice!.length>1)
                            Row(
                              children: [
                                IconButton(
                                  onPressed: (){
                                    GoRouter.of(context).push('/istituti/istituto/${internship.enhancedAssignedChoice?.last.code}');
                                  },
                                  icon: Icon(Icons.link),
                                ),
                                Text('${internship.enhancedAssignedChoice?.elementAt(1).name}', style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      const Spacer(),
                      
                      FilledBtn(
                        text: "MODIFICA ISTITUTI", 
                        onPressed: () async {
                          Utils.alertBox(
                            context,
                            buttonText: 'CONTINUA',
                            message: 'Modificando la scelta dell\'istituto, eventuali dati del tutor scolastico verranno rimossi. Continuare?',
                            onTap: () => Get.find<StudentController>().confirmInstituteAssignment(context, internship.id!, confirm: false),
                          );
                        },
                      )
                      
                    ],
                  ),
                ),

                // TUTOR 1 (in caso di 2 scuole assegnate, lo studente avrà fino a un max di 2 tutor) 
                const SizedBox(height: 35,),
  
                Text('Tutor ${internship.enhancedAssignedChoice?.first.name} - ${internship.enhancedAssignedChoice?.first.schoolDegree()}', 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: const Divider(thickness: 1, color: Color(0xFFD1D1D1),),
                ),

                const SizedBox(height: 20,),

                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: LabeledTextField(
                          label: 'Codice meccanografico scuola',
                          hint: 'Indicare qui la scuola dove viene effettivamente svolto il tirocinio',
                          ctrl: ctrl.tutorSchoolCodeCtrl,
                          withLink: ctrl.tutorSchoolCodeCtrl.text.isNotEmpty
                          ? '/istituti/istituto/${ctrl.tutorSchoolCodeCtrl.text}' : null,
                        )
                      ),
                      const SizedBox(width: 20,),
                      Flexible(
                        child: LabeledField(
                          label: 'Ordine scuola',
                          child: Row(
                            children: [
                              ctrl.tutorOrder ? Text('Primaria') : Text('Infanzia'),
                              Switch(value: ctrl.tutorOrder, onChanged: ctrl.onTutorOrderChanged),
                            ],
                          ),
                        )
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20,),
        
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: LabeledTextField(
                        label: 'Nome',
                        ctrl: ctrl.tutorNameCtrl,
                      )
                    ),
                    const SizedBox(width: 20,),
                    Flexible(
                      child: LabeledTextField(
                        label: 'Cognome',
                        ctrl: ctrl.tutorSurnameCtrl,
                      )
                    ),
                  ],
                ),
                
                const SizedBox(height: 10,),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: LabeledTextField(
                        label: 'Telefono',
                        ctrl: ctrl.tutorPhoneCtrl,
                      )
                    ),
                    const SizedBox(width: 20,),
                    Flexible(
                      child: LabeledTextField(
                        label: 'Email',
                        ctrl: ctrl.tutorEmailCtrl,
                      )
                    ),
                  ],
                ),

                const SizedBox(height: 10,),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: LabeledTextField(
                        label: 'Note, orari disponibilità',
                        ctrl: ctrl.tutorNotesCtrl,
                      )
                    ),
                  ],
                ),

                // TUTOR 2 (potrebbe non esserci)
                if(internship.enhancedAssignedChoice!.length==2) ...[
                  const SizedBox(height: 35,),
  
                  Text('Tutor ${internship.enhancedAssignedChoice?.last.name} - ${internship.enhancedAssignedChoice?.last.schoolDegree()}', 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: const Divider(thickness: 1, color: Color(0xFFD1D1D1),),
                  ),

                  const SizedBox(height: 20,),
          
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: LabeledTextField(
                          label: 'Codice meccanografico scuola',
                          hint: 'Indicare qui la scuola dove viene effettivamente svolto il tirocinio',
                          ctrl: ctrl.tutor2SchoolCodeCtrl,
                          withLink: ctrl.tutor2SchoolCodeCtrl.text.isNotEmpty
                          ? '/istituti/istituto/${ctrl.tutor2SchoolCodeCtrl.text}' : null,
                        )
                      ),
                      const SizedBox(width: 20,),
                      Flexible(
                        child: LabeledField(
                          label: 'Ordine scuola',
                          child: Row(
                            children: [
                              ctrl.tutor2order ? const Text('Primaria') : const Text('Infanzia'),
                              Switch(value: ctrl.tutor2order, onChanged: ctrl.onTutor2orderChanged),
                            ],
                          ),
                        )
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20,),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: LabeledTextField(
                          label: 'Nome',
                          ctrl: ctrl.tutor2NameCtrl,
                        )
                      ),
                      const SizedBox(width: 20,),
                      Flexible(
                        child: LabeledTextField(
                          label: 'Cognome',
                          ctrl: ctrl.tutor2SurnameCtrl,
                        )
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 10,),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: LabeledTextField(
                          label: 'Telefono',
                          ctrl: ctrl.tutor2PhoneCtrl,
                        )
                      ),
                      const SizedBox(width: 20,),
                      Flexible(
                        child: LabeledTextField(
                          label: 'Email',
                          ctrl: ctrl.tutor2EmailCtrl,
                        )
                      ),
                    ],
                  ),

                  const SizedBox(height: 10,),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: LabeledTextField(
                          label: 'Note, orari disponibilità',
                          ctrl: ctrl.tutor2NotesCtrl,
                        )
                      ),
                    ],
                  ),
                ],
                
        
                

                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FilledBtn(
                        rounded: true,
                        text: "SALVA", 
                        onPressed: () => ctrl.patchInstituteTutor(context),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}