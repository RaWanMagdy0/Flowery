import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/utils/widget/delivery_address_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../view_model/cart_view_model.dart';

class CartAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CartAppBar({super.key});

  @override
  State<CartAppBar> createState() => _CartAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 30.h);
}

class _CartAppBarState extends State<CartAppBar> {
  String city = 'Unknown City';
  String lat = '';
  String lang = '';

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  Future<void> _loadAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      city = prefs.getString('city') ?? 'Unknown City';
      lat = prefs.getString('lat') ?? '';
      lang = prefs.getString('lang') ?? '';
    });
    if (lat.isNotEmpty && lang.isNotEmpty) {
      double latitude = double.parse(lat);
      double longitude = double.parse(lang);
      String address = await getAddressFromCoordinates(latitude, longitude);
      setState(() {
        city = address;
      });
    }
  }

  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark placemark = placemarks[0];
    String address = '${placemark.name} , ${placemark.locality}';
    return address;
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return AppBar(
      forceMaterialTransparency: true,
      centerTitle: false,
      title: Row(
        children: [
          Text(local.cart),
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
          onTap: () {},
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: DeliveryAddressWidget(
            city: city,
          ),
        ),
      ),
    );
  }
}
