import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../app/app_colors.dart';
import '../../../../widgets/tooltip.dart';
import '../../../../widgets/ui/atoms/outlined_textfield.dart';
import '../institutes_controller.dart';


class InstitutesFilters extends StatelessWidget {
  const InstitutesFilters({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstitutesController>(
      id: 'institutes-filters',
      builder: (ctrl) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            // ROW 1 ---------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                // CERCA ISTITUTO --------
                SizedBox(
                  width: 280,
                  child: OutlinedTextField(
                    controller: ctrl.searchCtrl,
                    hint: 'Cerca istituto',
                    onSubmitted: (s)=>ctrl.loadPage(1),
                  ),
                ),

                TooltipInfo(
                  content: 'E\' possibile ricercare gli istituti tramite nome, città o codice meccanografico.\n\nLa ricerca è di "tipo esatto" quindi, ad esempio, va bene cercare "padova" ma non "pad".',
                  title: 'Ricerca istituti',
                ),

                const Spacer(),

                // FILTRI LEVEL 1 -------
                SizedBox(
                  width: 120,
                  height: 40,
                  child: TextFormField(
                    controller: ctrl.calendarYearCtrl,
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                        child: Icon(Icons.today, color: AppColors.iconDefault,),
                      )
                    ),
                    onTap: (){
                      ctrl.pickDate(context);
                    },
                  ),
                ),
                
                const SizedBox(width: 20,),

                DropdownButton2<String>(
                  buttonHeight: 40,
                  buttonWidth: 350,
                  buttonDecoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightText, width:1), //border of dropdown button
                    borderRadius: BorderRadius.circular(4), 
                  ),
                  buttonPadding: EdgeInsets.symmetric(horizontal: 10),
                  isExpanded: true,
                  items: [

                    DropdownMenuItem(
                      value: '',
                      child: Text('Tutti gli istituti'),
                    ),
                    
                    if(ctrl.options!=null)
                    for(var type in ctrl.options!.educationDegree)
                    DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    ),

                  ],
                  value: ctrl.schoolType,
                  onChanged: (v){
                    ctrl.setSchoolType(v??'');
                  },
                  underline: const SizedBox(),
                ),

                const SizedBox(width: 10,),

                IconButton(
                  icon: const Icon(Icons.replay_circle_filled_outlined, color: AppColors.iconDefault,),
                  onPressed: () => ctrl.reload(),
                  
                ),

              ],
            ),

            // ROW 2 ----------
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                if(ctrl.hasFilters)
                SizedBox(
                  height: 40,
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.close_rounded),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('Azzera filtri'),
                        ),
                        
                      ],
                    ), 
                    onTap: ctrl.resetFilters,
                  ),
                ),

                const Spacer(), 
                const Text('Mostra studenti: '),

                const SizedBox(width: 8,),
                
                Switch(
                  value: ctrl.unassigned, 
                  onChanged: ctrl.assigned || ctrl.confirmed ? null : (v){
                    ctrl.toggleShowStudents(u: v);
                  }
                ),
                const Text('non assegnati'),

                
                Switch(
                  value: ctrl.assigned, 
                  onChanged: ctrl.unassigned ? null :  (v){
                  ctrl.toggleShowStudents(a: v);
                }),
                const Text('assegnati'),

                Switch(
                  value: ctrl.confirmed, 
                  onChanged: ctrl.unassigned ? null :   (v){
                  ctrl.toggleShowStudents(c: v);
                }),
                const Text('confermati'),

              ],
            ),

            
          ],
        );
      }
    );
  }
}