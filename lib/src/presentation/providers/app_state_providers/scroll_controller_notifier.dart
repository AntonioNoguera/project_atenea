import 'package:flutter/material.dart';

class ScrollControllerNotifier extends ChangeNotifier {
  final ScrollController _scrollController = ScrollController();
  bool _isButtonCollapsed = false;

  ScrollControllerNotifier() {
    _scrollController.addListener(_checkStateToggle);
  }

  ScrollController get scrollController => _scrollController;
  bool get isButtonCollapsed => _isButtonCollapsed;

  void _checkStateToggle() {
    if (_scrollController.offset >= 50 && !_isButtonCollapsed) {
      _isButtonCollapsed = true;
      notifyListeners();
    } else if (_scrollController.offset < 50 && _isButtonCollapsed) {
      _isButtonCollapsed = false;
      notifyListeners();
    }
  }

  void setButtonCollapsed () { 
    if (_isButtonCollapsed && _scrollController.offset <= 50) {
      _isButtonCollapsed = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}