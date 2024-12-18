import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/api/order_api/order_api_manager.dart';
import 'package:flowery/data/data_sources/remote_data_source/order/order_remote_data_source.dart';
import 'package:flowery/data/data_sources/remote_data_source/order/order_remote_data_source_impl.dart';
import 'package:flowery/data/models/order/request/create_order_request/create_order_request.dart';
import 'package:flowery/data/models/order/response/create_order_response/order_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([OrderApiManger])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockOrderApiManger mockOrderApiManger;
  late OrderRemoteDataSourceImpl dataSource;

  setUp(() {
    mockOrderApiManger = MockOrderApiManger();
    dataSource = OrderRemoteDataSourceImpl(apiManger: mockOrderApiManger);
  });

  group("OrderRemoteDataSourceImpl", () {
    const token = "123456";
    final testOrderRequest = CreateOrderRequest();
    final testResponseOrder = OrderModel();
    const testFailMessage = "Failed to create order.";

    test("should CreateOrder successfully when API call succeeds", () async{
      when(mockOrderApiManger.createOrder(token, testOrderRequest))
          .thenAnswer((_) async =>  testResponseOrder);

      final result =await dataSource.createOrder(testOrderRequest);
      expect(result, isA<Success<OrderModel?>>());
      expect((result as Success<OrderModel?>).data, testResponseOrder);
    });
    test('createOrder throws an exception when token is missing', () async {
      when(mockOrderApiManger.createOrder(any, any)).thenThrow(Exception(testFailMessage));

      final result =await dataSource.createOrder(testOrderRequest);
      expect(result, isA<Fail<OrderModel?>>());
      expect((result as Fail<OrderModel?>).exception.toString(),
          contains(testFailMessage));
    });
  }

  );
}
