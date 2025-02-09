import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidgetTrack extends StatefulWidget {
  const MapWidgetTrack({super.key});

  @override
  State<MapWidgetTrack> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidgetTrack> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  LatLng? selectedLocation;
  double currentZoom = 18.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 500.0,
          width: double.infinity,
          child: GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomGesturesEnabled: true,
            scrollGesturesEnabled: true,
            rotateGesturesEnabled: true,
            tiltGesturesEnabled: true,
            zoomControlsEnabled: true,
            gestureRecognizers: {
              Factory<PanGestureRecognizer>(() => PanGestureRecognizer()),
              Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
              Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer()),
              Factory<HorizontalDragGestureRecognizer>(
                      () => HorizontalDragGestureRecognizer()),
            },
            onMapCreated: (controller) {
              _mapController = controller;
            },
            onCameraMove: (position) {
              currentZoom = position.zoom;
            },
            initialCameraPosition: CameraPosition(
              target: selectedLocation ?? const LatLng(30.0444, 31.2357),
              zoom: currentZoom,
            ),
            markers: _markers,
          ),
        ),
      ],
    );
  }






}
