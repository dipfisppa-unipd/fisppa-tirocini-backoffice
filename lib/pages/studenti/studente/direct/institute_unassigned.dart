// https://xd.adobe.com/view/52e4e83a-a5a2-4558-a64d-bc8ec69b71e7-07b7/screen/679eb698-18a6-4c0a-9e5b-81719d83a20f

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/models/td/direct_model.dart';
import 'package:unipd_tirocini/pages/studenti/studente/direct/institute_direct_controller.dart';
import 'package:unipd_tirocini/pages/studenti/studente/student_controller.dart';
import 'package:unipd_tirocini/utils/utils.dart';
import 'package:unipd_tirocini/widgets/containers/white_box.dart';

import '../../../../widgets/ui/atoms/btn_primary.dart';
import '../../../../widgets/ui/atoms/form_text_field.dart';

class InstituteUnassigned extends StatelessWidget {

  final DirectInternship internship;

  const InstituteUnassigned(this.internship, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<InstituteDirectController>(
      init: InstituteDirectController(internship),
      builder: (ctrl) {

        int i = 0;

        if(internship.id==null) return Text('Tirocinio diretto non trovato');

        return WhiteBox(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(60, 50, 60, 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Istituto da assegnare", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                    Text("${internship.calendarYear!-1}/${internship.calendarYear!}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,))
                  ],
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  child: const Divider(),
                ),
  
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            
                            const Text("Preferenze espresse dallo studente", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,)), 
                            
                            const SizedBox(height: 25),
                            
                            SizedBox(
                              height: 500,
                              child: DataTable2(
                                columnSpacing: 12,
                                dataRowHeight: 120,
                                horizontalMargin: 0,
                                minWidth: 100,
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                ),
                                headingRowColor: MaterialStateColor.resolveWith((states) => AppColors.secondary),
                                columns: [
                                  DataColumn2( // index
                                    fixedWidth: 40,
                                    label: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: const Text('n.', style: TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  DataColumn2(
                                    label: const Text('Istituto', style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),  
                                  DataColumn2(
                                    fixedWidth: 140,
                                    label: const SizedBox(),
                                  ),                 
                                  
                                ],
                                rows: [

                                  if(internship.enhancedChoices!=null)
                                  for(var choice in internship.enhancedChoices!)
                                  DataRow2(
                                    color: MaterialStateColor.resolveWith((states) => AppColors.white),
                                    cells: [
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text('${++i}', textAlign: TextAlign.center,),
                                        ),
                                      ),

                                      DataCell(
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Text('${choice[0].name}'),
                                            ),
                                            if(choice.length>1)...[
                                              Padding(
                                                padding: const EdgeInsets.only(top: 16, bottom: 8.0),
                                                child: Text('${choice[1].name}'),
                                              ),
                                            ]
                                          ],
                                        )
                                      ),

                                      DataCell(
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            FilledBtn(text: 'ASSEGNA', onPressed: () => StudentController.to.assignInstitute(context, internship.id!, choice[0])),
                                            if(choice.length>1)...[
                                              const SizedBox(height: 3,),
                                              FilledBtn(text: 'ASSEGNA',  onPressed: () => StudentController.to.assignInstitute(context, internship.id!, choice[1])),
                                            ],
                                            
                                          ],
                                        )
                                        
                                      ),

                                    ],
                                  ),
                                        
                                ],
                              ),
                            ),

                            if(internship.notes.isNotEmpty)...[
                              Text('Note dello studente', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,)), 

                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 36),
                                child: Text(internship.notes),
                              ),
                            ],
                            
                
                          ],
                        ),
                      ),

                      const SizedBox(width: 20,),
                  
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            
                            const Text("Assegnazione operatore", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,)), 
                            
                            const SizedBox(height: 25),
                            
                            SizedBox(
                              height: 250,
                              child: DataTable2(
                                headingRowColor: MaterialStateColor.resolveWith((states) => AppColors.secondary),
                                columnSpacing: 12,
                                horizontalMargin: 0,
                                minWidth: 100,
                                dataRowHeight: 80,
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                ),
                                columns: [

                                  DataColumn2(
                                    fixedWidth: 20,
                                    label: const SizedBox(),
                                  ), 

                                  DataColumn(
                                    label: const Text('Istituto assegnato', style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  
                                  DataColumn2(
                                    fixedWidth: 140,
                                    label: const SizedBox(),
                                  ), 

                                ],
                                rows: [

                                  if(internship.enhancedAssignedChoice!=null)
                                  for(var choice in internship.enhancedAssignedChoice!)
                                  DataRow2(
                                    cells: [

                                      DataCell(const SizedBox(),),

                                      DataCell(Text('${choice.name}')),

                                      DataCell(
                                        OutlinedBtn(
                                          text: 'RIMUOVI', 
                                          onPressed: () => StudentController.to.unassignInstitute(context, internship.id!, choice.code),
                                        )
                                      ),
                                    ],
                                  ),
                                        
                                ],
                              ),
                            ),

                            if(internship.enhancedAssignedChoice!=null && internship.enhancedAssignedChoice!.length>0)
                            FilledBtn(
                              rounded: true,
                              text: internship.enhancedAssignedChoice!.length>1 ? 'CONFERMA LE SCELTE' : 'CONFERMA LA SCELTA',
                              onPressed: () async {
                                
                                Utils.alertBox(context, 
                                  message: 'Sei sicuro di voler confermare?',
                                  buttonText: 'CONFERMA',
                                  onTap: ()=>StudentController.to.confirmInstituteAssignment(context, internship.id!)
                                );
                                
                              },
                            ),
                
                          ],
                        ),
                      ),
                    ],
                  ),
                ), 

                Flexible(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Assegnazione manuale", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: const Divider(),
                            ),
                      
                            const Text('Se vuoi, puoi assegnare un istituto diverso riportando il codice meccanografico qui sotto.'),

                            const SizedBox(height: 16,),
                      
                            LabeledTextField(
                              ctrl: StudentController.to.customInstituteCodeCtrl, 
                              label: "Codice meccanografico istituto", 
                              isReadOnly: false,
                            ),

                            const SizedBox(height: 10,),

                            FilledBtn(
                              rounded: true,
                              onPressed: () => StudentController.to.assignInstituteFromCode(context, internship.id!, ), 
                              text: 'ASSEGNA'
                            ),
                      
                          ],
                        ),
                      ),

                      const SizedBox(width: 20,),

                      Expanded(child: const SizedBox(),),
                    ],
                  ),
                ),
  
  
                const SizedBox(height: 35,),
                
  
                
              ],
            ),
          ),
        );
      }
    );
  }
}