import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapWidget extends StatefulWidget {
  final Function(LatLng) onLocationSelected;
  const MapWidget({required this.onLocationSelected, super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  LatLng? selectedLocation;
  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      width: double.infinity,
      child: GoogleMap(
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        scrollGesturesEnabled: true,
        rotateGesturesEnabled: true,
        tiltGesturesEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: (controller) {
          _mapController = controller;
        },
        onTap: (LatLng location) {
          selectedLocation = location;
          widget.onLocationSelected(location);
          _updateMarker(location);
        },
        initialCameraPosition: CameraPosition(
          target: selectedLocation ?? const LatLng(0.0, 0.0),
          zoom: 14.0,
        ),
        markers: _markers,
      ),
    );
  }
  Future<void> _initializeMap() async {
    Position position = await Geolocator.getCurrentPosition();
    selectedLocation = LatLng(position.latitude, position.longitude);
    _updateMarker(selectedLocation!);
  }
  void _updateMarker(LatLng location) {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId('selectedLocation'),
        position: location,
        infoWindow: const InfoWindow(title: 'Selected Location'),
      ),
    );
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(location, 14.0),
    );
    setState(() {});
  }
}
