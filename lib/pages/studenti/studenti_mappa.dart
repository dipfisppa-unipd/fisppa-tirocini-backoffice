import 'package:flutter/material.dart';
import 'package:unipd_tirocini/widgets/containers/details_screen_shell.dart';
import 'package:unipd_tirocini/widgets/containers/white_box.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/btn_primary.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/data_box.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/navigation_button.dart';

class StudentiMappa extends StatelessWidget {
  const StudentiMappa({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailsScreenShell(
      dataBox: DataBox(
        title: "Istituto Leonardo Da Vinci",
        actions: [
          NavigationButton(text: "Dati", onTap: (){}, isActive: false),
          NavigationButton(text: "Studenti", onTap: (){}, isActive: true),
        ],
        data: [
          DataBoxRow(label: "Istituto Leonardo Da Vinci", content: "Istituto Leonardo Da Vinci"),
          DataBoxRow(label: "Tipologia", content: "Comprensivo"),
          DataBoxRow(label: "Indirizzo", content: "Via san Giuliano, Padova"),
          DataBoxRow(label: "Indirizzo Convenzione", content: "18/01/2019"),
          DataBoxRow(label: "Scadenza Convenzione", content: "15/04/2022"),
        ],
      ),

      content: WhiteBox(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(60, 50, 60, 70),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text("Studenti", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                  Text("Anno accademico 2022/2023", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 17),
                child: Divider(),
              ),

              const SizedBox(height: 25,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text("Totale richieste anno corrente: 10", style: TextStyle(fontSize: 14),),
                  Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.map, size: 30,)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.list, size: 30,)),
                      BtnPrimary(text: "SCARICA DATI", onTap: (){})
                    ],
                  ),
                ],
              ),


              //TODO: MAPPA
              LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    height: 700,
                    width: 700,//constraints.maxWidth,
                    //child: 
                    //MyMap()
                    //MapSample()
                    //MapScreen()
                    /* GoogleMap(
                      initialCameraPosition: CameraPosition(
                        zoom: 12, // max value
                        tilt: 0,
                        bearing: 0, // ignored on web
                        target: LatLng(45.40672338438741, 11.882316934316156),
                      ),
                    ), */
                  );
                }
              ),


            ],
          ),
        )
      ),
      
    );
  }
}