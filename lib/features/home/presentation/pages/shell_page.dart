// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/core/constants.dart';
import 'package:koala/core/widgets/navbar_item.dart';
import 'package:go_router/go_router.dart';

class ShellPage extends StatefulWidget {
  final Widget child;

  const ShellPage({super.key, required this.child});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index, String path) {
    setState(() {
      _selectedIndex = index;
    });
    context.go(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        children: [
          widget.child,
          Positioned(
            top: 30,
            left: 16,
            child: const Text(
              'KOALA',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: ThemeConstants.primaryColor,
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
                  unSelectedIcon: HugeIcons.strokeRoundedHome01,
                  selectedIcon: HugeIcons.strokeRoundedHome01,
                  isSelected: _selectedIndex == 0,
                  onTap: () => _onItemTapped(0, '/explore'),
                ),
                NavItem(
                  index: 1,
                  unSelectedIcon: HugeIcons.strokeRoundedWork,
                  selectedIcon: HugeIcons.strokeRoundedWork,
                  isSelected: _selectedIndex == 1,
                  onTap: () => _onItemTapped(1, '/my-jobs'),
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
