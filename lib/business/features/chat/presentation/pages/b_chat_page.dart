import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/business/features/chat/data/b_chat_service.dart';
import 'package:koala/employee/features/chat/domain/chat.dart';
import 'package:koala/employee/features/chat/domain/message.dart';
import 'package:koala/employee/features/chat/presentation/widgets/chat_avatar.dart';
import 'package:koala/employee/features/chat/presentation/widgets/message_bubble.dart';
import 'package:koala/employee/features/chat/presentation/widgets/message_textfield.dart';
import 'package:koala/product/constants/app_padding.dart';

class BChatPage extends StatefulWidget {
  final Chat chat;

  const BChatPage({super.key, required this.chat});

  @override
  State<BChatPage> createState() => _BChatPageState();
}

class _BChatPageState extends State<BChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final BChatService _chatService = BChatService();
  final ScrollController _scrollController = ScrollController();
  late List<Message> messages;

  @override
  void initState() {
    super.initState();
    messages = _chatService.getMessages(widget.chat.id);
    _chatService.markChatAsRead(widget.chat.id);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
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
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: AppPadding.primaryAll,
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
            onAddPressed: () {},
          ),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(HugeIcons.strokeRoundedArrowLeft01, color: Colors.black),
        onPressed: () => context.pop(),
      ),
      title: Row(
        children: [
          ChatAvatar(
            avatarUrl: widget.chat.avatarUrl,
            fallbackText: widget.chat.avatar,
            size: 40,
            borderRadius: 14,
            isOnline: widget.chat.isOnline,
            onlineDotSize: 12,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chat.name,
                  overflow: TextOverflow.ellipsis,
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
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.green,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
