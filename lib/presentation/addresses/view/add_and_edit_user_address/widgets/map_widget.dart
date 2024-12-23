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
  double currentZoom = 14.0;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 230.0,
          width: double.infinity,
          child: GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomGesturesEnabled: true,
            scrollGesturesEnabled: true,
            rotateGesturesEnabled: true,
            tiltGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (controller) {
              _mapController = controller;
            },
            onTap: _handleMapTap,
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
        Positioned(
          right: 10,
          bottom: 100,
          child: Column(
            children: [
              FloatingActionButton(
                mini: true,
                onPressed: () => _changeZoom(1),
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 5),
              FloatingActionButton(
                mini: true,
                onPressed: () => _changeZoom(-1),
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Future<void> _initializeMap() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      selectedLocation = LatLng(position.latitude, position.longitude);
      _updateMarker(selectedLocation!);
      widget.onLocationSelected(selectedLocation!);
    } catch (e) {
      selectedLocation = const LatLng(30.0444, 31.2357);
    }
  }
  void _handleMapTap(LatLng location) {
    selectedLocation = location;
    widget.onLocationSelected(location);
    _updateMarker(location);
  }
  void _changeZoom(double amount) {
    currentZoom = (currentZoom + amount).clamp(1.0, 20.0);
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(selectedLocation ?? const LatLng(30.0444, 31.2357), currentZoom),
    );
  }
  void _updateMarker(LatLng location) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: location,
          infoWindow: const InfoWindow(title: 'Selected Location'),
          draggable: true,
          onDragEnd: (newPosition) {
            selectedLocation = newPosition;
            widget.onLocationSelected(newPosition);
          },
        ),
      );
    });
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(location, currentZoom),
    );
  }
}