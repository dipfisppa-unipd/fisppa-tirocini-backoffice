// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:unipd_tirocini/models/gruppo_tirocinio_indiretto.dart';
// import 'package:unipd_tirocini/models/istituti_tirocinio_diretto.dart';
// import 'package:unipd_tirocini/pages/map/place.dart';

// class MapsController extends GetxController{

//   @override
//   void onReady() {
    
//     super.onReady();
//   }

//   @override
//   void onInit() {
//     generateMarkers();
//     generateGroupMarkers();
//     super.onInit();
//   }

  

//   List<Place> listaIstituti = [];
//   List<Place> listaGruppi = [];

//   List<Istituto> istituti = const [
//     Istituto(id: 1, nome: "Istituto comprensivo Briosco", indirizzo: "via Crivelli, 4 Padova", latitudine: 45.43127701529405, longitudine: 11.883687989988738),
//     Istituto(id: 2, nome: "Istituto comprensivo Rosmini", indirizzo: "Via Francesco Dorighello, 16, 35128",latitudine: 45.419698953818504, longitudine: 11.886934869086263),
//     Istituto(id: 3, nome: "Istituto comprensivo Michelangelo Buonarrotti", indirizzo: "Via delle Camelie, 1, 35137",latitudine: 45.42454305021434, longitudine: 11.819660699016781),
//     Istituto(id: 4, nome: 'Scuola infanzia "Mario Todesco" IC Alessandro Volta', indirizzo: "Via Giacomo Leopardi, 16, 35126",latitudine: 45.40026202541649, longitudine: 11.884658858951108),
//     Istituto(id: 5, nome: "Istituto comprensivo San Martino Del Carso", indirizzo: "Via del Carmine, 1, 35137", isInfanzia: false,latitudine: 45.4129207174758, longitudine: 11.874759606595328),
//     Istituto(id: 6, nome: "Scuola dell'infanzia il piccolo pulcino Pio", indirizzo: "Via Giacomo Leopardi, 16, 35126", isPrimaria: false,latitudine: 45.394434968471934, longitudine: 11.884677769085343 ),
//     Istituto(id: 7, nome: "Scuola dell'infanzia Giovanni Bertacchi", indirizzo: "Via Giovanni Bertacchi, 17, 35127", isPrimaria: false,latitudine: 45.39178257350088, longitudine: 11.896404355646416),
//     Istituto(id: 8, nome: "Scuola primaria Santa Rita", indirizzo: "Via Santa Rita, 4, 35126", isInfanzia: false,latitudine: 45.39537277752574, longitudine: 11.888175065653247),
//   ];

//   void generateMarkers() {
//     Place p;
//     for(Istituto i in istituti){
//       p = Place(name: i.nome, latLng: LatLng(i.latitudine, i.longitudine), isIstituto: true);
//       listaIstituti.add(p);
//     }
//   } 

//   List<GruppoTirocinioIndiretto> gruppi = [
//     GruppoTirocinioIndiretto(membri: 45, latitudine: 45.40630952681643, longitudine: 11.876371229928596),
//     GruppoTirocinioIndiretto(membri: 15, latitudine: 45.43369892382716, longitudine: 10.988249021875077, ),
//     GruppoTirocinioIndiretto(membri: 35, latitudine: 45.54491093443851, longitudine: 11.53546275754351),
//     GruppoTirocinioIndiretto(membri: 25, latitudine: 45.061595738919564, longitudine: 11.791123294332406),
//     GruppoTirocinioIndiretto(membri: 5, latitudine: 46.150199210182635, longitudine: 12.195785875765681),
//   ];

//   void generateGroupMarkers() {
//     Place p;
//     for(GruppoTirocinioIndiretto g in gruppi){
//       p = Place(name: g.membri.toString(), latLng: LatLng(g.latitudine, g.longitudine), isGruppo: true);
//       listaGruppi.add(p);
//     }
//   } 

// }