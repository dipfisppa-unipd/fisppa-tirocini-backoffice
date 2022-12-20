// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:unipd_tirocini/app/app_colors.dart';

// class DropDownBtn extends StatelessWidget {
//   final Function(dynamic) onChanged;
//   final List<DropdownMenuItem> items;

//   DropDownBtn({ Key? key, required this.onChanged, required this.items, this.val, this.width = 150}) : super(key: key);

//   final val;
//   final double width;

//   @override
//   Widget build(BuildContext context) {

//     return DropdownButton2(
//       buttonHeight: 32,
//       buttonWidth: width,
//       buttonDecoration: BoxDecoration(
//         border: Border.all(color: AppColors.lightText, width:1), //border of dropdown button
//         borderRadius: BorderRadius.circular(4), 
//       ),
//       buttonPadding: EdgeInsets.symmetric(horizontal: 10),
//       isExpanded: true,
//       items: items
//           .map((item) => DropdownMenuItem<int>(
//                 value: item.value,
//                 child: item.child
//               ))
//           .toList(),
//       value: val,
//       onChanged: onChanged,
//       underline: Container(),
//       icon: RotatedBox(quarterTurns: 3, child: Icon(Icons.chevron_left)),
//     );
//   }
// }