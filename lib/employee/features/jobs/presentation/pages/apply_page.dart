import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koala/employee/features/home/data/models/job_model.dart';
import 'package:koala/employee/features/jobs/presentation/providers/apply_provider.dart';
import 'package:koala/product/constants/app_colors.dart';
import 'package:koala/product/constants/app_padding.dart';
import 'package:koala/product/widgets/button_navbar.dart';
import 'package:koala/product/widgets/my_appbar.dart';
import 'package:provider/provider.dart';

class ApplyPage extends StatefulWidget {
  final JobModel job;

  const ApplyPage({super.key, required this.job});

  @override
  State<ApplyPage> createState() => _ApplyPageState();
}

class _ApplyPageState extends State<ApplyPage> {
  final TextEditingController _coverLetterController = TextEditingController();
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _coverLetterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applyProvider = context.watch<ApplyProvider>();
    final alreadyApplied = applyProvider.hasApplied(widget.job.id);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppbar(title: "İşe Başvur"),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.primaryHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // İş Bilgileri Kartı
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primaryColor.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kategori badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: widget.job.category.color.withValues(
                          alpha: 0.15,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            widget.job.category.icon,
                            size: 14,
                            color: widget.job.category.color,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.job.category.displayName,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: widget.job.category.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // İş Başlığı
                    Text(
                      widget.job.title,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Şirket
                    Text(
                      widget.job.company ?? '',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Fiyat ve Konum
                    Row(
                      children: [
                        Icon(
                          Icons.monetization_on_outlined,
                          size: 18,
                          color: AppColors.primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '₺${widget.job.price.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.job.address ?? 'Ankara',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    // Tarih bilgisi
                    if (widget.job.startDateTime != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 18,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.job.startDateTime!.day}/${widget.job.startDateTime!.month}/${widget.job.startDateTime!.year}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (widget.job.endDateTime != null) ...[
                            Text(
                              ' - ${widget.job.endDateTime!.day}/${widget.job.endDateTime!.month}/${widget.job.endDateTime!.year}',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Ön Yazı
              const Text(
                'Ön Yazı (Opsiyonel)',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'İşveren size neden uygun olduğunuzu kısaca anlatın',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _coverLetterController,
                maxLines: 5,
                maxLength: 500,
                decoration: InputDecoration(
                  hintText: 'Kendinizi tanıtın, deneyimlerinizden bahsedin...',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.grey[400],
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
              ),

              const SizedBox(height: 16),

              // Gereksinimler Özeti
              if (widget.job.experienceRequired != null ||
                  widget.job.dressCode != null ||
                  widget.job.minAge != null) ...[
                const Text(
                  'Gereksinimler',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    children: [
                      if (widget.job.experienceRequired != null)
                        _requirementRow(
                          Icons.work_outline,
                          'Deneyim',
                          widget.job.experienceRequired!
                              ? 'Gerekli'
                              : 'Gerekli Değil',
                        ),
                      if (widget.job.minAge != null ||
                          widget.job.maxAge != null)
                        _requirementRow(
                          Icons.person_outline,
                          'Yaş Aralığı',
                          '${widget.job.minAge ?? ''}-${widget.job.maxAge ?? ''} yaş',
                        ),
                      if (widget.job.dressCode != null)
                        _requirementRow(
                          Icons.checkroom_outlined,
                          'Kıyafet',
                          widget.job.dressCode!,
                        ),
                      if (widget.job.insuranceRequired != null)
                        _requirementRow(
                          Icons.health_and_safety_outlined,
                          'Sigorta',
                          widget.job.insuranceRequired!
                              ? 'Gerekli'
                              : 'Gerekli Değil',
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Şartları kabul et
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _agreedToTerms,
                      onChanged: alreadyApplied
                          ? null
                          : (value) {
                              setState(() {
                                _agreedToTerms = value ?? false;
                              });
                            },
                      activeColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: alreadyApplied
                          ? null
                          : () {
                              setState(() {
                                _agreedToTerms = !_agreedToTerms;
                              });
                            },
                      child: Text(
                        'Başvuru koşullarını ve kullanım şartlarını okudum, kabul ediyorum.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ButtonNavbar(
        onPressed: (alreadyApplied || !_agreedToTerms)
            ? null
            : () {
                applyProvider.applyToJob(
                  widget.job,
                  coverLetter: _coverLetterController.text.isNotEmpty
                      ? _coverLetterController.text
                      : null,
                );
                _showSuccessDialog(context);
              },
        title: alreadyApplied ? 'Zaten Başvurdunuz' : 'Başvuruyu Gönder',
      ),
    );
  }

  Widget _requirementRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 48,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Başvurunuz Alındı!',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${widget.job.title} için başvurunuz başarıyla gönderildi. İşveren değerlendirdikten sonra size bildirim göndereceğiz.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        context.go('/jobs');
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                        side: BorderSide(color: AppColors.primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'İşlerime Git',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        context.go('/explore');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Keşfetmeye Dön',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
