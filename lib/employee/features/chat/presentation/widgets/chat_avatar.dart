import 'package:flutter/material.dart';

class ChatAvatar extends StatelessWidget {
  final String? avatarUrl;
  final String fallbackText;
  final double size;
  final double borderRadius;
  final bool isOnline;
  final double onlineDotSize;

  const ChatAvatar({
    super.key,
    this.avatarUrl,
    required this.fallbackText,
    this.size = 60,
    this.borderRadius = 20,
    this.isOnline = false,
    this.onlineDotSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          clipBehavior: Clip.antiAlias,
          child: avatarUrl != null
              ? Image.network(
                  avatarUrl!,
                  fit: BoxFit.cover,
                  width: size,
                  height: size,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Text(
                      fallbackText,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size * 0.3,
                      ),
                    ),
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: Text(
                        fallbackText,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size * 0.3,
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    fallbackText,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: size * 0.3,
                    ),
                  ),
                ),
        ),
        if (isOnline)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: onlineDotSize,
              height: onlineDotSize,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
