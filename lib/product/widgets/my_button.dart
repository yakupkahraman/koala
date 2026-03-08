import 'package:flutter/material.dart';
import 'package:koala/product/constants/app_radius.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.isReversed = false,
    this.isLoading = false,
  });

  final VoidCallback onPressed;
  final String title;
  final bool? isReversed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.primaryCircular,
            ),
            backgroundColor: isReversed!
                ? Colors.white
                : Theme.of(context).colorScheme.primary,
            disabledBackgroundColor: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.7),
            overlayColor: !isReversed! ? Colors.green[50] : null,
            padding: const EdgeInsets.all(12.0),
            side: isReversed!
                ? BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 3.0,
                  )
                : null,
          ),
          child: isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: isReversed!
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white,
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: isReversed!
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
      ),
    );
  }
}
