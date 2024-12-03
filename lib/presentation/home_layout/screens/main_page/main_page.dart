import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../cart/view/cart_screen.dart';
import '../cart/view_model/cart_view_model.dart';
import '../categories/view/categories_screen.dart';
import '../categories/view_model/categories_view_model.dart';
import '../home/view/home_screen.dart';
import '../home/view_model/home_view_model.dart';
import '../profile/profile_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<CartViewModel>().checkLoggedUser();
  }

  final List<Widget> _screens = [
    BlocProvider(
      create: (context) => getIt<HomeViewModel>(),
      child: HomeScreen(),
    ),
    BlocProvider(
      create: (context) => getIt<CategoriesViewModel>()..loadFlowers(),
      child: CategoriesScreen(),
    ),
    CartScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
