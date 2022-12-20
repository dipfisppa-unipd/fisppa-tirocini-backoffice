import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/pages/tirocinio_indiretto/ti_controller.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/outlined_textfield.dart';

import '../../../../app/app_colors.dart';
import '../../../../controllers/generic_data_controller.dart';


class GroupsFilters extends GetView<TIController> {

  const GroupsFilters({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
    
            SizedBox(
              width: 300,
              child: OutlinedTextField(
                hint: 'Cerca per cognome tutor',
                controller: controller.searchCtrl,
                onSubmitted: (s){
                  controller.onSearch(s);
                },
                
              ),
            ),
    
            const Spacer(),
    
            GetBuilder<TIController>(
              builder: (ctrl) {
                return SizedBox(
                  width: 150,
                  child: ctrl.hasFilters ? InkWell(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text('Reimposta i filtri'),
                        ),
                        Icon(Icons.close_rounded),
                      ],
                    ), 
                    onTap: controller.resetFilters,
                  ) : null,
                );
              }
            ),
    
            GetBuilder<TIController>(
              builder: (ctrl) {
                return DropdownButton2<String>(
                  buttonHeight: 40,
                  buttonWidth: 200,
                  buttonDecoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightText, width:1), //border of dropdown button
                    borderRadius: BorderRadius.circular(4), 
                  ),
                  buttonPadding: EdgeInsets.symmetric(horizontal: 10),
                  isExpanded: true,
                  items: [
    
                    DropdownMenuItem(
                      value: '',
                      child: Text('Tutte le territorialità'),
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
    
            const SizedBox(width: 16,),
    
            SizedBox(
              width: 200,
              height: 40,
              child: TextFormField(
                controller: controller.foundationYearCtrl,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Anno fondazione',
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
    
            const SizedBox(width: 10,),
    
            IconButton(
              icon: const Icon(Icons.replay_circle_filled_outlined, color: AppColors.iconDefault,),
              onPressed: () => controller.reload(),
              
            ),
    
          ],
        ),
      ),
    );
  }
}