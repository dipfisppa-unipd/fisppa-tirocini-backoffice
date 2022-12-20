import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/utils/utils.dart';
import 'package:unipd_tirocini/widgets/containers/white_box.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/btn_primary.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/form_text_field.dart';
import 'package:unipd_tirocini/widgets/unipd_appbar.dart';

import '../../../../../controllers/generic_data_controller.dart';
import '../../../../../models/user.dart';
import '../../../../../widgets/loader.dart';
import '../../../ti_controller.dart';
import 'group_edit_controller.dart';

class GroupEditScreen extends StatelessWidget {

  final String? gid;

  const GroupEditScreen({this.gid, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupEditController>(
      init: GroupEditController(gid: gid,),
      tag: gid ?? 'new-group',
      builder: (controller) {
        return Scaffold(
          appBar: const UnipdAppBar(),
          backgroundColor: AppColors.background,
          body: Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 23, top: 30),
                    child: Container(
                      height: 50,
                      width: 50,
                      color: AppColors.primary,
                      child: IconButton(onPressed:() => context.pop(), icon: Icon(Icons.arrow_back), color: AppColors.white),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 23),
                  child: WhiteBox(
                    child: SizedBox(
                      height: Get.height,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(61, 38, 40, 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(gid==null ? "Creazione nuovo Gruppo" : 'Modifica Gruppo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black),),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 1),
                                child: Divider(thickness: 1, color: Color(0xFFD1D1D1),),
                              ),
                  
                              Row(
                                children: [
                                  Expanded(
                                    child: LabeledTextField(
                                      ctrl: controller.denominazioneController, 
                                      label: "Denominazione Gruppo", 
                                      hint: "L'anno di fondazione verrà aggiunto in automatico", 
                                    )
                                  ),
                  
                                  const SizedBox(width: 30,),
                  
                                  Expanded(
                                    child: LabeledField(
                                      label: 'Territorialità',
                                      child: GetBuilder<TIController>(
                                        builder: (ctrl) {

                                          return DropdownButton2<String>(
                                            buttonHeight: 40,
                                            buttonWidth: Get.width/2,
                                            buttonDecoration: BoxDecoration(
                                              border: Border.all(color: AppColors.lightText, width:1),
                                              borderRadius: BorderRadius.circular(4), 
                                            ),
                                            buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
                                            isExpanded: true,
                                            items: [
                                    
                                              DropdownMenuItem(
                                                value: '',
                                                child: Text('Seleziona territorialità'),
                                              ),
                                    
                                              for(var t in GenericDataController.to.territorialities)
                                              DropdownMenuItem(
                                                value: t.id,
                                                child: Text(t.label??'n.d.'),
                                              ),
                                    
                                            ],
                                            value: controller.selectedTerritorialityId,
                                            onChanged: (v){
                                              if(v!=null) controller.changeTerritoriality(v);
                                            },
                                            underline: const SizedBox(),
                                          );

                                        }
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 30,),
                                    
                                    Expanded(
                                      child: LabeledField(
                                        label: 'Anno di creazione',
                                        child: TextFormField(
                                          controller: controller.foundationYearCtrl,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                              child: Icon(Icons.today, color: AppColors.iconDefault,),
                                            )
                                          ),
                                          onTap: (){
                                            controller.pickDate(context);
                                          },
                                        ),
                                      ),
                                    )
                                ],
                              ),
                              
                              
                              Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 20),
                                child: Divider(thickness: 1, color: Color(0xFFD1D1D1),),
                              ),

                              if(gid==null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text('E\' necessario indicare i due tutor per la creazione del gruppo. Sarà possibile modificarli in un secondo momento.'),
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: LabeledField(
                                      label: 'Tutor Coordinatore',
                                      child: DropdownButton2<String>(
                                        buttonHeight: 40,
                                        buttonDecoration: BoxDecoration(
                                          border: Border.all(color: AppColors.lightText, width:1), //border of dropdown button
                                          borderRadius: BorderRadius.circular(4), 
                                        ),
                                        buttonPadding: EdgeInsets.symmetric(horizontal: 10),
                                        isExpanded: true,
                                        items: [
                                    
                                          DropdownMenuItem(
                                            value: '',
                                            child: Text('Seleziona tutor'),
                                          ),
                                          
                                          if(controller.coordinatorsTutors!=null)
                                          for(var tutor in controller.coordinatorsTutors!.users!)
                                          DropdownMenuItem(
                                            value: tutor.id,
                                            child: Text(tutor.fullname!='nd' ? tutor.fullname : tutor.email??'nd'),
                                          ),
                                    
                                        ],
                                        value: controller.tutorCoordinatoreId,
                                        onChanged: (v){
                                          if(v!=null) controller.onTutorChanged(UserType.coordinatorTutor, v);
                                        },
                                        underline: const SizedBox(),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 30,),
                      
                                  Expanded(
                                    child: LabeledField(
                                      label: 'Tutor Organizzatore',
                                      child: DropdownButton2<String>(
                                        buttonHeight: 40,
                                        buttonDecoration: BoxDecoration(
                                          border: Border.all(color: AppColors.lightText, width:1), //border of dropdown button
                                          borderRadius: BorderRadius.circular(4), 
                                        ),
                                        buttonPadding: EdgeInsets.symmetric(horizontal: 10),
                                        isExpanded: true,
                                        items: [
                                    
                                          DropdownMenuItem(
                                            value: '',
                                            child: Text('Seleziona tutor'),
                                          ),
                                          
                                          if(controller.organizerTutors!=null)
                                          for(var tutor in controller.organizerTutors!.users!)
                                          DropdownMenuItem(
                                            value: tutor.id,
                                            child: Text(tutor.fullname!='nd' ? tutor.fullname : tutor.email??'nd'),
                                          ),
                                    
                                        ],
                                        value: controller.tutorOrganizzatoreId,
                                        onChanged: (v){
                                          if(v!=null) controller.onTutorChanged(UserType.organizerTutor, v);
                                        },
                                        underline: const SizedBox(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20,),

                              LabeledTextField(
                                ctrl: controller.notesGroupCtrl, 
                                label: "Note", 
                                minLines: 4,
                              ),
                  
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FilledBtn(
                                    rounded: true,
                                    text: "SALVA", 
                                    onPressed: () async {
                                      var res = await controller.onSaveGroup();
                                      if(res!=null){
                                        Utils.showToast(context: context, text: 'Gruppo salvato');
                                        TIController.to.reload();

                                        if(gid==null)
                                          context.goNamed('edit-gruppo', params: {'gid': res});
                                        
                                      }else{
                                        Utils.showToast(context: context, isError: true, text: 'Errore nel salvataggio del gruppo');
                                      }
                                    }
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}