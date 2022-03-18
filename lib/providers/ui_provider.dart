import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {

  int screenIndex = 0;

  setScreenIndex(int i) {
    screenIndex = i;
    notifyListeners();
  }

}