// import 'dart:ui';

// import 'package:fluster/fluster.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:unipd_tirocini/models/istituti_tirocinio_diretto.dart';
// import 'package:unipd_tirocini/models/map_marker.dart';




// class MapController extends GetxController{

//   GoogleMapController? mapController;

//   Map<String, MapMarker> mapMarkers = {};

//   Set<Marker> markers = {};
//   final isMapTypeNormal = true.obs; 
//   double _currentZoom = 12;

//   @override
//   void onInit() {
//     super.onInit();
//   }

//   void initMap({@required GoogleMapController? ctrl,}){
//     mapController = ctrl;
//     _initFluster();
//   }

//   void aggiorna() {
//     update();
//   }

//   Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
//     if (kIsWeb) size = (size / 2).floor();

//     final PictureRecorder pictureRecorder = PictureRecorder();
//     final Canvas canvas = Canvas(pictureRecorder);
//     final Paint paint1 = Paint()..color = Colors.orange;
//     final Paint paint2 = Paint()..color = Colors.white;

//     canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
//     canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
//     canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

//     if (text != null) {
//       TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
//       painter.text = TextSpan(
//         text: text,
//         style: TextStyle(
//             fontSize: size / 3,
//             color: Colors.white,
//             fontWeight: FontWeight.normal),
//       );
//       painter.layout();
//       painter.paint(
//         canvas,
//         Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
//       );
//     }

//     final img = await pictureRecorder.endRecording().toImage(size, size);
//     final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

//     return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
//   }

//   // List<PlaceModel> items = [
//   //   for (int i = 0; i < 10; i++)
//   //     PlaceModel(
//   //         name: 'Place $i',
//   //         latLng: LatLng(48.848200 + i * 0.001, 2.319124 + i * 0.001)),
//   //   for (int i = 0; i < 10; i++)
//   //     PlaceModel(
//   //         name: 'Restaurant $i',
//   //         isClosed: i % 2 == 0,
//   //         latLng: LatLng(48.858265 - i * 0.001, 2.350107 + i * 0.001)),
//   //   for (int i = 0; i < 10; i++)
//   //     PlaceModel(
//   //         name: 'Bar $i',
//   //         latLng: LatLng(48.858265 + i * 0.01, 2.350107 - i * 0.01)),
//   //   for (int i = 0; i < 10; i++)
//   //     PlaceModel(
//   //         name: 'Hotel $i',
//   //         latLng: LatLng(48.858265 - i * 0.1, 2.350107 - i * 0.01)),
    
//   // ];

//   /// Fluster!
//   Fluster<MapMarker>? _fluster;

//   void updateZoom(double zoom) => _currentZoom=zoom;

//   void updateClusters(){
//     _displayMarkers();
//   }

//   void _initFluster(){

//     generateMarkers();
//     update();
    
//     _fluster = Fluster<MapMarker>(
//         minZoom: 0,
//         maxZoom: 20,
//         radius: 120,
//         extent: 2048,
//         nodeSize: 32,
//         points: mapMarkers.values.toList(),
//         createCluster:
//             (BaseCluster? cluster, double? longitude, double? latitude) =>
//                 MapMarker(
//                     locationName: null,
//                     latitude: latitude,
//                     longitude: longitude,
//                     isCluster: true,
//                     clusterId: cluster?.id,
//                     pointsSize: cluster?.pointsSize,
//                     markerId: cluster?.id.toString(),
//                     childMarkerId: cluster?.childMarkerId));
    
//     _displayMarkers();
//   }


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
//     MapMarker m;
//     for(Istituto i in istituti){
//       m = MapMarker(locationName: i.nome, latitude: i.latitudine, longitude: i.longitudine);
//       mapMarkers.addAll({"$i":m});
//     }
//     print(mapMarkers.length);
//   }
  

//   /* var mapMarkers = {
//       '9000000': MapMarker(
//           locationName: 'Veselka',
//           markerId: '9000000',
//           latitude: 40.729053,
//           longitude: -73.987142,
//           ),
//       '9000001': MapMarker(
//           locationName: 'Artichoke Basille\'s Pizza',
//           markerId: '9000001',
//           latitude: 40.732130,
//           longitude: -73.983891,
//           ),
//       '9000002': MapMarker(
//           locationName: 'Halal Guys',
//           markerId: '9000002',
//           latitude: 40.732327,
//           longitude: -73.984414,
//           ),
//       '9000003': MapMarker(
//           locationName: 'Taco Bell',
//           markerId: '9000003',
//           latitude: 40.735525,
//           longitude: -73.992725,
//           ),
//     }; */

//     _displayMarkers() async {
//       if (_fluster == null) {
//         return;
//       }

//       // Get the clusters at the current zoom level.
//       LatLngBounds visibleRegion = await mapController!.getVisibleRegion();
//       //[-180, -85, 180, 85],
//       List<MapMarker> clusters = _fluster!.clusters([ 
//         visibleRegion.southwest.longitude, visibleRegion.southwest.latitude, 
//         visibleRegion.northeast.longitude, visibleRegion.northeast.latitude,], 
//         _currentZoom.toInt(),);

//       // Finalize the markers to display on the map.
//       Map<MarkerId, Marker> _markers = {};

//       for (MapMarker feature in clusters) {
//         BitmapDescriptor bitmapDescriptor;

//         if (feature.isCluster ?? false) {
//           bitmapDescriptor = await _getMarkerBitmap(100, text: '${feature.pointsSize}');
//         } else {
//           bitmapDescriptor = BitmapDescriptor.defaultMarker;
//         }

//         var marker = Marker(
//             markerId: MarkerId(feature.markerId ?? 'x'),
//             position: LatLng(feature.latitude ?? 0.0, feature.longitude ?? 0.0),
//             infoWindow: InfoWindow(title: feature.locationName ?? 'Cluster'),
//             icon: bitmapDescriptor);

//         _markers.putIfAbsent(MarkerId(feature.markerId ?? 'x'), () => marker);
//       }

//       markers = _markers.values.toSet();

//       update();
//     }
// }