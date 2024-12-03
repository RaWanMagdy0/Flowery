import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../domain/entities/cart/cart_product_entity.dart';
import 'cart_product_item.dart';

class CartProductsList extends StatelessWidget {
  final List<CartProduct> cartProducts;

  const CartProductsList({super.key, required this.cartProducts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 24.h, left: 16.w, right: 16.w),
      itemCount: cartProducts.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: index == 4 ? 0 : 24.h),
        child: CartProductItem(
          cartProduct: cartProducts[index],
        ),
      ),
    );
  }
}
