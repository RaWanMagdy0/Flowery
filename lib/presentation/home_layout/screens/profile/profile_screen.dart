import 'package:flutter/material.dart';

import '../../../../core/local/token_manger.dart';
import '../../../../core/routes/page_route_name.dart';
import '../../../../core/utils/widget/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          onPressed: () {
            TokenManger.deleteToken();
            Navigator.of(context).pushReplacementNamed(
              PageRouteName.logIn,
            );
          },
          text: "log out",
        ),
      ),
    );
  }
}
