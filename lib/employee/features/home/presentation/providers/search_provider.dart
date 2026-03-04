import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  String _query = '';
  bool _isSearching = false;

  String get query => _query;
  bool get isSearching => _isSearching;

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void startSearching() {
    _isSearching = true;
    notifyListeners();
  }

  void stopSearching() {
    _isSearching = false;
    _query = '';
    notifyListeners();
  }

  void clearQuery() {
    _query = '';
    notifyListeners();
  }
}
