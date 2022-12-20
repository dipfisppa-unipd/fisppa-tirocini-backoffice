
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:mock_data/mock_data.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/pages/tirocinio_indiretto/assegnazioni/assegnazione_massiva_list.dart';
import 'package:unipd_tirocini/pages/tirocinio_indiretto/assegnazioni/assegnazione_massiva_mappa.dart';
import 'package:unipd_tirocini/widgets/unipd_appbar.dart';
import 'package:unipd_tirocini/widgets/containers/white_box.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/btn_primary.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/data_box.dart';

class AssegnazioneMassiva extends StatelessWidget {
  AssegnazioneMassiva({ Key? key }) : super(key: key);

  final isListView = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const UnipdAppBar(),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 23, top: 30),
                  child: DataBox(
                    title: "Assegnazione Gruppi massiva", 
                    data: [
                      DataBoxRow(label: "Denominazione", content: "Gruppo A"), 
                      DataBoxRow(label: "Tutor Coordinatore", content: mockName() +' '+ mockName()), 
                      DataBoxRow(label: "Tutor Organizzatore", content: mockName() +' '+ mockName()), 
                      DataBoxRow(label: "Territorialità", content: "Padova Centro"), 
                      DataBoxRow(label: "Numero Iscritti", content: "35"), 
                      DataBoxRow(label: "Durata", content: "16 Set - 25 Aprile"), 
                      DataBoxRow(label: "Anno", content: "2021/2022"), 
                    ], actions: [],),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 23),
              child: WhiteBox(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(60, 50, 60, 70),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Tirocinio indiretto", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                                const Spacer(),
                                IconButton(onPressed: () =>  {isListView.value = false}, icon: Icon(Icons.map, size: 30,)),
                                IconButton(onPressed: () => {isListView.value = true}, icon: Icon(Icons.list, size: 30,)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 17),
                              child: Divider(),
                            ),
                      
                            Text("Elenco studenti da assegnare", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                      
                            Obx(() => Row( 
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text("Totale: 32"),
                                  const Spacer(),
                                  isListView.value ? DropdownButton(
                                    value: 1,
                                    items: [
                                      DropdownMenuItem(
                                        value: 1,
                                        child: Text('Prima preferenza'),
                                      ),
                                    ], 
                                    onChanged: (v){},
                                  ) : DropdownButton(
                                    value: 0,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text("Visualizza risultati per preferenze"),
                                        value: 0,
                                      )
                                    ], 
                                    onChanged: (v) {}
                                  ),
                                  const SizedBox(width: 25),
                                  isListView.value ? BtnPrimary(text: "assegna", onTap: (){}): SizedBox()
                                ],
                              ),
                            ),                       
                          ],
                        ),
                      ),

                      Obx(() => isListView.value ? AssegnazioneMassivaLista() : AssegnazioneMassivaMappa())
                    ],
                  ),
                ),
                
              ),
            ),
          ),
        ],
      ),
    );
  }
}