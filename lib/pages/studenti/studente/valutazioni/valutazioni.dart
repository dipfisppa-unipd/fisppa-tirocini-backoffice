import 'package:flutter/material.dart';
import 'package:unipd_tirocini/widgets/ui/empty_data_box.dart';

class Valutazioni extends StatelessWidget {
  
  const Valutazioni({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const EmptyDataBox('Non ancora disponibile'),

        // WhiteBox(
        //   child: Column(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.fromLTRB(60, 50, 60, 70),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text("Valutazioni", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
        //             Padding(
        //               padding: const EdgeInsets.symmetric(vertical: 17),
        //               child: Divider(),
        //             ),
              
        //             Row( 
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text("Tabella di riepilogo delle valutazioni dei 4 anni", style: TextStyle(fontSize: 20)),
        //                 BtnPrimary(text: "GENERA CERTIFICATO", onTap: (){})
                        
        //               ],
        //             ), 
              
        //             SizedBox(height: 40,),
              
        //             DataTable2(
        //               columnSpacing: 12,
        //               horizontalMargin: 12,
        //               minWidth: 600,
        //               dataRowHeight: 60,
        //               decoration: BoxDecoration(
        //                 color: AppColors.secondary,
        //               ),
        //               columns: [
        //                 DataColumn(
        //                   label: Text('Annno di Tirocinio', style: TextStyle(fontWeight: FontWeight.bold),),
        //                 ),
        //                 DataColumn(
        //                   label: Text('Anno Accedemico', style: TextStyle(fontWeight: FontWeight.bold),),
        //                 ),
        //                 DataColumn2(
        //                   size: ColumnSize.M,
        //                   label: Text('Voto', style: TextStyle(fontWeight: FontWeight.bold),),
        //                 ),
        //                 DataColumn(
        //                   label: Text('Valore', style: TextStyle(fontWeight: FontWeight.bold),),
        //                 ),
                        
        //               ],
        //               rows: List<DataRow>.generate(
        //                 4,
        //                 (index) => DataRow2(
        //                   color: MaterialStateColor.resolveWith((states) => index % 2 == 1 ? AppColors.secondary : Colors.white),
        //                   cells: [

        //                      DataCell(Text('${index+2}')),
              
        //                       DataCell( Text('${index+1}'),),
              

        //                       DataCell(
        //                         Text('Ottimo'),
        //                       ),
              
        //                       DataCell(Text('2'),),
              
                             
        //                   ]
        //                 )
        //               )
        //             ),
        //           ]
        //         )
        //       ),

        //       Container(
        //         width: Get.width,
        //         height: 80,
        //         color: Color(0xFFF8F8F8),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Text("Punteggio parziale: 0.65", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)
        //           ],
        //         ),
        //       ),

        //       Padding(
        //         padding: const EdgeInsets.fromLTRB(60, 50, 60, 70),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             const Text("Relazione finale", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
        //             const Divider(),
        //             TextField(
        //               controller: _ctrl.relazioneCtrl,
        //               maxLines: 6,
        //               decoration: InputDecoration(
        //                 /* border: OutlineInputBorder(
        //                   borderSide: const BorderSide(color: AppColors.lightText, width: 2),
        //                   borderRadius: BorderRadius.circular(4)
        //                 ), */
        //                 focusedBorder: OutlineInputBorder(
        //                   borderSide: const BorderSide(color: AppColors.lightText, width: 2),
        //                   borderRadius: BorderRadius.circular(4)
        //                 ),
        //                 enabledBorder: OutlineInputBorder(
        //                   borderSide: const BorderSide(color: AppColors.lightText, width: 2),
        //                   borderRadius: BorderRadius.circular(4)
        //                 ),
        //                 hintText: "relazione finale",
        //                 hintStyle: AppStyles.textFieldHint
        //               ),
        //               onChanged: (value) => {},
        //             ),

        //             const SizedBox(height: 35,),
        //             Obx(() => Text("Voto: " + _ctrl.voto.value.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,))),
                  
        //             const SizedBox(height: 15,),

        //             Row(
        //               children: [
        //                 Expanded(
        //                   flex: 1, 
        //                   child: Obx(() => SliderTheme(
        //                     data: SliderThemeData(
        //                       showValueIndicator: ShowValueIndicator.always,
        //                       activeTrackColor: AppColors.secondary,
        //                       inactiveTrackColor: AppColors.secondary, 
        //                       inactiveTickMarkColor: AppColors.black, 
        //                       activeTickMarkColor: AppColors.black,
        //                       valueIndicatorColor: AppColors.black,
        //                     ),
        //                     child: Slider(
        //                       value: _ctrl.voto.value, 
        //                       onChanged: (v){_ctrl.voto.value = v;}, 
        //                       divisions: 3, 
        //                       min: 0, 
        //                       max: 3,
        //                       label: _ctrl.voto.value.toString(),
        //                     ),
        //                   ))),
        //                 Expanded(flex: 2, child: Container())
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),

        //       const SizedBox(height: 15,),

        //       Container(
        //         width: Get.width,
        //         height: 80,
        //         color: Color(0xFFF8F8F8),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Text("Punteggio totale: 1.65", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)
        //           ],
        //         ),
        //       ),

        //       Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
        //         child: Row(
        //           children: [
        //             Spacer(),
        //             BtnPrimary(text: "SALVA", onTap: () {})
        //           ],
        //         ),
        //       )            
        //     ],
        //   ),
        // ),

        // const SizedBox(height: 30,),

        // WhiteBox(
        //   child: Padding(
        //     padding: const EdgeInsets.fromLTRB(60, 30, 60, 0),
        //     child: Column(
        //       children: [
        //         Row(
        //           mainAxisSize: MainAxisSize.max,
        //           children: [
        //             Text("Note sulle Valutazioni", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)),
        //             Spacer(),
        //             Text("1° anno", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
        //             Obx(() => RotatedBox(quarterTurns: _ctrl.isSection1Open.value ? 3 : 0, child: IconButton(onPressed: (){_ctrl.isSection1Open.toggle();}, icon: Icon(Icons.chevron_left))))
        //           ],
        //         ),

        //         Obx(() => _ctrl.isSection1Open.value ? Container(color: AppColors.primary, height: 30,) : const SizedBox()),
        //         Divider()
        //       ],
        //     ),
        //   )
        // ),
        
        // WhiteBox(
        //   child: Padding(
        //     padding: const EdgeInsets.fromLTRB(60, 30, 60, 0),
        //     child: Column(
        //       children: [
        //         Row(
        //           mainAxisSize: MainAxisSize.max,
        //           children: [
        //             Text("Note sulle Valutazioni", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)),
        //             Spacer(),
        //             Text("2° anno", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
        //             Obx(() => RotatedBox(quarterTurns: _ctrl.isSection2Open.value ? 3 : 0, child: IconButton(onPressed: (){_ctrl.isSection2Open.toggle();}, icon: Icon(Icons.chevron_left))))
        //           ],
        //         ),

        //         Obx(() => _ctrl.isSection2Open.value ? Container(color: AppColors.primary, height: 30,) : const SizedBox()),
        //         Divider()
        //       ],
        //     ),
        //   )
        // ),
        
        // WhiteBox(
        //   child: Padding(
        //     padding: const EdgeInsets.fromLTRB(60, 30, 60, 0),
        //     child: Column(
        //       children: [
        //         Row(
        //           mainAxisSize: MainAxisSize.max,
        //           children: [
        //             Text("Note sulle Valutazioni", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)),
        //             Spacer(),
        //             Text("3° anno", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
        //             Obx(() => RotatedBox(quarterTurns: _ctrl.isSection3Open.value ? 3 : 0, child: IconButton(onPressed: (){_ctrl.isSection3Open.toggle();}, icon: Icon(Icons.chevron_left))))
        //           ],
        //         ),

        //         Obx(() => _ctrl.isSection3Open.value ? Container(color: AppColors.primary, height: 30,) : const SizedBox()),
        //         Divider()
        //       ],
        //     ),
        //   )
        // ),
        
        // WhiteBox(
        //   child: Padding(
        //     padding: const EdgeInsets.fromLTRB(60, 30, 60, 0),
        //     child: Column(
        //       children: [
        //         Row(
        //           mainAxisSize: MainAxisSize.max,
        //           children: [
        //             Text("Note sulle Valutazioni", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)),
        //             Spacer(),
        //             Text("4° anno", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
        //             Obx(() => RotatedBox(quarterTurns: _ctrl.isSection4Open.value ? 3 : 0, child: IconButton(onPressed: (){_ctrl.isSection4Open.toggle();}, icon: Icon(Icons.chevron_left))))
        //           ],
        //         ),

        //         Obx(() => _ctrl.isSection4Open.value ? Container(color: AppColors.primary, height: 30,) : const SizedBox()),
        //         Divider()
        //       ],
        //     ),
        //   )
        // ),
      ],
    );
  }
}