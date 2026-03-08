import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/product/constants/app_colors.dart';
import 'package:koala/product/constants/app_padding.dart';
import 'package:koala/product/widgets/my_appbar.dart';

/// Bildirim türleri
enum BNotificationType { applicant, approved, rejected, info, system }

/// Tek bir bildirim modeli
class _BNotification {
  final String id;
  final String title;
  final String body;
  final BNotificationType type;
  final String timeAgo;
  final bool isRead;

  const _BNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.timeAgo,
    this.isRead = false,
  });
}

class BNotificationsPage extends StatefulWidget {
  const BNotificationsPage({super.key});

  @override
  State<BNotificationsPage> createState() => _BNotificationsPageState();
}

class _BNotificationsPageState extends State<BNotificationsPage> {
  late List<_BNotification> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = _generateFakeNotifications();
  }

  List<_BNotification> _generateFakeNotifications() {
    return const [
      _BNotification(
        id: 'n1',
        title: 'Yeni Başvuru',
        body: 'Yakup Demir, "Part-time Garson" ilanınıza başvurdu.',
        type: BNotificationType.applicant,
        timeAgo: '5 dk önce',
      ),
      _BNotification(
        id: 'n2',
        title: 'Yeni Başvuru',
        body: 'Ayşe Yılmaz, "Deneyimli Barista" ilanınıza başvurdu.',
        type: BNotificationType.applicant,
        timeAgo: '23 dk önce',
      ),
      _BNotification(
        id: 'n3',
        title: 'İlan Onaylandı',
        body: '"Part-time Garson" ilanınız incelendi ve yayına alındı.',
        type: BNotificationType.approved,
        timeAgo: '1 saat önce',
        isRead: true,
      ),
      _BNotification(
        id: 'n4',
        title: 'Yeni Başvuru',
        body: 'Mehmet Kaya, "Deneyimli Barista" ilanınıza başvurdu.',
        type: BNotificationType.applicant,
        timeAgo: '2 saat önce',
        isRead: true,
      ),
      _BNotification(
        id: 'n5',
        title: 'İş Tamamlandı',
        body:
            'Burak Şen, "Mekan Fotoğrafçısı" işini tamamladı. Değerlendirme yapabilirsiniz.',
        type: BNotificationType.info,
        timeAgo: '1 gün önce',
        isRead: true,
      ),
      _BNotification(
        id: 'n6',
        title: 'Sistem Bildirimi',
        body: 'Koala İşveren Paneli güncellendi! Yeni özellikler eklendi.',
        type: BNotificationType.system,
        timeAgo: '2 gün önce',
        isRead: true,
      ),
      _BNotification(
        id: 'n7',
        title: 'İlan Onaylandı',
        body: '"Deneyimli Barista" ilanınız incelendi ve yayına alındı.',
        type: BNotificationType.approved,
        timeAgo: '3 gün önce',
        isRead: true,
      ),
      _BNotification(
        id: 'n8',
        title: 'Hoş Geldiniz!',
        body:
            'Koala İşveren Paneli\'ne hoş geldiniz. İlan oluşturarak hemen başlayabilirsiniz.',
        type: BNotificationType.system,
        timeAgo: '1 hafta önce',
        isRead: true,
      ),
    ];
  }

  void _markAllAsRead() {
    setState(() {
      _notifications = _notifications
          .map(
            (n) => _BNotification(
              id: n.id,
              title: n.title,
              body: n.body,
              type: n.type,
              timeAgo: n.timeAgo,
              isRead: true,
            ),
          )
          .toList();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Tüm bildirimler okundu olarak işaretlendi',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
        ),
        backgroundColor: AppColors.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _dismissNotification(String id) {
    setState(() {
      _notifications.removeWhere((n) => n.id == id);
    });
  }

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppbar(
        title: 'Bildirimler',
        actions: [
          if (_unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: Text(
                'Tümünü Oku',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? _emptyState()
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 100),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return _notificationTile(context, notification);
              },
            ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: AppPadding.primaryAll,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                HugeIcons.strokeRoundedNotification03,
                size: 40,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Bildirim yok',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Yeni bildirimler geldiğinde\nburada görünecek.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.grey[400],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationTile(BuildContext context, _BNotification notification) {
    final config = _typeConfig(notification.type);

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _dismissNotification(notification.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        color: Colors.red[50],
        child: Icon(HugeIcons.strokeRoundedDelete02, color: Colors.red[400]),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: notification.isRead
              ? Colors.white
              : AppColors.primaryColor.withValues(alpha: 0.04),
          border: Border(
            bottom: BorderSide(color: Colors.grey[100]!, width: 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // İkon
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: config.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(config.icon, size: 20, color: config.color),
              ),
              const SizedBox(width: 12),

              // İçerik
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: notification.isRead
                                  ? FontWeight.w500
                                  : FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.body,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notification.timeAgo,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _NotificationTypeConfig _typeConfig(BNotificationType type) {
    switch (type) {
      case BNotificationType.applicant:
        return _NotificationTypeConfig(
          icon: HugeIcons.strokeRoundedUserAdd01,
          color: const Color(0xff5B8DEF),
        );
      case BNotificationType.approved:
        return _NotificationTypeConfig(
          icon: HugeIcons.strokeRoundedCheckmarkCircle02,
          color: AppColors.primaryColor,
        );
      case BNotificationType.rejected:
        return _NotificationTypeConfig(
          icon: HugeIcons.strokeRoundedCancelCircle,
          color: Colors.red,
        );
      case BNotificationType.info:
        return _NotificationTypeConfig(
          icon: HugeIcons.strokeRoundedInformationCircle,
          color: const Color(0xffF5A623),
        );
      case BNotificationType.system:
        return _NotificationTypeConfig(
          icon: HugeIcons.strokeRoundedSettings01,
          color: Colors.grey[600]!,
        );
    }
  }
}

class _NotificationTypeConfig {
  final IconData icon;
  final Color color;

  const _NotificationTypeConfig({required this.icon, required this.color});
}
