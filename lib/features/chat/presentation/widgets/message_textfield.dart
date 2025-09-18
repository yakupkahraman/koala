import 'package:flutter/material.dart';
import 'package:koala/core/constants.dart';

class MessageTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSendMessage;
  final VoidCallback? onAddPressed;

  const MessageTextField({
    super.key,
    required this.controller,
    required this.onSendMessage,
    this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.grey[600], size: 18),
                onPressed: onAddPressed,
              ),
            ),
            Expanded(
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextFormField(
                  controller: controller,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: 'Mesaj yazın...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    suffixIcon: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: ThemeConstants.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.send, color: Colors.white, size: 18),
                        onPressed: onSendMessage,
                      ),
                    ),
                  ),
                  onFieldSubmitted: (_) => onSendMessage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
