// import 'package:flutter/material.dart';
// import 'package:mock_data/mock_data.dart';
// import 'package:unipd_tirocini/app/app_colors.dart';

// import 'btn_secondary.dart';

// class CustomDataTableSource extends DataTableSource{
//   @override
//   DataRow? getRow(int index) {
//     return DataRow.byIndex(
//       index: index,
//       cells: [
//         DataCell(
//           Text(mockName() +' '+ mockName()),
//         ),

//         DataCell(Text('PADOVA'),),

//         DataCell(Row(
//           children: [
//           Icon(Icons.work, color: AppColors.work),
//           const SizedBox(width: 12),
//           Icon(Icons.public, color: AppColors.erasmus,),
//           ],
//         )),

//         DataCell(Text('Provvisoria'),),

//         DataCell(BtnSecondary(text: "CONFERMA ASSEGNAZIONE", onTap: (){}))
//       ]
//     );
//   }

//   @override
//   // TODO: implement isRowCountApproximate
//   bool get isRowCountApproximate => false;

//   @override
//   // TODO: implement rowCount
//   int get rowCount => 20;
//   @override
//   // TODO: implement selectedRowCount
//   int get selectedRowCount => 0;
  
// }