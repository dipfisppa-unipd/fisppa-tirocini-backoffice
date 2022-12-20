// https://xd.adobe.com/view/52e4e83a-a5a2-4558-a64d-bc8ec69b71e7-07b7/screen/c6239e55-1336-4466-9a71-645d35ccbeca

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/app/app_styles.dart';
import 'package:unipd_tirocini/models/students/career_model.dart';
import 'package:unipd_tirocini/pages/studenti/studente/student_controller.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/form_text_field.dart';
import 'package:unipd_tirocini/widgets/containers/white_box.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/btn_primary.dart';

import 'career_controller.dart';
import 'empty_career_box.dart';

class StudentCareer extends StatelessWidget {

  const StudentCareer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentController>(
      builder: (ctrl) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            if(ctrl.student!.career != null)
            for(var academicYear in ctrl.student!.career!.academicYears)
              _CareerBox(academicYear),

            EmptyCareerBox(),
            
          ],
        );
      }
    );
  }
}


class _CareerBox extends StatelessWidget {

  final AcademicYear academicYear;

  const _CareerBox(this.academicYear, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CareerController>(
      init: CareerController(academicYear),
      tag: academicYear.calendarYear!.toString(),
      builder: (ctrl) {
        return WhiteBox(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(60, 50, 60, 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("Carriera - ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                    Text("${academicYear.calendarYear!-1}/${academicYear.calendarYear}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
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
                  child: Divider(),
                ),

                const SizedBox(height: 15,),

                Row(
                  children: [
                    Expanded(
                      flex: 1, 
                      child: LabeledTextField(
                        label: "Università di provenienza", 
                        ctrl: ctrl.uniOriginCtrl,
                        isReadOnly: ctrl.isReadOnly,
                      )
                    ),
                    
                    const SizedBox(width: 20,),
                    
                    Expanded(
                      flex: 1, 
                      child: LabeledTextField(
                        label: "Comune Università di provenienza", 
                        ctrl: ctrl.uniCityCtrl,
                        isReadOnly: ctrl.isReadOnly,
                      )
                    )
                  ],
                ),

                const SizedBox(height: 50,),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Tooltip(
                      message: 'Studente in Erasmus',
                      child: const Icon(Icons.public, color: AppColors.erasmus, size: 26, semanticLabel: 'Studente in Erasmus')),
                    const SizedBox(width: 15,),
                    const Text("Erasmus", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: const Divider(),
                ),

                const SizedBox(height: 15,),

                Row(
                  children: [

                    Expanded(
                      flex: 1, 
                      child: LabeledTextField(
                        label: "Università estera", 
                        ctrl: ctrl.universityCtrl,
                        isReadOnly: ctrl.isReadOnly,
                      )
                    ),

                    const SizedBox(width: 20,),

                    Expanded(
                      flex: 1, 
                      child: LabeledTextField(
                        label: "Nazione", 
                        ctrl: ctrl.stateCtrl,
                        isReadOnly: ctrl.isReadOnly,
                      )
                    ),
                    
                    const SizedBox(width: 20,),
                    
                    Expanded(
                      flex: 1, 
                      child: LabeledTextField(
                        label: "Indirizzo", 
                        ctrl: ctrl.addressCtrl,
                        isReadOnly: ctrl.isReadOnly,
                      )
                    )
                  ],
                ),

                LabeledTextField(
                  label: "Note", 
                  minLines: 3,
                  ctrl: ctrl.erasmusNoteCtrl,
                  isReadOnly: ctrl.isReadOnly,
                ),

                const SizedBox(height: 50,),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Tooltip(
                      message: 'Studente lavoratore',
                      child: Icon(Icons.work, color: AppColors.work, size: 26, semanticLabel: 'Studente lavoratore')),
                    const SizedBox(width: 15,),
                    const Text("Lavoro", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: const Divider(),
                ),

                
                const SizedBox(height: 15,),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Esperienza lavorativa: ", style: AppStyles.textFieldLabel),
                    Text('${ctrl.totalDaysOfWork()} giorni lavorati, ${ctrl.totalJobs} contratti'),
                  ],
                ),

                const SizedBox(height: 15,),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          const Text("Diritto di riduzione", style: AppStyles.textFieldLabel),
                          
                          Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text("Sì"),
                                    leading: Radio(
                                      value: true,
                                      groupValue: ctrl.reductionRight,
                                      onChanged: ctrl.isReadOnly ? null : ctrl.toggleReductionRight,
                                      activeColor: Color(0xFF868AA8)
                                    ),
                                  )
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text("No"),
                                    leading: Radio(
                                      value: false,
                                      groupValue: ctrl.reductionRight,
                                      onChanged: ctrl.isReadOnly ? null : ctrl.toggleReductionRight,
                                      activeColor: Color(0xFF868AA8)
                                    ),
                                  )
                                ),
                              ],
                            
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(width: 20,),

                    Expanded(
                      flex: 2, 
                      child: LabeledTextField(
                        label: "Percentuale riduzione concessa", 
                        ctrl: ctrl.percentReductionCtrl,
                        isReadOnly: ctrl.isReadOnly,
                      )
                    ),
                    
                    
                  ],
                ),

                const SizedBox(height: 15,),
                
                const Divider(),

                const SizedBox(height: 15,),

                for(var job in ctrl.academicYear!.jobs)...[

                  Row(
                    children: [
                      Text(job.schoolCode ?? '-', style: AppStyles.textFieldLabel.copyWith(fontSize: 16),),
                      Text(' - ', style: AppStyles.textFieldLabel.copyWith(fontSize: 16),),
                      Text(job.schoolDegree ?? '-', style: AppStyles.textFieldLabel.copyWith(fontSize: 16),),
                    ],
                  ),

                  const SizedBox(height: 10,),

                  Row(
                    children: [
                      Expanded(child: Text('Ruolo: ${job.role}', style: TextStyle(fontSize: 14,),)),
                      
                      Expanded(child: Text('Contratto: ${job.contractType}', style: TextStyle(fontSize: 14,),)),
                    ],
                  ),

                  const SizedBox(height: 6,),

                  Row(
                    children: [
                      Expanded(child: Text('Durata totale: ${job.contractDuration}', style: TextStyle(fontSize: 14,),)),
                      
                      Expanded(child: Text('Ore settimanali: ${job.weeklySchedule}', style: TextStyle(fontSize: 14,),)),
                      
                    ],
                  ),

                  const SizedBox(height: 10,),

                  if(job.notes.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Note:', style: AppStyles.textFieldLabel,),
                      const SizedBox(height: 6,),
                      Text('${job.notes}', style: TextStyle(fontSize: 14,),),
                      
                    ],
                  ),

                  const SizedBox(height: 15,),

                  const Divider(),

                ],

                if(ctrl.addNewJob)...[

                  const SizedBox(height: 15,),

                  Text('Aggiungi esperienza lavorativa', style: AppStyles.textFieldLabel.copyWith(fontSize: 16),),

                  const SizedBox(height: 15,),

                  Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Flexible(
                        child: LabeledTextField(
                          label: 'Codice meccanografico scuola',
                          hint: 'Indicare la scuola dove è stato effettivamente svolto il lavoro',
                          ctrl: ctrl.schoolCodeCtrl,
                        )
                      ),
                      const SizedBox(width: 20,),

                      Expanded(
                        child: LabeledField(
                          label: 'Ordine scuola',
                          child: Row(
                            children: [
                              ctrl.isPrimary ? const Text('Primaria') : const Text('Infanzia'),
                              Switch(value: ctrl.isPrimary, onChanged: ctrl.togglePrimary),
                            ],
                          ),
                        )
                      ),
                      
                    ],
                  ),

                  const SizedBox(height: 15,),

                  Row(
                    children: [
                      
                      Flexible(flex: 2, 
                        child: LabeledTextField(
                          isReadOnly: ctrl.isReadOnly,
                          label: "Ruolo", ctrl: ctrl.roleCtrl)),
                      
                      const SizedBox(width: 20,),

                      Flexible(flex: 2, 
                        child: LabeledTextField(
                          isReadOnly: ctrl.isReadOnly,
                          label: "Tipo contratto", ctrl: ctrl.contractTypeCtrl)),
                    ],
                  ),

                  const SizedBox(height: 10,),

                  Row(
                    children: [
                      
                      Flexible(flex: 1, 
                        child: LabeledTextField(
                          isReadOnly: ctrl.isReadOnly,
                          label: "Durata contratto (in giorni)", ctrl: ctrl.durationCtrl)),
                      
                      const SizedBox(width: 20,),
                      
                      Flexible(flex: 1, 
                        child: LabeledTextField(
                          isReadOnly: ctrl.isReadOnly,
                          label: "Orario contrattuale settimanale (in ore)", ctrl: ctrl.weekScheduleCtrl))
                    ],
                  ),

                  const SizedBox(height: 10,),

                  const Text("Altre specifiche sulla condizione contrattuale", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,)),

                  const SizedBox(height: 15,),
                  TextFormField(
                    controller: ctrl.jobNotesCtrl,
                    maxLines: 4,
                    readOnly: ctrl.isReadOnly,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.lightText, width: 2),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      hintText: "Altre specifiche sulla condizione contrattuale",
                      hintStyle: AppStyles.textFieldHint
                    ),
                    onChanged: (value) => {},
                  ),

                  const SizedBox(height: 15,),
                  
                ],
                
                

                const Divider(),
                
                if(!ctrl.isReadOnly)
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      
                      FilledBtn(
                        text: ctrl.addNewJob ? 'ANNULLA' : 'AGGIUNGI LAVORO',
                        rounded: true,
                        onPressed: () async {
                          if(ctrl.addNewJob)
                            ctrl.clearNewJobFields();

                          ctrl.toggleNewJob();
                        },
                      ),
                      
                    ],
                  ),
                ),

                if(!ctrl.isReadOnly)
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      
                      FilledBtn(
                        rounded: true,
                        text: "SALVA", 
                        onPressed: () => ctrl.saveCareer(context),
                      ),
                      
                    ],
                  ),
                )
                
              ],
            ),
          ),
        );
      }
    );
  }
}