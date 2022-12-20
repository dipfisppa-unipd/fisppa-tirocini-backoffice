import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/app/app_styles.dart';
import 'package:unipd_tirocini/controllers/generic_data_controller.dart';
import 'package:unipd_tirocini/pages/tirocinio_indiretto/gruppi/gruppo/group_controller.dart';
import 'package:unipd_tirocini/utils/utils.dart';
import 'package:unipd_tirocini/widgets/unipd_appbar.dart';
import 'package:unipd_tirocini/widgets/containers/white_box.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/btn_primary.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/data_box.dart';

import '../../../../widgets/form/year_selection_dropdown.dart';
import '../../../../widgets/loader.dart';
import '../../../../widgets/ui/job_erasmus.dart';

class GroupDetailsScreen extends StatelessWidget {

  final String gid;
  final int internshipYear;

  GroupDetailsScreen({
    required this.gid, 
    required this.internshipYear, 
    Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const UnipdAppBar(),
      body: GetBuilder<GroupController>(
        init: GroupController(gid: gid, internshipYear: internshipYear),
        builder: (ctrl) {
          int count = 0;

          return SizedBox(
            height: Get.height,
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 15, 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  SizedBox(
                    width: 500,
                    child: ctrl.group!=null ? DataBox(
                      title: "Gruppo ${ctrl.group!.name}", 
                      editButton: IconButton(
                        icon: Icon(Icons.edit, color: AppColors.onPrimary,),
                        onPressed: (){
                          context.goNamed('edit-gruppo', params: {'gid': gid,});
                        }, 
                      ),
                      data: [

                        DataBoxRow(label: "Denominazione", content: ctrl.group!.name!), 
                        DataBoxRow(label: "Anno Tirocinio", content: "$internshipYear"), 
                        DataBoxRow(label: "Anno Fondazione", content: "${ctrl.group!.foundationYear}"), 
                        DataBoxRow(label: "Territorialità", content: GenericDataController.to.getTerritoriality(ctrl.group!.territorialityId!)), 
                        DataBoxRow(label: "Numero Iscritti", content: '${ctrl.countInternshipSubscriptions()}',),
                      ], 
                      actions: [

                        Container(
                          height: 65,
                          width: 500,
                          color: AppColors.primary,
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Text('Informazioni Tutors', style: AppStyles.primaryButton.copyWith(fontSize: 16),),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(28, 30, 23, 0),
                          child: DataBoxRow(
                            label: 'Tutor coordinatore', 
                            content: ctrl.coordinatorTutor,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(28, 0, 23, 0),
                          child: DataBoxRow(
                            label: 'Tutor organizzatore', 
                            content: ctrl.organizerTutor,
                          ),
                        ),


                      ],
                    ) : const Loader(),
                  ),

                  const SizedBox(width: 30),

                  if(ctrl.group!=null)
                  Expanded(
                    child: WhiteBox(
                      child: SizedBox(
                        height: Get.height,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50, 50, 60, 70),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [

                              Row(
                                children: [
                                  const Text("Elenco Iscritti", style: TextStyle(fontSize: 20, color: AppColors.black, fontWeight: FontWeight.bold,)),
                                  const Spacer(),
                                  const Text("Anno di tirocinio",),
                                  const SizedBox(width: 20),
                                  YearSelectionDropdown(
                                    showAll: false,
                                    isFive: false,
                                    value: ctrl.internshipYear, 
                                    onChanged: (v)=>ctrl.changeInternshipYear(v),
                                  ),
                                ],
                              ),
                              
                              const Divider(),
                        
                              Row( 
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text("Totale iscritti: ${ctrl.countInternshipSubscriptions()}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,))
                                  ),

                                  IconButton(
                                    icon: const Icon(Icons.replay_circle_filled_outlined, color: AppColors.iconDefault,),
                                    onPressed: () => ctrl.getGroupDetails(),
                                    
                                  ),

                                  BtnPrimary(
                                    text: "SCARICA DATI", 
                                    onTap: (){
                                      Utils.showToast(context: context, isWarning: true, text: 'Non disponibile');
                                    }
                                  )
                                  
                                ],
                              ), 
                        
                              const SizedBox(height: 40,),
                        
                              Flexible(
                                child: DataTable2(
                                  columnSpacing: 12,
                                  horizontalMargin: 12,
                                  minWidth: 600,
                                  dataRowHeight: 60,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary,
                                  ),
                                  columns: [
                                    DataColumn2(
                                      fixedWidth: 40,
                                      label: const SizedBox(),
                                    ),
                                    DataColumn2(
                                      size: ColumnSize.M,
                                      label: const Text('Cognome Nome', style: TextStyle(fontWeight: FontWeight.bold),),
                                    ),
                                    DataColumn(
                                      label: const Text('Domicilio', style: TextStyle(fontWeight: FontWeight.bold),),
                                    ),
                                    DataColumn(
                                      label: const Text('Lavoro Erasmus', style: TextStyle(fontWeight: FontWeight.bold),),
                                    ),
                                    DataColumn(
                                      label: const Text('Assegnazione', style: TextStyle(fontWeight: FontWeight.bold),),
                                    ),
                                    
                                  ],
                                  rows: [

                                    if(ctrl.group!.indirectInternships!=null)
                                    for(var internship in ctrl.group!.indirectInternships!)
                                    DataRow2(
                                      color: MaterialStateColor.resolveWith((states) => ctrl.group!.indirectInternships!.indexOf(internship) % 2 == 1 ? AppColors.secondary : Colors.white),
                                      onTap: () {
                                        if(internship.enhancedUser!=null)
                                        context.pushNamed('studente', params: {'sid': internship.enhancedUser!.id!});
                                      },
                                      cells: [

                                          DataCell(Text('${++count}'),),

                                          DataCell(Text('${internship.enhancedUser?.fullname}'),),

                                          DataCell(Text('${internship.enhancedUser?.fullDomicile}'),),

                                          DataCell(
                                            JobErasmus(
                                              iconSize: 18,
                                              inErasmus: internship.enhancedUser?.isInErasmus(calendarYear: ctrl.group!.foundationYear + ctrl.internshipYear) ?? false,
                                              hasJob: internship.enhancedUser?.isWorking(calendarYear: ctrl.group!.foundationYear + ctrl.internshipYear) ?? '',
                                            ),
                                            
                                          ),

                                          // L'assegnazione deve avvenire dalla scheda studente perché solo li sappiamo l'ordine della sua preferenza per
                                          // la territorialità
                                          // if(!internship.isAssignedChoiceConfirmed && internship.assignedChoice!=null && internship.assignedChoice!.isEmpty)
                                          // DataCell(
                                          //   OutlinedBtn(text: 'ASSEGNA', onPressed: () => ctrl.assignGroup(context, internship.id!, ctrl.group!.id!),),
                                          // ),
                                          if(!internship.isAssignedChoiceConfirmed)
                                          DataCell(
                                            FilledBtn(text: 'CONFERMA', onPressed: () => ctrl.confirmGroupAssignment(context, internship.id!,),)
                                          ),
                                          if(internship.isAssignedChoiceConfirmed)
                                          DataCell(
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                              child: Text('CONFERMATO'),
                                            ),
                                          ),
                                          

                                      ]
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      
                    ),
                  ),

                ],
              ),
            ),
          );
        }
      ),
    );
  }
}