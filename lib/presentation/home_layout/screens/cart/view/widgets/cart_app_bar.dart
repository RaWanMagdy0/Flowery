import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/utils/widget/delivery_address_widget.dart';
import '../../view_model/cart_view_model.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      centerTitle: false,
      title: Row(
        children: [
          const Text('Cart'),
          BlocBuilder<CartViewModel, CartState>(
            builder: (context, state) {
              num cartItemsCount = context.read<CartViewModel>().cartItemsCount;

              return Text(
                cartItemsCount != 0 ? ' ($cartItemsCount items)' : '',
                style: AppFonts.font20GreyWeight500,
                textAlign: TextAlign.start,
              );
            },
          ),
        ],
      ),
      leadingWidth: 35.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: GestureDetector(
          onTap: () {
            // TODO: navigate to home screen
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<CartViewModel, CartState>(
          builder: (context, state) {
            if (state is NoUserLogged) {
              return SizedBox();
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: DeliveryAddressWidget(),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 30.h);
}
