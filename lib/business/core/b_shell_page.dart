import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/business/core/widgets/b_nav_item.dart';
import 'package:koala/business/features/home/presentation/providers/b_page_provider.dart';
import 'package:koala/product/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BShellPage extends StatelessWidget {
  final Widget child;

  const BShellPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BPageProvider(),
      child: Consumer<BPageProvider>(
        builder: (context, pageProvider, _) {
          final currentLocation = GoRouterState.of(context).matchedLocation;

          return Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            appBar: appBar(context),
            drawer: drawer(context),
            body: child,
            bottomNavigationBar: SafeArea(
              child: Container(
                height: 76,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: BNavItem(
                          index: 0,
                          label: 'Ana Sayfa',
                          isSelected: currentLocation == '/business/home',
                          onTap: () => context.go('/business/home'),
                          unSelectedIcon: HugeIcons.strokeRoundedHome01,
                          selectedIcon: HugeIcons.strokeRoundedHome02,
                        ),
                      ),
                      Expanded(
                        child: BNavItem(
                          index: 1,
                          label: 'İş İlanlar',
                          isSelected: currentLocation == '/business/posts',
                          onTap: () => context.go('/business/posts'),
                          unSelectedIcon: HugeIcons.strokeRoundedWork,
                          selectedIcon: HugeIcons.strokeRoundedWork,
                        ),
                      ),
                      Expanded(
                        child: BNavItem(
                          index: 2,
                          isSelected: currentLocation == '/capture',
                          onTap: () => context.push('/capture'),
                          unSelectedIcon: HugeIcons.strokeRoundedPlusSign,
                          selectedIcon: HugeIcons.strokeRoundedPlusSign,
                          centerItem: true,
                        ),
                      ),
                      Expanded(
                        child: BNavItem(
                          index: 3,
                          label: 'Sohbetler',
                          isSelected: currentLocation == '/chat',
                          onTap: () => context.go('/chat'),
                          unSelectedIcon: HugeIcons.strokeRoundedBubbleChat,
                          selectedIcon: HugeIcons.strokeRoundedBubbleChat,
                        ),
                      ),

                      Expanded(
                        child: BNavItem(
                          index: 4,
                          label: 'Profil',
                          isSelected: currentLocation == '/business/profile',
                          onTap: () => context.go('/business/profile'),
                          unSelectedIcon: HugeIcons.strokeRoundedUser,
                          selectedIcon: HugeIcons.strokeRoundedUser,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar appBar(BuildContext context) => AppBar(
    title: const Text(
      'KOALA',
      style: TextStyle(
        fontFamily: 'Poppins',
        color: AppColors.primaryColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: false,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedMenu01,
            color: Colors.black,
          ),
        );
      },
    ),
  );

  Drawer drawer(BuildContext context) => Drawer(
    child: SafeArea(
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 70, left: 10, bottom: 10),
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'KOALA',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        TextSpan(
                          text: 'SMILE',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: HugeIcon(
                    icon: HugeIcons.strokeRoundedUser,
                    color: Colors.black,
                  ),
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/profile');
                  },
                ),
                ListTile(
                  leading: HugeIcon(
                    icon: HugeIcons.strokeRoundedStethoscope,
                    color: Colors.black,
                  ),
                  title: const Text('Medical Assessment'),
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/analysis');
                  },
                ),
                ListTile(
                  leading: HugeIcon(
                    icon: HugeIcons.strokeRoundedGlobe,
                    color: Colors.black,
                  ),
                  title: const Text('Language'),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Show language picker
                  },
                ),
                ListTile(
                  leading: HugeIcon(
                    icon: HugeIcons.strokeRoundedSchoolBell01,
                    color: Colors.black,
                  ),
                  title: const Text('Notifications'),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Show language picker
                  },
                ),
                ListTile(
                  leading: HugeIcon(
                    icon: HugeIcons.strokeRoundedShield01,
                    color: Colors.black,
                  ),
                  title: const Text('Privacy & Terms'),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Show privacy & terms
                  },
                ),
                ListTile(
                  leading: HugeIcon(
                    icon: HugeIcons.strokeRoundedHoldPhone,
                    color: Colors.black,
                  ),
                  title: const Text('Contact Us'),
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/contact');
                  },
                ),
              ],
            ),
          ),
          // Logout at bottom
          const Divider(height: 1),
          ListTile(
            leading: HugeIcon(
              icon: HugeIcons.strokeRoundedLogout01,
              color: Colors.red,
            ),
            title: const Text('Log Out', style: TextStyle(color: Colors.red)),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('is_logged_in', false);
              await prefs.remove('user_type');

              if (context.mounted) {
                context.go('/authgate');
              }
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    ),
  );
}
