// https://xd.adobe.com/view/52e4e83a-a5a2-4558-a64d-bc8ec69b71e7-07b7/screen/ebb12a5c-a830-48a5-9215-3200ca3663f0

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/controllers/generic_data_controller.dart';
import 'package:unipd_tirocini/pages/studenti/studente/student_controller.dart';
import 'package:unipd_tirocini/widgets/containers/white_box.dart';

import '../../../../widgets/ui/atoms/btn_primary.dart';

class GroupUnassigned extends StatelessWidget {

  final String id;

  const GroupUnassigned(this.id, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<StudentController>(
      builder: (ctrl) {

        var internship = ctrl.student!.indirectInternships.firstWhereOrNull((element) => element.id==id);
        int i = 0;

        if(internship==null) return Text('Tirocinio non trovato');

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
                    const Text("Gruppo da assegnare", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
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
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            
                            const Text("Preferenze espresse dallo studente", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,)), 
                            
                            const SizedBox(height: 25),
                            
                            SizedBox(
                              height: 300,
                              child: DataTable2(
                                columnSpacing: 12,
                                horizontalMargin: 12,
                                minWidth: 100,
                                dataRowHeight: 60,
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                ),
                                headingRowColor: MaterialStateColor.resolveWith((states) => AppColors.secondary),
                                columns: [
                                  DataColumn2( // index
                                    fixedWidth: 40,
                                    label: const Text('n.', style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  DataColumn2(
                                    label: const Text('Territorialità', style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),                 
                                  
                                ],
                                rows: [

                                  for(var choice in internship.enhancedChoices!)
                                  DataRow2(
                                    color: MaterialStateColor.resolveWith((states) => AppColors.white),
                                    cells: [
                                      DataCell(
                                        Text('${++i}', textAlign: TextAlign.center,),
                                      ),

                                      DataCell(
                                        Text(choice.label!),
                                      ),

                                    ],
                                  ),
                                        
                                ],
                              ),
                            ),

                            if(internship.notes.isNotEmpty)...[
                              Text('Note dello studente', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,)), 

                              Text(internship.notes),
                            ],
                            
                
                          ],
                        ),
                      ),

                      const SizedBox(width: 20,),
                  
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            
                            const Text("Gruppi disponibili", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,)), 
                            
                            const SizedBox(height: 25),
                            
                            SizedBox(
                              height: 500,
                              child: DataTable2(
                                headingRowColor: MaterialStateColor.resolveWith((states) => AppColors.secondary),
                                columnSpacing: 12,
                                horizontalMargin: 12,
                                minWidth: 100,
                                dataRowHeight: 60,
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                ),
                                columns: [
                                  DataColumn(
                                    label: const Text('Denominazione', style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  DataColumn(
                                    label: const Text('Territorialità', style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  DataColumn2(
                                    fixedWidth: 50, 
                                    label: const Text('Posti', style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  DataColumn2( // assign/confirm button
                                    fixedWidth: 140,
                                    label: const SizedBox(),
                                  ),

                                  DataColumn2( // delete
                                    fixedWidth: 60,
                                    label: const SizedBox(),
                                  ),

                                ],
                                rows: [

                                  for(var g in ctrl.groups)
                                  DataRow2(
                                    cells: [
                                      DataCell(Text('${g.name} ${g.foundationYear}')),

                                      DataCell(Text(GenericDataController.to.getTerritoriality(g.territorialityId!))),

                                      DataCell(Text('${g.numOfStudents}')),

                                      DataCell(
                                        g.id==internship.assignedChoice 
                                        ? FilledBtn(text: 'CONFERMA', onPressed: () => ctrl.confirmGroupAssignment(context, internship.id!, g.id!),)
                                        : OutlinedBtn(text: 'ASSEGNA', onPressed: () => ctrl.assignGroup(context, internship.id!, g.id!),),
                                      ),

                                      DataCell(
                                        
                                        SizedBox(
                                          height: 58, width: 58,
                                          child: g.id==internship.assignedChoice ? FilledBtnIcon(
                                            icon: Icon(Icons.delete, color: AppColors.white, size: 22,),
                                            onPressed: () => ctrl.unassignGroup(context, internship.id!, g.id!),
                                          ) : null,
                                        )
                                      ),

                                    ],
                                  ),
                                        
                                ],
                              ),
                            ),
                
                          ],
                        ),
                      ),
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