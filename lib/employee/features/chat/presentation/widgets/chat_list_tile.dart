import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koala/employee/features/chat/domain/chat.dart';
import 'package:koala/employee/features/chat/presentation/widgets/chat_avatar.dart';

class ChatListTile extends StatelessWidget {
  final Chat chat;

  const ChatListTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/chat-detail', extra: chat);
      },
      child: Container(
        height: 74,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        margin: EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            ChatAvatar(
              avatarUrl: chat.avatarUrl,
              fallbackText: chat.avatar,
              size: 60,
              borderRadius: 20,
              isOnline: chat.isOnline,
              onlineDotSize: 16,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    chat.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    chat.lastMessage ?? '',
                    style: TextStyle(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat.timeString,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                if (chat.unreadCount > 0)
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      chat.unreadCount.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
