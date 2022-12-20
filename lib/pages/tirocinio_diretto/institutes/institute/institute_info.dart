// https://xd.adobe.com/view/52e4e83a-a5a2-4558-a64d-bc8ec69b71e7-07b7/screen/f7198d77-490c-4053-867c-84e99bc54bf1

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/app/app_styles.dart';
import 'package:unipd_tirocini/controllers/generic_data_controller.dart';
import 'package:unipd_tirocini/pages/tirocinio_diretto/institutes/institute/institute_controller.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/form_text_field.dart';
import 'package:unipd_tirocini/widgets/containers/white_box.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/btn_primary.dart';

/// The right side with info about the institute
/// 
class InstituteInfo extends StatelessWidget {

  InstituteInfo({Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstituteController>(
      builder: (ctrl) {
        return WhiteBox(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(60, 50, 60, 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Dati Istituto", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black),),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Modifica dati', style: AppStyles.textFieldLabel),
                      ),
                      Switch(value: !ctrl.isReadOnly, onChanged: (v)=>ctrl.toggleReadOnly(v),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Divider(thickness: 1, color: Color(0xFFD1D1D1),),
                  ),
          
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.nameCtrl, 
                          label: "Denominazione *", 
                          isReadOnly: ctrl.isReadOnly,
                          onChanged: (value) {
                            ctrl.institute!.patcher.add('name', value);
                          },
                        )
                      ),
          
                      const SizedBox(width: 48,),
          
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.codeCtrl, 
                          label: "Codice Meccanografico *", 
                          isReadOnly: ctrl.isReadOnly || ctrl.hasInternships,
                          withCopyButton: true,
                          onChanged: (value) {
                            ctrl.institute!.patcher.add('code', value);
                          },
                          hint: !ctrl.isReadOnly && ctrl.hasInternships ? 'Non modificabile' : '',
                        )
                      ),

                      const SizedBox(width: 48,),
          
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.referenceCodeCtrl, 
                          label: "Codice Ist. Riferimento *", 
                          isReadOnly: ctrl.isReadOnly || ctrl.hasInternships,
                          withCopyButton: true,
                          onChanged: (value) {
                            ctrl.institute!.patcher.add('referenceInstituteCode', value);
                          },
                          hint: !ctrl.isReadOnly && ctrl.hasInternships ? 'Non modificabile' : '',
                        )
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 30,),

                  if(GenericDataController.to.options!=null)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
          
                      Expanded(
                        child: LabeledField(
                          label: "Tipo di istituto *", 
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
                                child: Text('Seleziona la tipologia'),
                              ),

                              for(var type in GenericDataController.to.options!.schoolType)
                              DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                              

                            ],
                            value: ctrl.schoolType,
                            onChanged: (s)=>ctrl.setSchoolType(s),
                            underline: const SizedBox(),
                          ),
                        )
                      ),

                      const SizedBox(width: 52,),
          
                      Expanded(
                        child: LabeledField(
                          label: "Grado *", 
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
                                child: Text('Seleziona il grado'),
                              ),

                              for(var degree in GenericDataController.to.options!.educationDegree)
                              DropdownMenuItem(
                                value: degree,
                                child: Text(degree),
                              ),
                              

                            ],
                            value: ctrl.educationDegree,
                            onChanged: (v){
                              ctrl.setEducationDegree(v);
                            },
                            underline: const SizedBox(),
                          ),
                        )
                      ),
                    ],
                  ),

                  const SizedBox(height: 30,),

                  if(GenericDataController.to.options!=null)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      Expanded(
                        child: LabeledField(
                          label: "Regione *", 
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
                                child: Text('Seleziona la regione'),
                              ),

                              for(var type in GenericDataController.to.options!.regions)
                              DropdownMenuItem(
                                value: type.name,
                                child: Text(type.name),
                              ),
                              

                            ],
                            value: ctrl.region,
                            onChanged: (s)=>ctrl.setRegion(s),
                            underline: const SizedBox(),
                          ),
                        )
                      ),

                      const SizedBox(width: 52,),

                      Expanded(
                        child: LabeledField(
                          label: "Zona", 
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
                                child: Text('Seleziona la zona'),
                              ),

                              for(var type in GenericDataController.to.options!.geographicAreas)
                              DropdownMenuItem(
                                value: type.name,
                                child: Text(type.name),
                              ),
                              

                            ],
                            value: ctrl.geoZone,
                            onChanged: (s)=>ctrl.setGeoZone(s),
                            underline: const SizedBox(),
                          ),
                        )
                      ),                      
                    ],
                  ),

                  
                  
                  const SizedBox(height: 35,),

          
                  Text("Indirizzo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Divider(thickness: 1, color: Color(0xFFD1D1D1),),
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.cityCtrl, 
                          label: "Comune *", 
                          isReadOnly: ctrl.isReadOnly,
                          onChanged: (value) {
                            ctrl.institute!.patcher.add('city', value);
                          },
                        )
                      ),
          
                      const SizedBox(width: 45,),

                      Expanded(
                        child: LabeledField(
                          label: "Provincia *", 
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
                                child: Text('Seleziona la provincia'),
                              ),

                              for(var type in GenericDataController.to.options!.provinces)
                              DropdownMenuItem(
                                value: type.name,
                                child: Text(type.name),
                              ),
                              

                            ],
                            value: ctrl.province,
                            onChanged: (s)=>ctrl.setProvince(s),
                            underline: const SizedBox(),
                          ),
                        )
                      ),
          
                      
                    ],
                  ),

                  const SizedBox(height: 30,),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.addressCtrl, 
                          label: "Indirizzo *", 
                          isReadOnly: ctrl.isReadOnly,
                          onChanged: (value) {
                            ctrl.institute!.patcher.add('address', value);
                          },
                        )
                      ),
          
                      const SizedBox(width: 45,),
          
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.capCtrl, 
                          label: "CAP", 
                          isReadOnly: ctrl.isReadOnly,
                          onChanged: (value) {
                            ctrl.institute!.patcher.add('cap', value);
                          },
                        )
                      ),
                    ],
                  ),

                  
                  const SizedBox(height: 35,),

                  Text("Info e contatti", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: const Divider(thickness: 1, color: Color(0xFFD1D1D1),),
                  ),
          
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
          
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.ivaCtrl, 
                          label: "Partita IVA / Codice Fiscale", 
                          isReadOnly: ctrl.isReadOnly,
                          withCopyButton: true,
                          onChanged: (value) {
                            ctrl.institute!.patcher.add('vatNumber', value);
                          },
                        )
                      ),

                      const SizedBox(width: 48,),
          
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.ibanCtrl, 
                          label: "IBAN", 
                          isReadOnly: ctrl.isReadOnly,
                          withCopyButton: true,
                          onChanged: (value) {
                            ctrl.institute!.patcher.add('iban', value);
                          },
                        )
                      ),
                    ],
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.phoneCtrl, 
                          label: "Telefono", 
                          isReadOnly: ctrl.isReadOnly,
                          withCopyButton: true,
                          onChanged: (value) {
                            ctrl.institute!.patcher.add('phoneNumber', value);
                          },
                        )
                      ),
          
                      const SizedBox(width: 45,),
          
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.faxCtrl, 
                          label: "Fax", 
                          isReadOnly: ctrl.isReadOnly,
                          withCopyButton: true,
                          onChanged: (value) {
                            ctrl.institute!.patcher.add('fax', value);
                          },
                        )
                      ),
                    ],
                  ),

                  const SizedBox(height: 30,),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.emailCtrl, 
                          label: "Email", 
                          isReadOnly: ctrl.isReadOnly,
                          withCopyButton: true,
                          onChanged: (value) {
                            ctrl.institute!.patcher.add('email', value);
                          },
                        )
                      ),
          
                      const SizedBox(width: 45,),
          
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.pecCtrl, 
                          label: "PEC", 
                          isReadOnly: ctrl.isReadOnly,
                          withCopyButton: true,
                          onChanged: (value) {
                            ctrl.institute!.patcher.add('pec', value);
                          },
                        )
                      ),
                    ],
                  ),

                  const SizedBox(height: 30,),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.siteCtrl, 
                          label: "Sito web", 
                          isReadOnly: ctrl.isReadOnly,
                          withCopyButton: true,
                          onChanged: (value) {
                            ctrl.institute!.patcher.add('website', value);
                          },
                        )
                      ),

                      const SizedBox(width: 45,),
          
                      Expanded(child: const SizedBox()),
          
                    ],
                  ),

                  const SizedBox(height: 35,),

                  Text("Convenzione", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: const Divider(thickness: 1, color: Color(0xFFD1D1D1),),
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: LabeledTextField(
                          ctrl: ctrl.conventionExpireCtrl,
                          label: "Scadenza convenzione", 
                          isReadOnly: true,
                          onTap: (){
                            if(!ctrl.isReadOnly){
                              ctrl.pickDate(context, isEnd: true);
                            }
                          },
                        )
                      ),

                      // Expanded(
                      //   child: LabeledTextField(
                      //     ctrl: ctrl.conventionStartCtrl,
                      //     label: "Inizio convenzione", 
                      //     isReadOnly: true,
                      //     onTap: (){
                      //       if(!ctrl.isReadOnly){
                      //         ctrl.pickDate(context, isEnd: false);
                      //       }
                      //     },
                      //   )
                      // ),

                      const SizedBox(width: 45,),

                      const Spacer(),
          
                      
          
                    ],
                  ),

                  const SizedBox(height: 35,),

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
                          onPressed: () => ctrl.saveInstitute(context),
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