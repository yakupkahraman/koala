import 'package:flutter/material.dart';
import 'package:koala/core/constants.dart';

class MessageBubble extends StatelessWidget {
  final Map<String, dynamic> message;
  final bool isPreviousSameSender;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isPreviousSameSender,
  });

  @override
  Widget build(BuildContext context) {
    final isMe = message['isMe'];

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: isPreviousSameSender
              ? 4
              : 12, // 2'den 4'e, 8'den 12'ye çıkardım
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isMe ? ThemeConstants.primaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message['message'],
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Text(
              message['time'],
              style: TextStyle(
                color: isMe ? Colors.white70 : Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
