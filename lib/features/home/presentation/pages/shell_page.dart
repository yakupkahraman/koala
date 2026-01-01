// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/core/constants.dart';
import 'package:koala/core/widgets/navbar_item.dart';
import 'package:go_router/go_router.dart';
import 'package:koala/features/home/presentation/providers/page_provider.dart';
import 'package:koala/features/home/presentation/pages/explore_pages/explore_page.dart';
import 'package:koala/features/jobs/presentation/pages/jobs_page.dart';
import 'package:koala/features/chat/presentation/pages/chat_list_page.dart';
import 'package:koala/features/profile/presentation/pages/profile_page.dart';
import 'package:provider/provider.dart';

class ShellPage extends StatefulWidget {
  final Widget child;

  const ShellPage({super.key, required this.child});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  // State korunması için sayfaları burada tanımla
  static const List<Widget> _pages = [
    ExplorePage(),
    JobsPage(),
    ChatListPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index, String path) {
    if (index == 0) {
      // Home butonuna basıldığında
      final pageProvider = Provider.of<PageProvider>(context, listen: false);

      if (_selectedIndex != 0) {
        // Diğer sayfalardan home'a geliyorsa -> map göster
        pageProvider.setExploreViewToMap();
      } else {
        // Zaten home'dayken tekrar basıldıysa -> toggle yap
        pageProvider.toggleExploreView();
      }
    }

    if (index == 1) {
      // Jobs butonuna basıldığında
      final pageProvider = Provider.of<PageProvider>(context, listen: false);

      if (_selectedIndex != 1) {
        // Diğer sayfalardan jobs'a geliyorsa -> home göster
        pageProvider.setJobsViewType(JobsViewType.home);
      } else {
        // Zaten jobs'dayken tekrar basıldıysa -> toggle yap
        pageProvider.toggleJobsView();
      }
    }

    setState(() {
      _selectedIndex = index;
    });

    // PageView'i animasyon olmadan değiştir
    _pageController.jumpToPage(index);

    context.go(path);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // URL'e göre index'i güncelle
    final location = GoRouterState.of(context).matchedLocation;
    int newIndex = 0;
    switch (location) {
      case '/explore':
        newIndex = 0;
        break;
      case '/jobs':
        newIndex = 1;
        break;
      case '/chat':
        newIndex = 2;
        break;
      case '/profile':
        newIndex = 3;
        break;
    }

    if (_selectedIndex != newIndex) {
      setState(() {
        _selectedIndex = newIndex;
      });

      // PageController'ı güncelle
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          newIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        children: [
          // PageView ile sayfaları yönet
          PageView(
            controller: _pageController,
            physics:
                const NeverScrollableScrollPhysics(), // Sadece programmatik geçiş
            children: _pages,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 36, right: 36),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UiConstants.borderRadius),
            color: ThemeConstants.primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                NavItem(
                  index: 0,
                  unSelectedIcon: _selectedIndex == 0
                      ? (context.watch<PageProvider>().exploreViewType ==
                                ExploreViewType.map
                            ? HugeIcons.strokeRoundedNavigation05
                            : HugeIcons.strokeRoundedListView)
                      : HugeIcons.strokeRoundedNavigation05,
                  selectedIcon: _selectedIndex == 0
                      ? (context.watch<PageProvider>().exploreViewType ==
                                ExploreViewType.map
                            ? HugeIcons.strokeRoundedNavigation05
                            : HugeIcons.strokeRoundedListView)
                      : HugeIcons.strokeRoundedNavigation05,
                  isSelected: _selectedIndex == 0,
                  onTap: () => _onItemTapped(0, '/explore'),
                ),
                NavItem(
                  index: 1,
                  unSelectedIcon: _selectedIndex == 1
                      ? (context.watch<PageProvider>().jobsViewType ==
                                JobsViewType.home
                            ? HugeIcons.strokeRoundedWork
                            : HugeIcons.strokeRoundedBookmark02)
                      : HugeIcons.strokeRoundedWork,
                  selectedIcon: _selectedIndex == 1
                      ? (context.watch<PageProvider>().jobsViewType ==
                                JobsViewType.home
                            ? HugeIcons.strokeRoundedWork
                            : HugeIcons.strokeRoundedBookmark02)
                      : HugeIcons.strokeRoundedWork,
                  isSelected: _selectedIndex == 1,
                  onTap: () => _onItemTapped(1, '/jobs'),
                ),
                NavItem(
                  index: 2,
                  unSelectedIcon: HugeIcons.strokeRoundedBubbleChat,
                  selectedIcon: HugeIcons.strokeRoundedBubbleChat,
                  isSelected: _selectedIndex == 2,
                  onTap: () => _onItemTapped(2, '/chat'),
                ),
                NavItem(
                  index: 3,
                  unSelectedIcon: HugeIcons.strokeRoundedUser,
                  selectedIcon: HugeIcons.strokeRoundedUser,
                  isSelected: _selectedIndex == 3,
                  onTap: () => _onItemTapped(3, '/profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
