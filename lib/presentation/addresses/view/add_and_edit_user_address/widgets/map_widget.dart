import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../generated/l10n.dart';


class MapWidget extends StatefulWidget {
  final Function(LatLng, String) onLocationSelected;
  const MapWidget({required this.onLocationSelected, super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  LatLng? selectedLocation;
  double currentZoom = 18.0;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return Stack(
      children: [
        SizedBox(
          height: 200.0,
          width: double.infinity,
          child: GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            // Enable all gesture controls for map interaction
            zoomGesturesEnabled: true,
            scrollGesturesEnabled: true,
            rotateGesturesEnabled: true,
            tiltGesturesEnabled: true,
            zoomControlsEnabled: true,
            gestureRecognizers: {
              // Add gesture recognizers for better touch control
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
      ],
    );
  }
  Future<void> _initializeMap() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      selectedLocation = LatLng(position.latitude, position.longitude);
      String address = await _getDetailedAddress(selectedLocation!);
      _updateMarker(selectedLocation!, address);
      widget.onLocationSelected(selectedLocation!, address);
    } catch (e) {
      selectedLocation = const LatLng(30.0444, 31.2357);
    }
  }
  Future<void> updateLocation(double lat, double lng) async {
    LatLng newLocation = LatLng(lat, lng);
    String address = await _getDetailedAddress(newLocation);
    _updateMarker(newLocation, address);
    widget.onLocationSelected(newLocation, address);
  }

  Future<String> _getDetailedAddress(LatLng location) async {
    try {
      final local = S.of(context);

      final isEnglish = local ;

      List<Placemark> placemarks = await placemarkFromCoordinates(
          location.latitude,
          location.longitude,

      );
      if (placemarks.isEmpty) return 'Unknown Location';

      Placemark place = placemarks.first;
      List<String> addressParts = [];

      if (place.subLocality?.isNotEmpty == true) {
        addressParts.add(place.subLocality!);
      }
      if (place.locality?.isNotEmpty == true) {
        addressParts.add(place.locality!);
      }
      if (place.administrativeArea?.isNotEmpty == true) {
        addressParts.add(place.administrativeArea!);
      }
      return addressParts.join(', ');
    } catch (e) {
      return 'Location Error';
    }
  }

  void _handleMapTap(LatLng location) async {
    selectedLocation = location;
    String address = await _getDetailedAddress(location);
    widget.onLocationSelected(location, address);
    _updateMarker(location, address);
  }

  void _updateMarker(LatLng location, String address) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: location,
          infoWindow: InfoWindow(title: address),
          draggable: true,
          onDragEnd: (newPosition) async {
            selectedLocation = newPosition;
            String newAddress = await _getDetailedAddress(newPosition);
            widget.onLocationSelected(newPosition, newAddress);
          },
        ),
      );
    });
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(location, currentZoom),
    );
  }
}