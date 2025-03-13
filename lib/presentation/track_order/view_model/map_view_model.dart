import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
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
  final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
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
    print("🔥 Result from fireBaseOrderUseCase: $result");

    switch (result) {
      case Success():
        final order = result.data; // استخراج البيانات
        if (order == null) {
          print("❌ Order data is null!");
          emit(OrderError(message: "الطلب غير موجود"));
          return;
        }

        print("✅ Order fetched successfully: $order");
        userLocation = _getOffsetLocation(order.storeLocation, 0.01);
        await _loadCustomMarker();
        await getDirectionsPolyline(order);
        trackDriverLocation(orderId);

      case Fail():
        print("❌ Error fetching order: ${result.exception}");
        emit(OrderError(message: "خطأ في تحميل الطلب"));
    }
  }

  Future<void> _loadCustomMarker() async {
    try {
      customIcon = await resizeAndConvertToBitmap(AppImages.locatIcon, 100, 100);
      carIcon = await resizeAndConvertToBitmap(AppImages.deliveryMotorcycle, 100, 100);
    } catch (e) {
      print('Error loading custom marker: $e');
    }
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
          color: Colors.blue,
          width: 3,
          points: polylineCoordinates,
        )
      };
      emit(OrderLoaded(
          order: order,
          markers: _generateMarkers(order),
          polylines: polylines
      ));
    }
  }

  Set<maps.Marker> _generateMarkers(FireBaseOrder order) {
    return {
      maps.Marker(
        markerId: MarkerId('store'),
        position: order.storeLocation,
        icon: customIcon ?? BitmapDescriptor.defaultMarker,
      ),
      maps.Marker(
        markerId: MarkerId('user'),
        position: userLocation,
        icon: carIcon ?? BitmapDescriptor.defaultMarker,
      ),
    };
  }

  Future<BitmapDescriptor> resizeAndConvertToBitmap(String imagePath, int width, int height) async {
    final ByteData data = await rootBundle.load(imagePath);
    final Uint8List bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes, targetWidth: width, targetHeight: height);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? byteData = await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
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
          LatLng newDriverLocation = LatLng(driverData['lat'], driverData['lng']);
          final currentState = state;
          if (currentState is OrderLoaded) {
            LatLng? driverLocation = currentState.driverLocation;
            double bearing = 0;

            if (driverLocation != null) {
              bearing = _getBearing(
                  driverLocation.latitude,
                  driverLocation.longitude,
                  newDriverLocation.latitude,
                  newDriverLocation.longitude);
            }

            if (driverLocation == null ||
                Geolocator.distanceBetween(
                    driverLocation.latitude,
                    driverLocation.longitude,
                    newDriverLocation.latitude,
                    newDriverLocation.longitude) > 5) {

              // تحديث الماركر مع الموقع الجديد للسائق
              updateDriverMarkerWithRotation(currentState.order, newDriverLocation, bearing);

              // تحديث المسار إذا تغير الموقع بشكل كبير
              if (driverLocation == null ||
                  Geolocator.distanceBetween(
                      driverLocation.latitude,
                      driverLocation.longitude,
                      newDriverLocation.latitude,
                      newDriverLocation.longitude) > 20) {
                updateRoutePolyline(currentState.order, newDriverLocation);
              }
            }
          }
        }
      }
    }, onError: (error) {
      if (!isClosed) {
        emit(OrderError(message: "خطأ في تتبع السائق: $error"));
      }
    });
  }

  double _getBearing(double startLat, double startLng, double endLat, double endLng) {
    startLat = startLat * pi / 180;
    startLng = startLng * pi / 180;
    endLat = endLat * pi / 180;
    endLng = endLng * pi / 180;

    double dLon = endLng - startLng;
    double y = sin(dLon) * cos(endLat);
    double x = cos(startLat) * sin(endLat) - sin(startLat) * cos(endLat) * cos(dLon);
    double bearing = atan2(y, x);

    // تحويل إلى درجات
    bearing = bearing * 180 / pi;
    bearing = (bearing + 360) % 360;

    return bearing;
  }

  void updateDriverMarkerWithRotation(FireBaseOrder order, LatLng newDriverLocation, double bearing) {
    if (isClosed) return;

    // إنشاء نسخة جديدة من مجموعة الماركرز
    Set<maps.Marker> updatedMarkers = _generateMarkers(order);

    // إزالة ماركر السائق إذا كان موجودًا
    updatedMarkers.removeWhere((marker) => marker.markerId.value == "driver");

    // إضافة ماركر السائق الجديد
    updatedMarkers.add(maps.Marker(
      markerId: MarkerId("driver"),
      position: newDriverLocation,
      icon: carIcon ?? BitmapDescriptor.defaultMarker,
      rotation: bearing,
      anchor: Offset(0.5, 0.5),
      infoWindow: InfoWindow(title: "السائق"),
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

    try {
      String url = "https://router.project-osrm.org/route/v1/driving/${driverLocation.longitude},${driverLocation.latitude};${userLocation.longitude},${userLocation.latitude}?geometries=geojson";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200 && !isClosed) {
        final data = json.decode(response.body);
        List<dynamic> coordinates = data["routes"][0]["geometry"]["coordinates"];
        List<LatLng> polylineCoordinates = coordinates
            .map((coord) => LatLng(coord[1], coord[0]))
            .toList();

        final currentState = state;
        if (currentState is OrderLoaded) {
          Set<Polyline> updatedPolylines = Set.from(currentState.polylines);

          // إزالة المسار الحالي إذا كان موجودًا
          updatedPolylines.removeWhere(
                  (polyline) => polyline.polylineId.value == "actual_route");

          // إضافة المسار الجديد
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
    } catch (e) {
      print("خطأ أثناء تحديث المسار: $e");
      // لا نصدر حالة خطأ هنا لأن هذا خطأ غير حرج
    }
  }
  LatLng _getOffsetLocation(LatLng baseLocation, double offset) {
    return LatLng(baseLocation.latitude + offset, baseLocation.longitude + offset);
  }

}
