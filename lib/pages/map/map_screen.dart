// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:unipd_tirocini/controllers/map_controller.dart';
// import 'package:unipd_tirocini/models/my_marker.dart';


// class MapScreen extends StatelessWidget {
//   MapScreen({ Key? key }) : super(key: key);

//   final mapCtrl = Get.find<MapController>();

//   final GlobalKey globalKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [

//           MyMarker(globalKey),

//           Positioned.fill(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Expanded(
//                   child: GetBuilder<MapController>(
//                     builder: (ctrl) {
//                       return GoogleMap(
//                         markers: ctrl.markers,
//                         zoomControlsEnabled: kIsWeb,
//                         minMaxZoomPreference: const MinMaxZoomPreference(1, 20),
//                         mapToolbarEnabled: true,
//                         compassEnabled: !kIsWeb,
//                         myLocationButtonEnabled: !kIsWeb,
//                         myLocationEnabled: !kIsWeb,
//                         mapType: MapType.normal,
//                         initialCameraPosition: const CameraPosition(
//                           zoom: 12, // max value
//                           tilt: 0,
//                           bearing: 0, // ignored on web
//                           target: LatLng(45.40672338438741, 11.882316934316156),
//                         ),
//                         onMapCreated: (GoogleMapController controller) {
                          
//                           mapCtrl.initMap(
//                             ctrl: controller,
//                           );
                          
                          
//                         },
//                         onCameraIdle: (){
//                           mapCtrl.updateClusters();
//                         },
//                         onCameraMoveStarted: () {},
//                         onCameraMove: (p){
//                           mapCtrl.updateZoom(p.zoom);
//                         },
//                       );
//                     }
//                   ),
//                 ),
          
//                 TextButton(onPressed: (){
//                   mapCtrl.aggiorna();
//                 }, child: const Text('update')),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }