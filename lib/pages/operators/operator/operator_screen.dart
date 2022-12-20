// https://xd.adobe.com/view/52e4e83a-a5a2-4558-a64d-bc8ec69b71e7-07b7/screen/c7a83ddb-502e-4c22-a9c1-9b233768be1d

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/widgets/containers/white_box.dart';
import 'package:unipd_tirocini/widgets/loader.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/btn_primary.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/form_text_field.dart';
import 'package:unipd_tirocini/widgets/unipd_appbar.dart';

import '../../../models/user.dart';
import 'operator_controller.dart';


class OperatorScreen extends StatelessWidget {

  const OperatorScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: IconButton(
                    onPressed:() => context.pop(), 
                    icon: Icon(Icons.arrow_back), 
                    color: AppColors.white),
                ),
              ),
            ],
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 23),
              child: GetBuilder<OperatorController>(
                init: OperatorController(),
                builder: (ctrl) {

                  if(!ctrl.initialized) return const Loader();

                  return WhiteBox(
                    child: Padding( 
                      padding: const EdgeInsets.fromLTRB(60, 50, 60, 70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Text("Nuovo operatore", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black),),
                          
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 17),
                            child: Divider(thickness: 1, color: Color(0xFFD1D1D1),),
                          ),

                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [

                              Expanded(
                                child: LabeledField(
                                  label: "Ruolo", 
                                  child: DropdownButton2<UserType>(
                                    buttonHeight: 40,
                                    buttonDecoration: BoxDecoration(
                                      border: Border.all(color: AppColors.lightText, width:1), //border of dropdown button
                                      borderRadius: BorderRadius.circular(4), 
                                    ),
                                    buttonPadding: EdgeInsets.symmetric(horizontal: 10),
                                    isExpanded: true,
                                    items: [
                                      

                                      DropdownMenuItem(
                                        value: UserType.superadmin,
                                        child: Text('Admins'),
                                      ),

                                      DropdownMenuItem(
                                        value: UserType.organizerTutor,
                                        child: Text('Tutor organizzatore'),
                                      ),
                                      
                                      DropdownMenuItem(
                                        value: UserType.coordinatorTutor,
                                        child: Text('Tutor coordinatore'),
                                      ),

                                      DropdownMenuItem(
                                        value: UserType.administration,
                                        child: Text('Amministrazione'),
                                      ),

                                    ],
                                    value: ctrl.userType,
                                    onChanged: (v){
                                      if(v!=null) ctrl.onRoleChanged(v);
                                    },
                                    underline: const SizedBox(),
                                  )
                                )
                              ),

                              const SizedBox(width: 30,),  

                              Expanded(
                                child: LabeledField(
                                  label: "Amministratore?", 
                                  child: Row(
                                    children: [
                                      ctrl.isAdmin ? Text('Utente amministratore') : Text('NON amministratore'),

                                      Switch(value: ctrl.isAdmin, onChanged: (v){
                                        ctrl.onAdminChanged(context, v);
                                      }),
                                    ],
                                  ),
                                )
                              ),
                              
                            ],
                          ),
                  
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [

                              Expanded(
                                child: LabeledTextField(
                                  ctrl: ctrl.emailCtrl, 
                                  label: "Email istituzionale", 
                                  
                                )
                              ),
                              
                            ],
                          ),

                          const Text('Per permettere ad altri operatori di accedere alla piattaforma, inserire il loro indirizzo email dipendente @unipd.it.\nUna volta inserito, l\'operatore potrà effettuare il login tramite Shibboleth e i suoi dati anagrafici verranno automaticamente importati.'),
                          
                          const SizedBox(height: 40,),              
              
                          Row(
                            children: [
                              const Spacer(),
                              FilledBtn(
                                rounded: true,
                                text: "SALVA", 
                                onPressed: () => ctrl.saveOperator(context),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}