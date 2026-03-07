import 'package:flutter/material.dart';

class BPageProvider with ChangeNotifier {
  String _currentRoute = '/business/home';

  String get currentRoute => _currentRoute;

  void updateRoute(String route) {
    _currentRoute = route;
    notifyListeners();
  }
}
