import 'package:flutter/material.dart';
import 'package:koala/core/constants.dart';
import 'package:koala/features/chat/presentation/widgets/message_bubble.dart';
import 'package:koala/features/chat/presentation/widgets/message_textfield.dart';

class ChatPage extends StatefulWidget {
  final Map<String, dynamic> chat;

  const ChatPage({super.key, required this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {'message': 'Merhaba! Nasılsın?', 'isMe': false, 'time': '14:25'},
    {
      'message': 'İyiyim teşekkürler, sen nasılsın?',
      'isMe': true,
      'time': '14:26',
    },
    {
      'message': 'Ben de iyiyim. Bugün ne yapıyorsun?',
      'isMe': false,
      'time': '14:27',
    },
    {'message': 'Projede çalışıyorum. Sen?', 'isMe': true, 'time': '14:28'},
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      final now = DateTime.now();
      final timeString =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
      setState(() {
        messages.add({
          'message': _messageController.text.trim(),
          'isMe': true,
          'time': timeString,
        });
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      widget.chat['avatar'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                if (widget.chat['isOnline'] == true)
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
                  widget.chat['name'],
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (widget.chat['isOnline'] == true)
                  const Text(
                    'Çevrimiçi',
                    style: TextStyle(fontSize: 12, color: Colors.green),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(UiConstants.defaultPadding),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isMe = message['isMe'];

                // Bir önceki mesajın da aynı kişiden olup olmadığını kontrol et
                bool isPreviousSameSender = false;
                if (index > 0) {
                  final previousMessage = messages[index - 1];
                  isPreviousSameSender = previousMessage['isMe'] == isMe;
                }

                return MessageBubble(
                  message: message,
                  isPreviousSameSender: isPreviousSameSender,
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

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
