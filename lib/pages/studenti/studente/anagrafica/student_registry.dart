import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/app/app_styles.dart';
import 'package:unipd_tirocini/pages/studenti/studente/student_controller.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/form_text_field.dart';
import 'package:unipd_tirocini/widgets/containers/white_box.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/btn_primary.dart';


class StudentRegistry extends StatelessWidget {

  StudentRegistry({Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentController>(
      builder: (ctrl) {
        return WhiteBox(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(60, 50, 60, 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Dati Anagrafici", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black),),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Modifica dati', style: AppStyles.textFieldLabel),
                      ),
                      Switch(value: !ctrl.isReadOnly, onChanged: (v)=>ctrl.toggleReadOnly(),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: const Divider(thickness: 1, color: Color(0xFFD1D1D1),),
                  ),
          
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.nomeCtrl, 
                          label: "Nome", 
                          isReadOnly: ctrl.isReadOnly,
                        )
                      ),
          
                      const SizedBox(width: 48,),
          
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.cognomeCtrl, 
                          label: "Cognome", 
                          isReadOnly: ctrl.isReadOnly,
                          
                        )
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 40,),
          
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Expanded(
                      //   child: LabeledTextField(
                      //     ctrl: ctrl.corsoDiLaureaCtrl, 
                      //     label: "Corso di Laurea", 
                      //     hint: "Scienze della Formazione Primaria", 
                      //     isReadOnly: ctrl.isReadOnly,
                      //   )
                      // ),
          
                      // const SizedBox(width: 48,),
          
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.matricolaCtrl, 
                          label: "Matricola", 
                          isReadOnly: true,
                          withCopyButton: true,
                          hint: ctrl.isReadOnly ? '' : 'Non modificabile',
                        )
                      ),

                      const SizedBox(width: 48,),
          
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.earnedCreditsCtrl, 
                          label: "Crediti", 
                          isReadOnly: ctrl.isReadOnly,
                          
                        )
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 30,),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                    mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Anno di Tirocinio", style: AppStyles.textFieldLabel),
                              Row(
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        title: Text("1"),
                                        leading: Radio(
                                          value: 1,
                                          groupValue: ctrl.annoDiTirocinio,
                                          onChanged: null,
                                          activeColor: Color(0xFF868AA8)
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Text("2"),
                                        leading: Radio(
                                          value: 2,
                                          groupValue: ctrl.annoDiTirocinio,
                                          onChanged: null,
                                          activeColor: Color(0xFF868AA8)
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Text("3"),
                                        leading: Radio(
                                          value: 3,
                                          groupValue: ctrl.annoDiTirocinio,
                                          onChanged: null,
                                          activeColor: Color(0xFF868AA8)
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Text("4"),
                                        leading: Radio(
                                          value: 4,
                                          groupValue: ctrl.annoDiTirocinio,
                                          onChanged: null,
                                          activeColor: Color(0xFF868AA8)
                                        ),
                                      )
                                    ),
                                    const Spacer()
                                  ],
                                
                              )
                            ],
                          )
                        ), 
        
                        const SizedBox(width: 48,),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Anno di corso", style: AppStyles.textFieldLabel),
                              Row(
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        title: Text("1"),
                                        leading: Radio(
                                          value: 1,
                                          groupValue: ctrl.annoDiCorso,
                                          onChanged: null,
                                          activeColor: Color(0xFF868AA8)
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Text("2"),
                                        leading: Radio(
                                          value: 2,
                                          groupValue: ctrl.annoDiCorso,
                                          onChanged: null,
                                          activeColor: Color(0xFF868AA8)
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Text("3"),
                                        leading: Radio(
                                          value: 3,
                                          groupValue: ctrl.annoDiCorso,
                                          onChanged: null,
                                          activeColor: Color(0xFF868AA8)
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Text("4"),
                                        leading: Radio(
                                          value: 4,
                                          groupValue: ctrl.annoDiCorso,
                                          onChanged: null,
                                          activeColor: Color(0xFF868AA8)
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Text("5"),
                                        leading: Radio(
                                          value: 5,
                                          groupValue: ctrl.annoDiCorso,
                                          onChanged: null,
                                          activeColor: Color(0xFF868AA8)
                                        ),
                                      )
                                    ),
                                    const Spacer()
                                  ],
                                
                              )
                            ],
                          )
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 15, top: 15),
                    child: Text("Note dello studente", style: AppStyles.textFieldLabel,),
                  ),

                  TextFormField(
                    readOnly: true,
                    controller: ctrl.noteCtrl,
                    maxLines: 6,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.lightText, width: 1),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      hintText: "Note",
                      hintStyle: AppStyles.textFieldHint
                    ),
                    onChanged: (value) => {},
                  ),

                  const SizedBox(height: 35,),
          
                  Text("Domicilio e Residenza", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Divider(thickness: 1, color: Color(0xFFD1D1D1),),
                  ),
          
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: LabeledTextField(
                            ctrl: ctrl.indirizzoDomCtrl, 
                            label: "Indirizzo di domicilio", 
                            isReadOnly: ctrl.isReadOnly,
                            
                          )
                        ),

                        const SizedBox(width: 20,),
          
                        Expanded(
                          flex: 2,
                          child: LabeledTextField(
                            ctrl: ctrl.capDomCtrl, 
                            label: "CAP", 
                            isReadOnly: ctrl.isReadOnly,
                            
                          )
                        ),
                        
                      ],
                    ),
                  ),

                  const SizedBox(height: 40,),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        
                        Expanded(
                          flex: 4,
                          child: LabeledTextField(
                            ctrl: ctrl.comuneDomCtrl, 
                            label: "Comune", 
                            isReadOnly: ctrl.isReadOnly,
                            
                          )
                        ),
          
                        const SizedBox(width: 20,),
          
                        Expanded(
                          flex: 2,
                          child:  LabeledTextField(
                            ctrl: ctrl.provinciaDomCtrl, 
                            label: "Prov", 
                            isReadOnly: ctrl.isReadOnly,
                            
                          )
                        ),
                      ],
                    ),
                  ),
          
                  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() => Checkbox(value: ctrl.isDomDiversoRes(), onChanged: (value){ctrl.isDomDiversoRes.toggle(); value = ctrl.isDomDiversoRes();})),
                        Text("Domicilio diverso dalla residenza")
                      ],
                    ),
                  ),

                  Obx(() => ctrl.isDomDiversoRes() ? Container(child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: LabeledTextField(
                                ctrl: ctrl.indirizzoResCtrl, 
                                label: "Indirizzo di residenza", 
                                isReadOnly: ctrl.isReadOnly,
                                
                              )
                            ),

                            const SizedBox(width: 20,),
              
                            Expanded(
                              flex: 2,
                              child: LabeledTextField(
                                ctrl: ctrl.capResCtrl, 
                                label: "CAP", 
                                isReadOnly: ctrl.isReadOnly,
                                
                              )
                            ),

                          ],
                        ),
                      ),

                      const SizedBox(height: 40,),
          
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [

                            Expanded(
                              flex: 4,
                              child: LabeledTextField(
                                ctrl: ctrl.comuneResCtrl, 
                                label: "Comune", 
                                isReadOnly: ctrl.isReadOnly,
                                
                              )
                            ),
              
                            const SizedBox(width: 20,),
              
                            Expanded(
                              flex: 2,
                              child:  LabeledTextField(
                                ctrl: ctrl.provinciaResCtrl, 
                                label: "Prov", 
                                isReadOnly: ctrl.isReadOnly,
                                
                              )
                            ),
                          
                          ],
                        ),
                      ),
                    ],
                  ),) : const SizedBox()),
                  
                  
                  const SizedBox(height: 35,),

                  Text("Contatti", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Divider(thickness: 1, color: Color(0xFFD1D1D1),),
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.emailIstituzionaleCtrl, 
                          label: "Email istituzionale", 
                          isReadOnly: true,
                          withCopyButton: true,
                          hint: ctrl.isReadOnly ? '' : 'Non modificabile',
                        )
                      ),
          
                      const SizedBox(width: 45,),
          
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.emailPersonaleCtrl, 
                          label: "Email personale", 
                          isReadOnly: ctrl.isReadOnly,
                          withCopyButton: true,
                        )
                      ),
                    ],
                  ),

                  const SizedBox(height: 40,),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.cellulareCtrl, 
                          label: "Cellulare", 
                          isReadOnly: ctrl.isReadOnly,
                          withCopyButton: true,
                        )
                      ),

                      const SizedBox(width: 45,),
          
                      Expanded(child: const SizedBox()),
          
                    ],
                  ),
                  
                  

                  if(!ctrl.isReadOnly)
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FilledBtn(
                          rounded: true,
                          text: "SALVA", 
                          onPressed: () => ctrl.editStudent(context),
                        )
                      ],
                    ),
                  )
                  
                ],
              ),
            )
        );
      }
    );
  }
}