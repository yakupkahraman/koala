import 'package:flutter/material.dart';
import 'package:koala/core/constants.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.isReversed = false,
  });

  final VoidCallback onPressed;
  final String title;
  final bool? isReversed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(UiConstants.borderRadius),
            ),
            backgroundColor: isReversed!
                ? Colors.white
                : ThemeConstants.primaryColor,
            overlayColor: !isReversed! ? Colors.green[50] : null,
            padding: const EdgeInsets.all(12.0),
            side: isReversed!
                ? BorderSide(color: ThemeConstants.primaryColor, width: 3.0)
                : null,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: isReversed! ? ThemeConstants.primaryColor : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
