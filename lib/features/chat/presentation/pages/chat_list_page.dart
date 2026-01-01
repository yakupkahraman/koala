import 'package:flutter/material.dart';
import 'package:koala/features/chat/data/chat_service.dart';
import 'package:koala/features/chat/domain/chat.dart';
import 'package:koala/features/chat/presentation/widgets/chat_list_tile.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final ChatService _chatService = ChatService();
  late List<Chat> chatList;

  @override
  void initState() {
    super.initState();
    chatList = _chatService.getChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
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
      body: ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          final chat = chatList[index];
          return ChatListTile(chat: chat);
        },
      ),
    );
  }
}
