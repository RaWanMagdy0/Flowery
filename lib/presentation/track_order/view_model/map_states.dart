import 'package:flutter_html/flutter_html.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../domain/entities/pending_orders/order_entity.dart';
import '../../../domain/entities/fire_base/fire_base_order.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;

sealed class PendingOrderState {}
class OrderStateInitial extends PendingOrderState {}

class OrderStateLoading extends PendingOrderState {}

//getAllPendingOrders
final class PendingGetOrdersSuccessState extends PendingOrderState {
  final List<OrderEntityDriver?> orders;

  PendingGetOrdersSuccessState({required this.orders});
}

final class PendingGetOrdersErrorState extends PendingOrderState {
  final String? errorMessage;

  PendingGetOrdersErrorState({this.errorMessage});
}
class OrderLoaded extends PendingOrderState {
  final FireBaseOrder order;
  final Set<maps.Marker> markers;
  final Set<Polyline> polylines;
  final LatLng? driverLocation;
  final double? bearing;

  OrderLoaded({
    required this.order,
    required this.markers,
    required this.polylines,
    this.driverLocation,
    this.bearing,
  });
}

  class OrderError extends PendingOrderState {
  final String? message;
  OrderError({this.message});
  }


