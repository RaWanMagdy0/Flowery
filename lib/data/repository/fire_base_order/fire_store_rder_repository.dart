import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../domain/entities/fire_base/fire_base_order.dart';
import '../../data_sources/remote_data_source/fire_base_order/fire_store_order_remote_data_source.dart';
@injectable
class FireStoreOrderRepository {
  final FireStoreOrderRemoteDataSource remoteDataSource;
  FireStoreOrderRepository(this.remoteDataSource);

  Future<Result<FireBaseOrder?>> fetchOrderDetails(String orderId) async {
    final response = await remoteDataSource.fetchOrderData(orderId);

    switch (response) {
      case Success():
        final data = response.data;
        if (data == null || !data.containsKey('store')) {
          return Fail(exception: Exception("Invalid order data"));
        }

        return Success(
          data: FireBaseOrder(
            id: orderId,
            storeLocation: LatLng(
              double.parse(data['store']['latLong'].split(',')[0]),
              double.parse(data['store']['latLong'].split(',')[1]),
            ),
          ),
        );

      case Fail():
        return Fail(exception: response.exception);
    }
  }
}
