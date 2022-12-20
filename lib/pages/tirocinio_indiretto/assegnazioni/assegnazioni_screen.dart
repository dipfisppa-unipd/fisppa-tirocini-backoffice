
import 'package:flutter/material.dart';
import 'package:unipd_tirocini/utils/utils.dart';
import 'package:unipd_tirocini/widgets/containers/main_wrapper.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/btn_primary.dart';
import 'package:unipd_tirocini/widgets/ui/empty_data_box.dart';


class AssegnazioniScreen extends StatelessWidget {
  const AssegnazioniScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainWrapper(
        title: "Assegnazione Gruppi primi anni",
        actions: [
          BtnPrimary(
            text: 'ASSEGNAZIONI PROVVISORIE',
            onTap: (){
              Utils.showToast(context: context, isWarning: true, text: 'Non disponibile');
            },
          ),

          const SizedBox(width: 20,),

          BtnPrimary(
            text: 'Scarica dati',
            onTap: (){
              Utils.showToast(context: context, isWarning: true, text: 'Non disponibile');
            },
          ),

          const SizedBox(width: 20,),

          BtnPrimary(
            text: 'CREA NUOVO GRUPPO',
            onTap: (){
              Utils.showToast(context: context, isWarning: true, text: 'Non disponibile');
            },
          ),
        ],

        child: const EmptyDataBox('Non disponibile'),
      ),
    );
  }
}