import 'package:flutter/material.dart';

class ActiveIndexNotifier extends ChangeNotifier {
  int _activeIndex = 0;

  int get activeIndex => _activeIndex;

  void setActiveIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }
}