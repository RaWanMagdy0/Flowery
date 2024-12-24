import 'package:flutter/material.dart';
import '../../../domain/entities/order/create_order/order_response_entity.dart';
import 'custom_order_card.dart';

class OrderHistoryList extends StatefulWidget {
  final List<OrderItemEntity> orderItems;
  final OrderEntity? order;

  const OrderHistoryList({super.key, required this.orderItems,required this.order});

  @override
  State<OrderHistoryList> createState() => _OrderHistoryListState();
}

class _OrderHistoryListState extends State<OrderHistoryList> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: widget.orderItems.length,
      itemBuilder: (context, index) {
        var orderItem = widget.orderItems[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomOrderCard(
              orderItem: orderItem,
              order: widget.order,
            ),
          ],
        );
      },
    );
  }
}
