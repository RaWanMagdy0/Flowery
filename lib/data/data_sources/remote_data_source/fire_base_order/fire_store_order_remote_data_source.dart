
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery/core/api/execute_api_call.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
@injectable
class FireStoreOrderRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Result<Map<String, dynamic>>> fetchOrderData(String orderId) async {
    return await executeApiCall<Map<String, dynamic>>(() async {
      var response = await _firestore.collection('orders').doc(orderId).get();
      return response.data() ?? {};
    });
  }
}
