import 'package:flutter/material.dart';
import 'package:koala/product/widgets/my_button.dart';

class ButtonNavbar extends StatelessWidget {
  const ButtonNavbar({
    super.key,
    required this.onPressed,
    required this.title,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final String title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: MyButton(onPressed: onPressed, title: title, isLoading: isLoading),
    );
  }
}
