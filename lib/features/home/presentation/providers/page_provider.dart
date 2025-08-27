import 'package:flutter/material.dart';

enum ExploreViewType { map, list }

class PageProvider with ChangeNotifier {
  ExploreViewType _exploreViewType = ExploreViewType.map;

  ExploreViewType get exploreViewType => _exploreViewType;

  // Explore view type değiştirme
  void setExploreViewType(ExploreViewType viewType) {
    if (_exploreViewType != viewType) {
      _exploreViewType = viewType;
      notifyListeners();
    }
  }

  void toggleExploreView() {
    setExploreViewType(
      _exploreViewType == ExploreViewType.map
          ? ExploreViewType.list
          : ExploreViewType.map,
    );
  }

  // PageProvider'a eklenecek metodlar
  void setExploreViewToMap() {
    _exploreViewType = ExploreViewType.map;
    notifyListeners();
  }

  void setExploreViewToList() {
    _exploreViewType = ExploreViewType.list;
    notifyListeners();
  }
}
