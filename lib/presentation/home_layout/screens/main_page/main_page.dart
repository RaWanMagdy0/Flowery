import 'package:flowery/presentation/home_layout/screens/cart/cart_screen.dart';
import 'package:flowery/presentation/home_layout/screens/categories/categories_screen.dart';
import 'package:flowery/presentation/home_layout/screens/home/home_screen.dart';
import 'package:flowery/presentation/home_layout/screens/profile/profile_screen.dart';
import 'package:flowery/presentation/home_layout/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    CategoriesScreen(),
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
