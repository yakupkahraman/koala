import 'package:flutter/material.dart';
import 'package:koala/core/constants.dart';
import 'package:koala/features/home/data/models/job_model.dart';

/// İş detaylarını gösteren bottom sheet widget
class JobDetailBottomSheet extends StatelessWidget {
  final JobModel job;
  final VoidCallback? onApply;
  final VoidCallback? onClose;

  const JobDetailBottomSheet({
    super.key,
    required this.job,
    this.onApply,
    this.onClose,
  });

  /// Bottom sheet'i göster
  static void show(BuildContext context, JobModel job) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          JobDetailBottomSheet(job: job, onClose: () => Navigator.pop(context)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(UiConstants.defaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // İş türü badge ve fiyat
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_buildTypeBadge(), _buildPriceTag()],
          ),

          const SizedBox(height: 16),

          // Başlık
          Text(
            job.title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 8),

          // Alt başlık / Açıklama
          Text(
            job.subtitle,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),

          const SizedBox(height: 24),

          // Başvur butonu
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  onApply ??
                  () {
                    // TODO: Başvuru işlemi
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${job.title} için başvurunuz alındı!'),
                        backgroundColor: ThemeConstants.primaryColor,
                      ),
                    );
                  },
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeConstants.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Başvur',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Bottom safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  /// İş türü badge'i
  Widget _buildTypeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: job.type.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(job.type.icon, size: 18, color: job.type.color),
          const SizedBox(width: 6),
          Text(
            job.type.displayName,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: job.type.color,
            ),
          ),
        ],
      ),
    );
  }

  /// Fiyat etiketi
  Widget _buildPriceTag() {
    // Manuel TL formatı
    final priceText =
        '₺${job.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: ThemeConstants.primaryColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        priceText,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: ThemeConstants.primaryColor,
        ),
      ),
    );
  }
}
