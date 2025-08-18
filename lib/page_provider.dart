import 'package:flutter/material.dart';
import 'package:koala/pages/explore_page.dart';
import 'package:koala/pages/chat_page.dart';
import 'package:koala/pages/my_jobs_page.dart';
import 'package:koala/pages/profile_page.dart';

enum PageType { explore, jobs, chat, profile }

enum ExploreViewType { map, list }

class PageProvider with ChangeNotifier {
  PageType _currentPage = PageType.explore;
  ExploreViewType _exploreViewType = ExploreViewType.map;
  final Map<String, Widget> _cachedPages = {};

  PageType get currentPage => _currentPage;
  ExploreViewType get exploreViewType => _exploreViewType;
  int get selectedIndex => _currentPage.index;

  Widget get currentWidget {
    String cacheKey = _getCacheKey();

    // Lazy loading ile sayfaları yükle
    if (!_cachedPages.containsKey(cacheKey)) {
      _cachedPages[cacheKey] = _createPage(_currentPage);
    }
    return _cachedPages[cacheKey]!;
  }

  String _getCacheKey() {
    return _currentPage.name;
  }

  void setPage(PageType page) {
    if (_currentPage != page) {
      _currentPage = page;
      notifyListeners();
    }
  }

  void setSelectedIndex(int index) {
    if (index >= 0 && index < PageType.values.length) {
      setPage(PageType.values[index]);
    }
  }

  // Explore view type değiştirme
  void setExploreViewType(ExploreViewType viewType) {
    if (_exploreViewType != viewType) {
      _exploreViewType = viewType;
      notifyListeners();
    }
  }

  // Convenience methods
  void goToExplore({ExploreViewType? viewType}) {
    setPage(PageType.explore);
    if (viewType != null) {
      setExploreViewType(viewType);
    }
  }

  void goToJobs() => setPage(PageType.jobs);
  void goToChat() => setPage(PageType.chat);
  void goToProfile() => setPage(PageType.profile);

  void toggleExploreView() {
    setExploreViewType(
      _exploreViewType == ExploreViewType.map
          ? ExploreViewType.list
          : ExploreViewType.map,
    );
  }

  // Sayfa oluşturma factory
  Widget _createPage(PageType pageType) {
    switch (pageType) {
      case PageType.explore:
        return const ExplorePage();
      case PageType.jobs:
        return const MyJobsPage();
      case PageType.chat:
        return const ChatPage();
      case PageType.profile:
        return const ProfilePage();
    }
  }

  // Memory optimization - belirli sayfaları cache'den temizle
  void clearPageCache(PageType pageType) {
    _cachedPages.remove(pageType.name);
  }

  // Tüm cache'i temizle
  void clearAllCache() {
    _cachedPages.clear();
    notifyListeners();
  }

  // Cache durumunu kontrol et
  bool isPageCached(PageType pageType) {
    return _cachedPages.containsKey(pageType.name);
  }

  // Cache boyutunu al
  int get cacheSize => _cachedPages.length;
}
