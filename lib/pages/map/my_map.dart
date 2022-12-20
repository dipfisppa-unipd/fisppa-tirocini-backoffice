// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:marker_icon/marker_icon.dart';
// import 'package:unipd_tirocini/models/my_marker.dart';

// class MyMap extends StatelessWidget {
//   MyMap({ Key? key }) : super(key: key);

//   Set<Marker> _markers = <Marker>{};
  
//   // declare a global key   
//   final GlobalKey globalKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Scaffold(
//           body: Stack(
//             children: [
            
//               // you have to add your widget in the same widget tree
//               // add your google map in stack
//               // declare your marker before google map
//               // pass your global key to your widget
              
//               MyMarker(globalKey),
              
//               Positioned.fill(
//                 child: GoogleMap(
//                   initialCameraPosition: CameraPosition(
//                       target: LatLng(32.4279, 53.6880), zoom: 15),
//                   markers: _markers,
//                 ),
//               ),
//             ],
//           ),
//           floatingActionButton: FloatingActionButton.extended(
//             label: FittedBox(child: Text('Add Markers')),
//             onPressed: () async {
            
//               // call widgetToIcon Function and pass the same global key
              
//               _markers.add(
//                 Marker(
//                   markerId: MarkerId('circleCanvasWithText'),
//                   icon: await MarkerIcon.widgetToIcon(globalKey),
//                   position: LatLng(35.8400, 50.9391),
//                 ),
//               );
//             },
//           ),
//           floatingActionButtonLocation:
//               FloatingActionButtonLocation.centerFloat,
//         ),
//       ],
//     );
//   }
// }