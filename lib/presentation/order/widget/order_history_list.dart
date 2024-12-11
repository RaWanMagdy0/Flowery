import 'package:flutter/cupertino.dart';

import 'custom_order_card.dart';

class OrderHistoryList extends StatelessWidget {
  const OrderHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: 3,
      itemBuilder: (context, index) {
        return CustomOrderCard();
      },
    );
  }
}
