import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/styles/colors/app_colors.dart';
import '../view_model/home_view_model.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_best_seller/home_best_seller_list.dart';
import 'widgets/home_categories/home_categories_list.dart';
import 'widgets/home_discover/home_discover_list.dart';
import 'widgets/home_occasions/home_occasions_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city = 'Unknown City';
  String lat = '';
  String lang = '';

  @override
  void initState() {
    super.initState();
    _loadAddress();
    context.read<HomeViewModel>().getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: HomeAppBar(
        city: city,
        lat: lat,
        lang: lang,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadAddress();
          context.read<HomeViewModel>().getHomeData();
        },
        backgroundColor: AppColors.kBabyPink,
        color: AppColors.kPink,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          children: [
            HomeDiscoverList(),
            24.verticalSpace,
            HomeCategoriesList(),
            24.verticalSpace,
            HomeBestSellerList(),
            24.verticalSpace,
            HomeOccasionsList(),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }

  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark placemark = placemarks[0];
    String address = '${placemark.name}, ${placemark.locality}';
    return address;
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

  Future<void> saveAddress(
      String city, String lat, String lang, String area) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('city', city);
    await prefs.setString('lat', lat);
    await prefs.setString('lang', lang);
    await prefs.setString('area', area);
  }
}
