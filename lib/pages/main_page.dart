// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/constants.dart';
import 'package:koala/page_provider.dart';
import 'package:provider/provider.dart';
import 'package:koala/components/navbar_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, pageProvider, child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,

          body: Stack(
            children: [
              pageProvider.currentWidget,
              Positioned(
                top: 30,
                left: 16,
                child: const Text(
                  'KOALA',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: kMainGreenColor,
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 36, right: 36),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                color: kMainGreenColor,
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
                      unSelectedIcon: HugeIcons.strokeRoundedHome01,
                      selectedIcon: HugeIcons.strokeRoundedHome01,
                      isSelected: pageProvider.selectedIndex == 0,
                      onTap: pageProvider.goToExplore,
                    ),
                    NavItem(
                      index: 1,
                      unSelectedIcon: HugeIcons.strokeRoundedWork,
                      selectedIcon: HugeIcons.strokeRoundedWork,
                      isSelected: pageProvider.selectedIndex == 1,
                      onTap: pageProvider.goToJobs,
                    ),
                    NavItem(
                      index: 2,
                      unSelectedIcon: HugeIcons.strokeRoundedBubbleChat,
                      selectedIcon: HugeIcons.strokeRoundedBubbleChat,
                      isSelected: pageProvider.selectedIndex == 2,
                      onTap: pageProvider.goToChat,
                    ),
                    NavItem(
                      index: 3,
                      unSelectedIcon: HugeIcons.strokeRoundedUser,
                      selectedIcon: HugeIcons.strokeRoundedUser,
                      isSelected: pageProvider.selectedIndex == 3,
                      onTap: pageProvider.goToProfile,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
