import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place with ClusterItem {
  final String name;
  final bool isDomicilio;
  final bool isGruppo;
  final bool isIstituto;
  final LatLng latLng;

  Place({required this.name, required this.latLng, this.isDomicilio = false, this.isGruppo = false, this.isIstituto = false});

  @override
  LatLng get location => latLng;
}