import 'package:flutter/cupertino.dart';
import '../../../domain/entities/home_layout/product_details_entity.dart';
import '../../../domain/entities/order/create_order/order_item_entity.dart';
import 'custom_order_card.dart';

class OrderHistoryList extends StatelessWidget {
  OrderHistoryList({super.key, required this.orderItems});
  final List<OrderItemEntity> orderItems;
  ProductDetailsEntity? productDetailsEntity;

  @override
  Widget build(BuildContext context) {
    if (orderItems.isEmpty) {
      return Center(child: Text("No orders."));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: orderItems.length,
      itemBuilder: (context, index) {
        final item = orderItems[index];
        final product = productDetailsEntity?.products?.firstWhere(
          (p) => p.id == item.id,
          orElse: () => ProductEntity(id: '', title: 'Unknown Product'),
        );

        return CustomOrderCard(
          price: item.price ?? 0,
          orderNumber: item.id ?? "",
          productName: product?.title ?? "",
        );
      },
    );
  }
}
