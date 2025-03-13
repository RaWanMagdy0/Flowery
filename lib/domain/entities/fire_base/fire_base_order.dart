import 'package:google_maps_flutter/google_maps_flutter.dart';

class FireBaseOrder {
  final String id;
  final LatLng storeLocation;

  FireBaseOrder({required this.id, required this.storeLocation});
}
