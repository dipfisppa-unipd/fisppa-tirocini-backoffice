import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/app/app_styles.dart';
import 'package:unipd_tirocini/pages/studenti/studente/student_controller.dart';
import 'package:unipd_tirocini/widgets/containers/white_box.dart';
import 'package:unipd_tirocini/widgets/loader.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/btn_primary.dart';

import '../../../../models/ti/indirect_model.dart';
import '../../../../widgets/ui/contacts.dart';
import 'group_indirect_controller.dart';


class GroupAssigned extends StatelessWidget {

  final IndirectInternship indirect;

  GroupAssigned(this.indirect, {Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupIndirectController>(
      init: GroupIndirectController(indirect),
      tag: indirect.id!,
      builder: (ctrl) {

        var internship = ctrl.indirect;

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
                    Text("Tirocinio Indiretto", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                    Text("${internship.calendarYear!-1}/${internship.calendarYear!}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  child: Divider(),
                ),
  
                Text("Gruppo assegnato allo studente", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  color: Color(0xFFF9FAFB),
                  height: 50,
                  child: Row( 
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${internship.enhancedAssignedChoice?.name} ${internship.enhancedAssignedChoice?.foundationYear}', style: TextStyle(fontSize: 14)),
                      ),
                      Spacer(),
                      Container(
                        height: 50, 
                        child: FilledBtn(text: "MODIFICA GRUPPO", 
                        onPressed: () async {
                            Get.find<StudentController>().confirmGroupAssignment(context, internship.id!, internship.enhancedAssignedChoice!.id!, confirm: false);
                          }
                        ),
                      )
                      
                    ],
                  ),
                ), 
                const SizedBox(height: 45,),

                if(ctrl.isLoadingGroupDetails)
                  Loader(),
                
                Text("Tutors", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black),),

                if(!ctrl.isLoadingGroupDetails && ctrl.group==null)
                  Text('Errore durante il recupero dei dati sul gruppo di tirocinio'),

                if(!ctrl.isLoadingGroupDetails && ctrl.group!=null)...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Divider(thickness: 1, color: Color(0xFFD1D1D1),),
                  ),

                  const SizedBox(height: 25,),
          
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Text("Tutor Coordinatore", style: TextStyle(fontWeight: FontWeight.bold))),
                            Expanded(child: Text('${ctrl.group?.coordinatorTutor?.fullname}')),
                          ],
                        )
                      ),
          
                      const SizedBox(width: 25,),
          
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Text("Contatti", style: TextStyle(fontWeight: FontWeight.bold))),
                            Expanded(
                              child: Contacts(
                                email: ctrl.group?.coordinatorTutor?.email, 
                                phoneNumber: ctrl.group?.coordinatorTutor?.registry?.cellNumber,
                              ),
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 25,),
          
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Text("Tutor Organizzatore", style: TextStyle(fontWeight: FontWeight.bold))),
                            Expanded(child: Text('${ctrl.group?.organizerTutor?.fullname ?? 'nd'}')),
                          ],
                        )
                      ),
          
                      const SizedBox(width: 25,),
          
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Text("Contatti", style: TextStyle(fontWeight: FontWeight.bold))),
                            Expanded(
                              child: Contacts(
                                email: ctrl.group?.organizerTutor?.email, 
                                phoneNumber: ctrl.group?.organizerTutor?.registry?.cellNumber,
                              ),
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                ],
                           
                const SizedBox(height: 45,),
  
                const Text("Valutazioni", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                const Divider(),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Approvazione progetto", style: TextStyle(fontWeight: FontWeight.bold),),

                      const SizedBox(width: 50),

                      Flexible(
                        child: ListTile(
                          title: Text("Sì"),
                          leading: Radio(
                            value: true,
                            groupValue: ctrl.isProjectApproved,
                            onChanged: (v){
                              ctrl.toggleProjectApproved();
                            },
                            activeColor: Color(0xFF868AA8)
                          ),
                        ),
                      ),

                      Flexible(
                        child: ListTile(
                          title: Text("No"),
                          leading: Radio(
                            value: false,
                            groupValue: ctrl.isProjectApproved,
                            onChanged: (v){
                              ctrl.toggleProjectApproved();
                            },
                            activeColor: Color(0xFF868AA8)
                          ),
                        ),
                      ),
                    ],
                  
                ),

                const SizedBox(height: 20,),

                Padding(
                padding: const EdgeInsets.only(bottom: 15, top: 40),
                  child: Text("Valutazione", style: AppStyles.textFieldLabel,),
                ),
  
                TextField(
                  controller: ctrl.valutazioneController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.lightText, width: 1),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    hintText: "Valutazione",
                    hintStyle: AppStyles.textFieldHint
                  ),
                  onChanged: (value) => {},
                ), 

                const SizedBox(height: 30,),

                Obx(()=>Text("Votazione: ${ctrl.voteLabel[ctrl.evaluation()]}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,)),),
                
                const SizedBox(height: 15,),
                
                Row(
                  children: [
                    Expanded(
                      flex: 1, 
                      child: SliderTheme(
                        data: SliderThemeData(
                          showValueIndicator: ShowValueIndicator.always,
                          activeTrackColor: AppColors.secondary,
                          inactiveTrackColor: AppColors.secondary, 
                          inactiveTickMarkColor: AppColors.black, 
                          activeTickMarkColor: AppColors.black,
                          valueIndicatorColor: AppColors.black,
                        ),
                        child: Obx(()=>Slider(
                          value: ctrl.evaluation().toDouble(), 
                          onChanged: (v){
                            ctrl.editVote(v);
                          }, 
                          divisions: 3, 
                          min: 0, 
                          max: 3,
                          label: ctrl.voteLabel[ctrl.evaluation()],
                        ),),
                      )),
                    
                    Expanded(flex: 2, child: const SizedBox()),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FilledBtn(
                        rounded: true,
                        onPressed: () => ctrl.onSave(context),
                        text: 'SALVA',
                      ),
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