import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppbar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.fontSize = 22,
  });

  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final double fontSize;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                HugeIcons.strokeRoundedArrowLeft01,
                color: Colors.black,
              ),
              onPressed: () => context.pop(),
            )
          : null,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "Poppins",
          color: Colors.black,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: actions,
    );
  }
}
