import 'package:flowery/core/utils/functions/dialogs/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/cart_view_model.dart';
import 'widgets/cart_app_bar.dart';
import 'widgets/cart_empty_widget.dart';
import 'widgets/cart_login_widget.dart';
import 'widgets/cart_products_list.dart';
import 'widgets/cart_total_price_and_checkout_button.dart';
import 'widgets/cat_products_loading.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CartAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CartViewModel>().getCartProducts();
        },
        child: BlocConsumer<CartViewModel, CartState>(
          bloc: context.read<CartViewModel>()..getCartProducts(),
          buildWhen: (previous, current) =>
              current is! UpdateCartProductQuantityLoading,
          listenWhen: (previous, current) {
            if (current is UpdateCartProductQuantityLoading) {
              AppDialogs.showLoading(context: context);
            } else if (previous is UpdateCartProductQuantityLoading) {
              Navigator.pop(context);
            }
            return true;
          },
          listener: (context, state) {},
          builder: (context, state) {
            if (state is NoUserLogged) {
              return CartLoginWidget();
            } else if (state is CartLoading) {
              return CartProductsLoading();
            } else if (state is CartEmpty) {
              return CartEmptyWidget();
            } else if (state is CartLoaded) {
              return CartProductsList(
                cartProducts: state.data?.products ?? [],
              );
            } else if (state is CartError) {
              return Center(
                child: Text(state.errorMessage),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      bottomNavigationBar: TotalPriceAndCheckoutButton(),
    );
  }
}
