import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:unipd_tirocini/pages/studenti/students_controller.dart';
import 'package:unipd_tirocini/widgets/form/year_selection_dropdown.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/outlined_textfield.dart';

import '../../../app/app_colors.dart';
import '../../../widgets/tooltip.dart';
import '../../../widgets/ui/ui_alter_size.dart';


class FiltriStudentiView extends GetView<StudentsController> {

  const FiltriStudentiView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentsController>(
      builder: (ctrl) {
        return ScreenTypeLayout.builder(
          breakpoints: ScreenBreakpoints(
            desktop: 950,
            tablet: 899,
            watch: 200
          ),
          desktop: (_){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                
                SizedBox(
                  width: 350,
                  child: OutlinedTextField(
                    hint: 'Cerca cognome, email o matricola',
                    controller: ctrl.termsCtrl,
                    onSubmitted: (s)=>ctrl.getStudents(),
                  ),
                ),

                TooltipInfo(
                  content: '''
E\' possibile ricercare gli studenti tramite nome o cognome, email universitaria o personale, e numero di matricola.\n\n
La ricerca è di "tipo esatto" quindi, ad esempio, va bene cercare "De Rossi" ma non "De Ro".\n\n
Quando si cerca per cognome/matricola/email, l'anno di corso viene ignorato.
''',
                  title: 'Ricerca studenti',
                ),

                const Spacer(),

                YearSelectionDropdown(
                  value: ctrl.yearOfStudy, 
                  onChanged: (v)=>ctrl.changeInternshipYear(v),
                ),
          
                const SizedBox(width: 20,),

                SizedBox(
                  width: 200,
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

                const SizedBox(width: 10,),

                IconButton(
                  icon: const Icon(Icons.replay_circle_filled_outlined, color: AppColors.iconDefault,),
                  onPressed: () => controller.getStudents(),
                  
                ),

              ],
            );
          },
          tablet: (_) { 
            return const UISizeAlert();
          },
          mobile: (_) { 
            return const UISizeAlert();
          },

        );
        
      }
    );
  }
}