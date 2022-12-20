import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../app/app_colors.dart';

/// This widget is used as a filter for int values [0,1,2,3,4,5]
/// in case of: year of study [0-5] and internship year [1-4]
/// 
/// The [0] value is used to [showAll] the students, while
/// the internship year is limited to only four years.
/// 
class YearSelectionDropdown extends StatelessWidget {

  final int value;
  final bool isFive, showAll;
  final Function(int) onChanged;

  const YearSelectionDropdown({
    required this.value, 
    required this.onChanged, 
    this.showAll=true,
    this.isFive=true,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<int>(
      buttonHeight: 40,
      buttonWidth: 200,
      buttonDecoration: BoxDecoration(
        border: Border.all(color: AppColors.lightText, width:1), //border of dropdown button
        borderRadius: BorderRadius.circular(4), 
      ),
      buttonPadding: EdgeInsets.symmetric(horizontal: 10),
      isExpanded: true,
      items: [
        
        if(showAll)
        DropdownMenuItem(
          value: 0,
          child: Text('Tutti gli anni'),
        ),
        
        DropdownMenuItem(
          value: 1,
          child: Text('Primo anno'),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text('Secondo anno'),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text('Terzo anno'),
        ),
        DropdownMenuItem(
          value: 4,
          child: Text('Quarto anno'),
        ),

        if(isFive)
        DropdownMenuItem(
          value: 5,
          child: Text('Quinto anno'),
        ),

      ],
      value: value,
      onChanged: (v){
        if(v!=null) onChanged(v);
      },
      underline: const SizedBox(),
    );
  }
}