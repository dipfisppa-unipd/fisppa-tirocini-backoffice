import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/pages/studenti/studente/carriera/career_controller.dart';
import 'package:unipd_tirocini/widgets/containers/white_box.dart';

import '../../../../app/app_colors.dart';
import '../../../../widgets/ui/atoms/btn_primary.dart';



class EmptyCareerBox extends StatelessWidget {
  const EmptyCareerBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CareerController>(
      init: CareerController(),
      builder: (ctrl) {
        return WhiteBox(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(60, 50, 60, 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                const Text("Aggiungi carriera studente", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  child: const Divider(),
                ),

                const Text('''
E' possibile aggiungere informazioni sulla carriera di questo studente, seleziona l'anno di riferimento e clicca il pulsante aggiungi.
'''),
                
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

                const SizedBox(height: 15,),
                
                FilledBtn(
                  rounded: true,
                  onPressed: () => ctrl.addCareer(context), 
                  text: 'AGGIUNGI',
                ),
              ],
),
          ),
        );
      }
    );
  }
}