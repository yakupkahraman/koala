import 'package:flutter/material.dart';
import 'package:koala/core/constants.dart';
import 'package:koala/features/chat/data/chat_service.dart';
import 'package:koala/features/chat/domain/chat.dart';
import 'package:koala/features/chat/domain/message.dart';
import 'package:koala/features/chat/presentation/widgets/message_bubble.dart';
import 'package:koala/features/chat/presentation/widgets/message_textfield.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;

  const ChatPage({super.key, required this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  late List<Message> messages;

  @override
  void initState() {
    super.initState();
    messages = _chatService.getMessages(widget.chat.id);
    _chatService.markChatAsRead(widget.chat.id);
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _chatService.sendMessage(
          widget.chat.id,
          _messageController.text.trim(),
        );
        messages = _chatService.getMessages(widget.chat.id);
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(UiConstants.defaultPadding),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isMe = message.isMe;

                final isNextSameSender =
                    index < messages.length - 1 &&
                    messages[index + 1].isMe == isMe;

                return MessageBubble(
                  message: message,
                  isNextSameSender: isNextSameSender,
                );
              },
            ),
          ),
          MessageTextField(
            controller: _messageController,
            onSendMessage: _sendMessage,
            onAddPressed: () {
              // Ek menü işlemleri (dosya ekleme, galeri vb.)
            },
          ),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: ThemeConstants.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    widget.chat.avatar,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              if (widget.chat.isOnline)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.chat.name,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (widget.chat.isOnline)
                const Text(
                  'Çevrimiçi',
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
            ],
          ),
        ],
      ),
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.call, color: Colors.black),
      //     onPressed: () {},
      //   ),
      // ],
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
