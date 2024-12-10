import 'package:flutter/material.dart';

class LocalProvider extends ChangeNotifier {
  String locale = "en";

  changeLanguage(String langCode) {
    locale = langCode;
    notifyListeners();
  }
}
