// import 'dart:async';
// import 'dart:ui';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:marker_icon/marker_icon.dart';
// import 'package:unipd_tirocini/app/app_colors.dart';
// import 'package:unipd_tirocini/models/my_marker.dart';
// import 'package:unipd_tirocini/pages/map/map_controller.dart';
// import 'package:unipd_tirocini/pages/map/place.dart';
// import 'package:unipd_tirocini/widgets/loader.dart';

// class MapSample extends StatefulWidget {

//   final String title;
//   final List<Widget> legenda;
//   final List<Place> items;

//   const MapSample({Key? key, required this.legenda, required this.title, required this.items}) : super(key: key);
//   @override
//   State<MapSample> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapSample> {
//   late ClusterManager _manager;

//   late BitmapDescriptor istitutoCustomIcon;
//   //late BitmapDescriptor domicilioCustomIcon;
//   /* void setCustomMarker() async {
//     domicilioCustomIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: Get.mediaQuery.devicePixelRatio), 'assets/images/residenza_studente_map_marker.png');
//       setState(() {
//         domicilioCustomIcon = domicilioCustomIcon;
//       }
//     );
//     istitutoCustomIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: Get.mediaQuery.devicePixelRatio), 'assets/images/icon_comprensivo.png');
//       setState(() {
//         istitutoCustomIcon = istitutoCustomIcon;
//       }
//     );
//   } */

//   Completer<GoogleMapController> _controller = Completer();

//   Set<Marker> markers = Set();

//   final GlobalKey globalKey = GlobalKey();

//   final CameraPosition _parisCameraPosition =
//       CameraPosition(target: LatLng(48.856613, 2.352222), zoom: 12.0);

//   ////
//   final CameraPosition _padovaCameraPosition =
//       CameraPosition(target: LatLng(45.40672338438741, 11.882316934316156), zoom: 12.0);

  
//   bool firstFrame = true;
  

//    List<Place> _items = [];
//   /*void generateMarkers() {
//     Place p;
//     for(Istituto i in istituti){
//       p = Place(name: i.nome, latLng: LatLng(i.latitudine, i.longitudine), isIstituto: true);
//       items.add(p);
//     }

//     /* items.add(
//       Place(name: "Domicilio", latLng: LatLng(45.40686286252354, 11.884876590460742), isDomicilio: true)
//     );

//     items.add(
//       Place(name: "Gruppo 1", latLng: LatLng(45.39829962905493, 11.87608876016597), isGruppo: true)
//     ); */
//   } */

//   @override
//   void initState() {
//     _items.addAll(widget.items);
//     //setCustomMarker();
//     initializeMarkers();
//     //_manager = _initClusterManager();
//     //generateMarkers();
//     super.initState();
//   }

//   ClusterManager _initClusterManager() {
//     return ClusterManager<Place>(
//         _items,
//         _updateMarkers,
//         markerBuilder: _markerBuilder,
//         levels: [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20.0],
//         extraPercent: 1
//       );
//   }

//   void _updateMarkers(Set<Marker> markers) {
//     print('Updated ${markers.length} markers');
//     setState(() {
//       this.markers = markers;
//     });
//   }

//   final ctrl = Get.find<MapsController>();
//   List<MyMarker> myMarkers = [];
//   List<GlobalKey> keys = [];

//   initializeMarkers() async {
//     // foreach gruppi
//     ctrl.listaGruppi.forEach((element) async {
//       GlobalKey k = GlobalKey();
//       keys.add(k);
//       MyMarker marker = MyMarker(k);
//       myMarkers.add(marker);
      
//     });

//     print("---------------" + myMarkers.toString());

//     setState(() {
      
//     });
//   }

//   findPaintedMarkers() async {
//     int i = 0;

//     keys.forEach((k) async { 
//       var icon = await MarkerIcon.widgetToIcon(k);

//       var m = Marker(
//         markerId: MarkerId(ctrl.listaGruppi[i].name),
//         position: ctrl.listaGruppi[i].latLng,
//         onTap: () {
//         },
//         icon: icon
//       );

//       markers.add(m);
//       i ++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // WidgetsBinding.instance.addPostFrameCallback((_) => findPaintedMarkers()); // TODO

//     //if(domicilioCustomIcon != null)
//     /* markers.add(Marker(
//       markerId: MarkerId("1"),
//       position: LatLng(45.40813208892099, 11.88625521637007),
//       infoWindow: InfoWindow(title: "Il Paolotti"),
//       //icon: domicilioCustomIcon
//     )); */
//     //_updateMarkers(markers);

    
//     return new Scaffold(
//       body: Stack(
//         children: [
          
//           //MyMarker(globalKey),

//           ...myMarkers,
//           if(markers.length == 0)
//             Loader(),
//           if(markers.length > 0)
//           Container(
//             color: Color(0xFFEBE9F2),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
//                       const SizedBox(width: 15,),
//                       Text(widget.title)
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: GoogleMap(
//                     mapType: MapType.normal,
//                     initialCameraPosition: _padovaCameraPosition,
//                     markers: markers,
//                     onMapCreated: (GoogleMapController controller) {
//                       _controller.complete(controller);
//                      // _manager.setMapId(controller.mapId);
//                     },
//                     onCameraMove: (position) {
//                       //_manager.onCameraMove(position);
//                       print(position.zoom);
//                     },
//                     //onCameraIdle: _manager.updateMap
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: widget.legenda,
//                   ),
//                 ),
//               ],
//             ),
//           ),


//         ],
//       ),
//     );
//   }



//   Future<Marker> Function(Cluster<Place>) get _markerBuilder =>
//       (cluster) async {
//         return Marker(
//           markerId: MarkerId(cluster.getId()),
//           position: cluster.location,
//           onTap: () {
//             print('---- $cluster');
//             cluster.items.forEach((p) => print(p));
//           },
//           infoWindow: cluster.isMultiple ? InfoWindow.noText : InfoWindow(title: cluster.items.first.name),
//           icon: cluster.isMultiple 
//             ? await _getMarkerBitmap(125,text: cluster.count.toString()) 
//             : cluster.items.first.isDomicilio 
//               //? domicilioCustomIcon 
//               //: cluster.items.first.isGruppo 
//                 ? await MarkerIcon.widgetToIcon(globalKey) 
//                 : istitutoCustomIcon,
//         );
//       };

//   Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
//     if (kIsWeb) size = (size / 2).floor();

//     final PictureRecorder pictureRecorder = PictureRecorder();
//     final Canvas canvas = Canvas(pictureRecorder);
//     final Paint paint1 = Paint()..color = AppColors.primary;

//     canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
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
// }