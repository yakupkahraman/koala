import '../domain/chat.dart';
import '../domain/message.dart';

class ChatService {
  // Singleton pattern
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  // Fake data - chat listesi
  final List<Chat> _chats = [
    Chat(
      id: '1',
      name: 'Ahmet Yılmaz',
      avatar: 'A',
      lastMessage: 'Merhaba, nasılsın?',
      lastMessageTime: DateTime.now().subtract(Duration(minutes: 30)),
      unreadCount: 2,
      isOnline: true,
      userId: 'user1',
    ),
    Chat(
      id: '2',
      name: 'Ayşe Kaya',
      avatar: 'A',
      lastMessage: 'Yarın buluşalım mı?',
      lastMessageTime: DateTime.now().subtract(Duration(hours: 1)),
      unreadCount: 0,
      isOnline: false,
      userId: 'user2',
    ),
    Chat(
      id: '3',
      name: 'Mehmet Demir',
      avatar: 'M',
      lastMessage: 'Dosyayı gönderdim',
      lastMessageTime: DateTime.now().subtract(Duration(hours: 2)),
      unreadCount: 1,
      isOnline: true,
      userId: 'user3',
    ),
    Chat(
      id: '4',
      name: 'Fatma Özkan',
      avatar: 'F',
      lastMessage: 'Teşekkürler!',
      lastMessageTime: DateTime.now().subtract(Duration(days: 1)),
      unreadCount: 0,
      isOnline: false,
      userId: 'user4',
    ),
    Chat(
      id: '5',
      name: 'Ali Çelik',
      avatar: 'A',
      lastMessage: 'Proje nasıl gidiyor?',
      lastMessageTime: DateTime.now().subtract(Duration(days: 1, hours: 5)),
      unreadCount: 3,
      isOnline: true,
      userId: 'user5',
    ),
  ];

  // Fake data - mesajlar (chat id'ye göre)
  final Map<String, List<Message>> _messages = {
    '1': [
      Message(
        id: 'm1',
        chatId: '1',
        senderId: 'user1',
        text: 'Merhaba! Nasılsın?',
        timestamp: DateTime.now().subtract(Duration(minutes: 35)),
        isMe: false,
      ),
      Message(
        id: 'm2',
        chatId: '1',
        senderId: 'me',
        text: 'İyiyim teşekkürler, sen nasılsın?',
        timestamp: DateTime.now().subtract(Duration(minutes: 34)),
        isMe: true,
      ),
      Message(
        id: 'm3',
        chatId: '1',
        senderId: 'user1',
        text: 'Ben de iyiyim. Bugün ne yapıyorsun?',
        timestamp: DateTime.now().subtract(Duration(minutes: 33)),
        isMe: false,
      ),
      Message(
        id: 'm4',
        chatId: '1',
        senderId: 'me',
        text: 'Projede çalışıyorum. Sen?',
        timestamp: DateTime.now().subtract(Duration(minutes: 32)),
        isMe: true,
      ),
    ],
    '2': [
      Message(
        id: 'm5',
        chatId: '2',
        senderId: 'user2',
        text: 'Merhaba',
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
        isMe: false,
      ),
      Message(
        id: 'm6',
        chatId: '2',
        senderId: 'me',
        text: 'Selam',
        timestamp: DateTime.now().subtract(Duration(hours: 1, minutes: 30)),
        isMe: true,
      ),
      Message(
        id: 'm7',
        chatId: '2',
        senderId: 'user2',
        text: 'Yarın buluşalım mı?',
        timestamp: DateTime.now().subtract(Duration(hours: 1)),
        isMe: false,
      ),
    ],
    '3': [
      Message(
        id: 'm8',
        chatId: '3',
        senderId: 'user3',
        text: 'Dosyayı gönderdim',
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
        isMe: false,
      ),
    ],
    '4': [
      Message(
        id: 'm9',
        chatId: '4',
        senderId: 'me',
        text: 'Yardımın için teşekkürler',
        timestamp: DateTime.now().subtract(Duration(days: 1, hours: 1)),
        isMe: true,
      ),
      Message(
        id: 'm10',
        chatId: '4',
        senderId: 'user4',
        text: 'Teşekkürler!',
        timestamp: DateTime.now().subtract(Duration(days: 1)),
        isMe: false,
      ),
    ],
    '5': [
      Message(
        id: 'm11',
        chatId: '5',
        senderId: 'user5',
        text: 'Proje nasıl gidiyor?',
        timestamp: DateTime.now().subtract(Duration(days: 1, hours: 5)),
        isMe: false,
      ),
    ],
  };

  // Chat listesini getir
  List<Chat> getChats() {
    return List.unmodifiable(_chats);
  }

  // Belirli bir chat'i getir
  Chat? getChatById(String chatId) {
    try {
      return _chats.firstWhere((chat) => chat.id == chatId);
    } catch (e) {
      return null;
    }
  }

  // Belirli bir chat'e ait mesajları getir
  List<Message> getMessages(String chatId) {
    return List.unmodifiable(_messages[chatId] ?? []);
  }

  // Yeni mesaj gönder
  void sendMessage(String chatId, String text) {
    final message = Message(
      id: 'm${DateTime.now().millisecondsSinceEpoch}',
      chatId: chatId,
      senderId: 'me',
      text: text,
      timestamp: DateTime.now(),
      isMe: true,
      status: MessageStatus.sent,
    );

    if (_messages[chatId] == null) {
      _messages[chatId] = [];
    }
    _messages[chatId]!.add(message);

    // Chat'in son mesajını ve zamanını güncelle
    final chatIndex = _chats.indexWhere((chat) => chat.id == chatId);
    if (chatIndex != -1) {
      _chats[chatIndex] = _chats[chatIndex].copyWith(
        lastMessage: text,
        lastMessageTime: DateTime.now(),
      );
    }
  }

  // Mesaj silme (gelecekte backend'e bağlanacak)
  void deleteMessage(String chatId, String messageId) {
    _messages[chatId]?.removeWhere((msg) => msg.id == messageId);
  }

  // Okunmamış mesaj sayısını sıfırla
  void markChatAsRead(String chatId) {
    final chatIndex = _chats.indexWhere((chat) => chat.id == chatId);
    if (chatIndex != -1) {
      _chats[chatIndex] = _chats[chatIndex].copyWith(unreadCount: 0);
    }
  }

  // Yeni chat oluştur (gelecekte backend'e bağlanacak)
  void createChat(Chat chat) {
    _chats.insert(0, chat);
  }

  // Chat sil
  void deleteChat(String chatId) {
    _chats.removeWhere((chat) => chat.id == chatId);
    _messages.remove(chatId);
  }
}
