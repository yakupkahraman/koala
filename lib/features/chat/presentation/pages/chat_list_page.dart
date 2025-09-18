import 'package:flutter/material.dart';
import 'package:koala/core/constants.dart';
import 'package:koala/features/chat/presentation/widgets/chat_list_tile.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final List<Map<String, dynamic>> chatList = [
    {
      'id': '1',
      'name': 'Ahmet Yılmaz',
      'lastMessage': 'Merhaba, nasılsın?',
      'time': '14:30',
      'unreadCount': 2,
      'avatar': 'A',
      'isOnline': true,
    },
    {
      'id': '2',
      'name': 'Ayşe Kaya',
      'lastMessage': 'Yarın buluşalım mı?',
      'time': '13:45',
      'unreadCount': 0,
      'avatar': 'A',
      'isOnline': false,
    },
    {
      'id': '3',
      'name': 'Mehmet Demir',
      'lastMessage': 'Dosyayı gönderdim',
      'time': '12:20',
      'unreadCount': 1,
      'avatar': 'M',
      'isOnline': true,
    },
    {
      'id': '4',
      'name': 'Fatma Özkan',
      'lastMessage': 'Teşekkürler!',
      'time': 'Dün',
      'unreadCount': 0,
      'avatar': 'F',
      'isOnline': false,
    },
    {
      'id': '5',
      'name': 'Ali Çelik',
      'lastMessage': 'Proje nasıl gidiyor?',
      'time': 'Dün',
      'unreadCount': 3,
      'avatar': 'A',
      'isOnline': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Sohbetlerim",
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: UiConstants.defaultPadding,
        ),
        child: ListView.builder(
          itemCount: chatList.length,
          itemBuilder: (context, index) {
            final chat = chatList[index];
            return ChatListTile(chat: chat);
          },
        ),
      ),
    );
  }
}
