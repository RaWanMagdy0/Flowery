import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/images/app_images.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/Logo.png',
                  height: 25,
                  width: 89,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0), // Modified padding
            child: Row(
              children: [
                ImageIcon(
                  AssetImage(AppImages.location),
                  color: AppColors.kGray,
                ),
                SizedBox(width: 6), // Smaller spacing
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Deliver to ',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '2XVP+XC - Sheikh Zayed',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.kPink,
                      ),
                    ],
                  ),
                ),
                // Added dropdown icon
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text('Home Screen'),
            ),
          ),
        ],
      ),
    );
  }
}
