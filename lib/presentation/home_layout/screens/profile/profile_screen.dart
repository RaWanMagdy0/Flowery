import 'package:flutter/material.dart';

import '../../../../core/local/token_manger.dart';
import '../../../../core/routes/page_route_name.dart';
import '../../../../core/utils/widget/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String token = '';

  @override
  void initState() {
    super.initState();
    getToken();
  }

  void getToken() async {
    token = await TokenManager.getToken() ?? '';

    setState(() {
      token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: token.isNotEmpty
            ? CustomButton(
                onPressed: () {
                  TokenManager.deleteToken();
                  Navigator.of(context).pushReplacementNamed(
                    PageRouteName.logIn,
                  );
                },
                text: "log out",
              )
            : const Text("You are not logged in"),
      ),
    );
  }
}
