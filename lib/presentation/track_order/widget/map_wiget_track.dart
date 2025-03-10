import 'dart:async';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/images/app_images.dart';
import 'custom_window.dart';
class MapWidgetTrack extends StatefulWidget {
  final String orderId;

  const MapWidgetTrack({super.key, required this.orderId});

  @override
  State<MapWidgetTrack> createState() => _MapWidgetTrackState();
}

class _MapWidgetTrackState extends State<MapWidgetTrack> {
  final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  LatLng? storeLocation;
  LatLng? userLocation;
  LatLng? driverLocation;
  bool _isLoading = true;
  StreamSubscription? _driverLocationSubscription;
  BitmapDescriptor? customIcon;

  Future<BitmapDescriptor> resizeAndConvertToBitmap(String imagePath, int width, int height) async {
    final ByteData data = await rootBundle.load(imagePath);
    final Uint8List bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes, targetWidth: width, targetHeight: height);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? byteData = await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizedBytes = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(resizedBytes);
  }


  void _loadCustomMarker() async {
    try {
      final icon = await resizeAndConvertToBitmap(AppImages.locatIcon, 100, 100);
      setState(() {
        customIcon = icon;
      });
    } catch (e) {
      print("Error loading custom icon: $e");
    }
  }
  @override
  void initState() {
    super.initState();
    fetchOrderDetails();
    _loadCustomMarker();
  }

  @override
  void dispose() {
    _driverLocationSubscription?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> fetchOrderDetails() async {
    setState(() => _isLoading = true);

    try {
      DocumentSnapshot orderSnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .doc(widget.orderId)
          .get();

      if (orderSnapshot.exists) {
        var orderData = orderSnapshot.data() as Map<String, dynamic>;
        setState(() {
          storeLocation = LatLng(
            double.parse(orderData['store']['latLong'].split(',')[0]),
            double.parse(orderData['store']['latLong'].split(',')[1]),
          );
          userLocation = orderData['user']?['latLong'] != null
              ? LatLng(
            double.parse(orderData['user']['latLong'].split(',')[0]),
            double.parse(orderData['user']['latLong'].split(',')[1]),
          )
              : LatLng(storeLocation!.latitude + 0.01, storeLocation!.longitude + 0.01);

          _markers.add(
            Marker(
              markerId: MarkerId("store"),
              position: storeLocation!,
              icon: customIcon ?? BitmapDescriptor.defaultMarker,
              onTap: () {
                _customInfoWindowController.addInfoWindow?.call(
                  CustomWindow(title: orderData['store']['name'] ?? "Store", imagePath: AppImages.flowerIcon),
                  storeLocation!,
                );
              },
            ),
          );

          _markers.add(
            Marker(
              markerId: MarkerId("user"),
              position: userLocation!,
              icon: customIcon ?? BitmapDescriptor.defaultMarker,
              onTap: () {
                _customInfoWindowController.addInfoWindow?.call(
                  CustomWindow(title: orderData['user']?['firstName'] ?? "User", imagePath: AppImages.homeIcon),
                  userLocation!,
                );
              },
            ),
          );

          _addInitialPolyline();
          _isLoading = false;
        });

        trackDriverLocation();
      } else {
        print("Order document doesn't exist for ID: ${widget.orderId}");
        setState(() => _isLoading = false);
      }
    } catch (e) {
      print("Error fetching order details: $e");
      setState(() => _isLoading = false);
    }
  }

  void _addInitialPolyline() {
    if (storeLocation != null && userLocation != null) {
      setState(() {
        _polylines.add(Polyline(
          polylineId: PolylineId("initial_route"),
          color: AppColors.kPink,
          width: 2,
          points: [storeLocation!, userLocation!],
        ));
      });
    }
  }

  void trackDriverLocation() {
    _driverLocationSubscription?.cancel();

    _driverLocationSubscription = FirebaseFirestore.instance
        .collection('drivers')
        .doc(widget.orderId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        var driverData = snapshot.data() as Map<String, dynamic>;

        if (driverData.containsKey('lat') && driverData.containsKey('lng')) {
          setState(() {
            driverLocation = LatLng(driverData['lat'], driverData['lng']);
            updateDriverMarker();
            updateRoutePolyline();
          });
        }
      }
    }, onError: (error) {
      print("Error tracking driver: $error");
    });
  }

  void updateDriverMarker() {
    if (driverLocation != null) {
      setState(() {
        _markers.removeWhere((marker) => marker.markerId.value == "driver");
        _markers.add(Marker(
          markerId: MarkerId("driver"),
          position: driverLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: "Driver"),
        ));
      });

      _mapController?.animateCamera(CameraUpdate.newLatLng(driverLocation!));
    }
  }

  void updateRoutePolyline() {
    if (storeLocation == null || userLocation == null || driverLocation == null) return;

    List<LatLng> points = [storeLocation!, driverLocation!, userLocation!];

    _polylines.removeWhere((polyline) => polyline.polylineId.value == "complete_route");

    setState(() {
      _polylines.add(Polyline(
        polylineId: PolylineId("complete_route"),
        color: AppColors.kPink,
        width: 4,
        points: points,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator(color: AppColors.kPink));
    }

    if (storeLocation == null || userLocation == null) {
      return Center(child: Text("Loading..."));
    }

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: driverLocation ?? storeLocation!,
            zoom: 14,
          ),
          mapType: MapType.normal,
          markers: _markers,
          polylines: _polylines,
          myLocationEnabled: false,
          compassEnabled: true,
          zoomControlsEnabled: false,
          onTap: (_) => _customInfoWindowController.hideInfoWindow?.call(),
          onMapCreated: (controller) {
            _mapController = controller;
            _customInfoWindowController.googleMapController = controller;
          },
        ),
        CustomInfoWindow(
          controller: _customInfoWindowController,
          height: 80,
          width: 150,
          offset: 50,
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Column(
            children: [
              FloatingActionButton.small(
                heroTag: "zoom_in",
                backgroundColor: Colors.white,
                child: Icon(Icons.add, color: Colors.black),
                onPressed: () {
                  _mapController?.animateCamera(CameraUpdate.zoomIn());
                },
              ),
              SizedBox(height: 8),
              FloatingActionButton.small(
                heroTag: "zoom_out",
                backgroundColor: Colors.white,
                child: Icon(Icons.remove, color: Colors.black),
                onPressed: () {
                  _mapController?.animateCamera(CameraUpdate.zoomOut());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
