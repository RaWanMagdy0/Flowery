import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../../core/utils/widget/shimmer_loading_widget.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Position? position;
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<bool> _checkServiceEnabled() async {
    Location location = Location();
    bool isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) {
      bool requestService = await location.requestService();
      if (requestService) {
        return true;
      }
    }
    return true;
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _checkServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    position = await Geolocator.getCurrentPosition();
    setState(() {});
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      width: double.infinity,
      child: position == null
          ? ShimmerLoadingWidget(
              height: 200.h,
              borderRadius: 0.w,
            ) // Loading spinner until the location is fetched
          : GoogleMap(
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (controller) {
                _mapController = controller;
                _markers.add(
                  Marker(
                    markerId: MarkerId('currentLocation'),
                    position: LatLng(position!.latitude, position!.longitude),
                    infoWindow: InfoWindow(title: 'My Location'),
                  ),
                );
                _mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    LatLng(position!.latitude, position!.longitude),
                    14.0,
                  ),
                );
                setState(() {}); // Update the UI when the map is ready
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    position?.latitude ?? 0.0, position?.longitude ?? 0.0),
                zoom: 14.0,
              ),
              markers: _markers,
            ),
    );
  }
}
