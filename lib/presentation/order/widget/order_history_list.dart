import 'package:flutter/material.dart';
import '../../../domain/entities/order/create_order/order_entity.dart';
import 'custom_order_card.dart';

class OrderHistoryList extends StatelessWidget {
  final List<OrderEntity?> orders;

  const OrderHistoryList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final orderItems = order?.orderItems ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: orderItems.length,
              itemBuilder: (context, itemIndex) {
                final orderItem = orderItems[itemIndex];
                return CustomOrderCard(
                  orderItem: orderItem,
                  order: order,
                  product: orderItem.product,
                );
              },
            ),
          ],
        );
      },
    );
  }
}