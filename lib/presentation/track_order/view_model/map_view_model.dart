import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flowery/domain/entities/pending_orders/order_entity.dart';
import 'package:flowery/domain/use_case/fire_base_order/fire_base_order_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import '../../../../core/api/api_result.dart';
import '../../../../core/base/base_view_model.dart';
import '../../../../domain/use_case/order/pending_orders_use_case.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/images/app_images.dart';
import '../../../domain/entities/fire_base/fire_base_order.dart';
import 'map_states.dart';
import 'dart:ui' as ui;

@injectable
class MapCubit extends BaseViewModel<PendingOrderState> {
  final GetPendingOrderUseCase orderUseCase;
  final FireBaseOrderUseCase fireBaseOrderUseCase;
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  final PolylinePoints polylinePoints = PolylinePoints();
  BitmapDescriptor? customIcon;
  BitmapDescriptor? carIcon;
  LatLng userLocation = LatLng(30.0444, 31.2357);
  List<OrderEntityDriver?> orderEntity = [];
  int currentStep = 1;
  StreamSubscription? _driverLocationSubscription;

  MapCubit(this.orderUseCase, this.fireBaseOrderUseCase)
      : super(OrderStateInitial());

  @override
  Future<void> close() {
    _driverLocationSubscription?.cancel();
    _customInfoWindowController.dispose();
    return super.close();
  }

  Future<void> getPendingOrders() async {
    if (isClosed) return;
    emit(OrderStateLoading());
    var result = await orderUseCase.invoke();
    if (isClosed) return;
    switch (result) {
      case Success():
        orderEntity = result.data ?? [];
        emit(PendingGetOrdersSuccessState(orders: result.data ?? []));
      case Fail():
        emit(PendingGetOrdersErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

  Future<void> loadOrder(String orderId) async {
    emit(OrderStateLoading());
    final result = await fireBaseOrderUseCase(orderId);
    switch (result) {
      case Success():
        final order = result.data;
        userLocation = _getOffsetLocation(order!.storeLocation, 0.01);
        await _loadCustomMarker();
        await getDirectionsPolyline(order);
        trackDriverLocation(orderId);
      case Fail():
        emit(OrderError(message: getErrorMassageFromException(result.exception)));
    }
  }

  Future<void> _loadCustomMarker() async {
      customIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(48, 48)), AppImages.locatIcon);
      customIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(48, 48)), AppImages.deliveryMotorcycle);

  }

  Future<void> getDirectionsPolyline(FireBaseOrder order) async {
    String url =
        "https://router.project-osrm.org/route/v1/driving/${order.storeLocation.longitude},${order.storeLocation.latitude};${userLocation.longitude},${userLocation.latitude}?geometries=geojson";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> coordinates = data["routes"][0]["geometry"]["coordinates"];
      List<LatLng> polylineCoordinates =
          coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();
      Set<Polyline> polylines = {
        Polyline(
          polylineId: PolylineId("route"),
          color: AppColors.kPink,
          width: 3,
          points: polylineCoordinates,
        )
      };
      emit(OrderLoaded(
          order: order,
          markers: _generateMarkers(order),
          polylines: polylines));
    }
  }

  Set<maps.Marker> _generateMarkers(FireBaseOrder order) {
    return {
      maps.Marker(
        markerId: MarkerId('store'),
        position: order.storeLocation,
        icon: customIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "Store"),
      ),
      maps.Marker(
        markerId: MarkerId('user'),
        position: userLocation,
        icon: customIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "Home"),
      ),
    };
  }

  Future<BitmapDescriptor> resizeAndConvertToBitmap(
      String imagePath, int width, int height) async {
    final ByteData data = await rootBundle.load(imagePath);
    final Uint8List bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes,
        targetWidth: width, targetHeight: height);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? byteData =
        await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizedBytes = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(resizedBytes);
  }

  void trackDriverLocation(String orderId) {
    _driverLocationSubscription?.cancel();
    _driverLocationSubscription = FirebaseFirestore.instance
        .collection('drivers')
        .doc(orderId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists && !isClosed) {
        var driverData = snapshot.data() as Map<String, dynamic>;
        if (driverData.containsKey('lat') && driverData.containsKey('lng')) {
          LatLng newDriverLocation =
              LatLng(driverData['lat'], driverData['lng']);

          final currentState = state;
          if (currentState is OrderLoaded) {
            double bearing = _getBearing(
              currentState.driverLocation?.latitude ??
                  newDriverLocation.latitude,
              currentState.driverLocation?.longitude ??
                  newDriverLocation.longitude,
              newDriverLocation.latitude,
              newDriverLocation.longitude,
            );

            updateDriverMarkerWithRotation(
                currentState.order, newDriverLocation, bearing);
            updateRoutePolyline(currentState.order, newDriverLocation);
          }
        }
      }
    }, onError: (error) {
      if (!isClosed) {
        emit(OrderError(message: "خطأ في تتبع السائق: $error"));
      }
    });
  }

  double _getBearing(
      double startLat, double startLng, double endLat, double endLng) {
    startLat = startLat * pi / 180;
    startLng = startLng * pi / 180;
    endLat = endLat * pi / 180;
    endLng = endLng * pi / 180;

    double dLon = endLng - startLng;
    double y = sin(dLon) * cos(endLat);
    double x =
        cos(startLat) * sin(endLat) - sin(startLat) * cos(endLat) * cos(dLon);
    double bearing = atan2(y, x);
    bearing = bearing * 180 / pi;
    bearing = (bearing + 360) % 360;

    return bearing;
  }

  void updateDriverMarkerWithRotation(
      FireBaseOrder order, LatLng newDriverLocation, double bearing) {
    if (isClosed) return;

    Set<maps.Marker> updatedMarkers = _generateMarkers(order);
    updatedMarkers.removeWhere((marker) => marker.markerId.value == "driver");
    updatedMarkers.add(maps.Marker(
      markerId: MarkerId("driver"),
      position: newDriverLocation,
      icon: carIcon ?? BitmapDescriptor.defaultMarker,
      rotation: bearing,
      anchor: Offset(0.5, 0.5),
      infoWindow: InfoWindow(title: "driver"),
    ));

    final currentState = state;
    if (currentState is OrderLoaded) {
      emit(OrderLoaded(
        order: order,
        markers: updatedMarkers,
        polylines: currentState.polylines,
        driverLocation: newDriverLocation,
        bearing: bearing,
      ));
    }
  }

  void updateRoutePolyline(FireBaseOrder order, LatLng driverLocation) async {
    if (isClosed) return;
    String url =
        "https://router.project-osrm.org/route/v1/driving/${driverLocation.longitude},${driverLocation.latitude};${userLocation.longitude},${userLocation.latitude}?geometries=geojson";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 && !isClosed) {
      final data = json.decode(response.body);
      List<dynamic> coordinates = data["routes"][0]["geometry"]["coordinates"];
      List<LatLng> polylineCoordinates =
          coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();
      final currentState = state;
      if (currentState is OrderLoaded) {
        Set<Polyline> updatedPolylines = Set.from(currentState.polylines);
        updatedPolylines.removeWhere(
            (polyline) => polyline.polylineId.value == "actual_route");
        updatedPolylines.add(Polyline(
          polylineId: PolylineId("actual_route"),
          color: AppColors.kPink,
          width: 3,
          points: polylineCoordinates,
        ));

        emit(OrderLoaded(
          order: order,
          markers: currentState.markers,
          polylines: updatedPolylines,
          driverLocation: driverLocation,
          bearing: currentState.bearing,
        ));
      }
    }
  }
}

LatLng _getOffsetLocation(LatLng baseLocation, double offset) {
  return LatLng(
      baseLocation.latitude + offset, baseLocation.longitude + offset);
}
