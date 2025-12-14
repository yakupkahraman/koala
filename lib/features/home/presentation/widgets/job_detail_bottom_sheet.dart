import 'package:flutter/material.dart';
import 'package:koala/core/constants.dart';
import 'package:koala/features/home/data/models/job_model.dart';

class JobDetailBottomSheet extends StatefulWidget {
  final JobModel job;
  final VoidCallback? onApply;
  final VoidCallback? onClose;
  final ScrollController? scrollController;
  final DraggableScrollableController? sheetController;

  const JobDetailBottomSheet({
    super.key,
    required this.job,
    this.onApply,
    this.onClose,
    this.scrollController,
    this.sheetController,
  });

  static void show(BuildContext context, JobModel job) {
    final sheetController = DraggableScrollableController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => DraggableScrollableSheet(
        controller: sheetController,
        initialChildSize: 0.4,
        minChildSize: 0.3,
        maxChildSize: 0.95,
        expand: false,
        snap: true,
        snapSizes: const [0.4, 0.95],
        builder: (context, scrollController) => JobDetailBottomSheet(
          job: job,
          onClose: () => Navigator.pop(context),
          scrollController: scrollController,
          sheetController: sheetController,
        ),
      ),
    );
  }

  @override
  State<JobDetailBottomSheet> createState() => _JobDetailBottomSheetState();
}

class _JobDetailBottomSheetState extends State<JobDetailBottomSheet> {
  bool _isSaved = false;
  double _sheetSize = 0.5;

  @override
  void initState() {
    super.initState();
    widget.sheetController?.addListener(_onSheetChanged);
  }

  @override
  void dispose() {
    widget.sheetController?.removeListener(_onSheetChanged);
    super.dispose();
  }

  void _onSheetChanged() {
    if (widget.sheetController != null) {
      setState(() {
        _sheetSize = widget.sheetController!.size;
      });
    }
  }

  void _closeSheet() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // 0.5 ile 0.95 arasında normalize et (0.0 - 1.0)
    final expandProgress = ((_sheetSize - 0.5) / (0.95 - 0.5)).clamp(0.0, 1.0);
    final isExpanded = expandProgress > 0.3;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          appBar(expandProgress),
          body(expandProgress, isExpanded, context),
          bottomButtonsBar(context, isExpanded),
        ],
      ),
    );
  }

  Container bottomButtonsBar(BuildContext context, bool isExpanded) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        UiConstants.defaultPadding,
        12,
        UiConstants.defaultPadding,
        MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Kaydet butonu
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isExpanded ? 56 : 0,
            height: 56,
            child: isExpanded
                ? Material(
                    color: Colors.transparent,
                    child: Ink(
                      decoration: BoxDecoration(
                        color: _isSaved
                            ? ThemeConstants.primaryColor.withValues(
                                alpha: 0.15,
                              )
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            _isSaved = !_isSaved;
                          });
                        },
                        child: Center(
                          child: Icon(
                            _isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: _isSaved
                                ? ThemeConstants.primaryColor
                                : Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          if (isExpanded) const SizedBox(width: 12),

          // Ana buton
          Expanded(
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: isExpanded
                    ? () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${widget.job.title} için başvurunuz alındı!',
                            ),
                            backgroundColor: ThemeConstants.primaryColor,
                          ),
                        );
                      }
                    : () {
                        widget.sheetController?.animateTo(
                          0.95,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeConstants.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  isExpanded ? 'Başvur' : 'Detayları Gör',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded body(double expandProgress, bool isExpanded, BuildContext context) {
    return Expanded(
      child: ListView(
        controller: widget.scrollController,
        padding: const EdgeInsets.symmetric(
          horizontal: UiConstants.defaultPadding,
        ),
        children: [
          // Handle bar (sadece küçükken görünür)
          AnimatedOpacity(
            opacity: 1 - expandProgress,
            duration: const Duration(milliseconds: 200),
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 40,
                height: 4,
                margin: EdgeInsets.symmetric(
                  vertical: 8 * (1 - expandProgress),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),

          // Şirket adı (varsa)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.job.company!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13 + (1 * expandProgress), // 13 -> 14
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: AnimatedOpacity(
                  opacity: 1 - expandProgress,
                  duration: const Duration(milliseconds: 200),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: expandProgress > 0.5 ? 0 : null,
                    padding: expandProgress > 0.5
                        ? EdgeInsets.zero
                        : const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                    decoration: BoxDecoration(
                      color: widget.job.category.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: expandProgress > 0.5
                        ? const SizedBox.shrink()
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                widget.job.category.icon,
                                size: 18,
                                color: widget.job.category.color,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                widget.job.category.displayName,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: widget.job.category.color,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),

          // Başlık
          Text(
            widget.job.title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22 + (6 * expandProgress), // 22 -> 28
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.job.type.displayName,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: 12 + (4 * expandProgress),
                  //   vertical: 6 + (4 * expandProgress),
                  // ),
                  // decoration: BoxDecoration(
                  //   color: ThemeConstants.primaryColor.withValues(alpha: 0.15),
                  //   borderRadius: BorderRadius.circular(isExpanded ? 12 : 20),
                  // ),
                  child: Text(
                    '${widget.job.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\\d{1,3})(?=(\\d{3})+(?!\\d))'), (Match m) => '${m[1]}.')}₺',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 26 + (4 * expandProgress), // 16 -> 20
                      fontWeight: FontWeight.w700,
                      color: ThemeConstants.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Açıklama başlığı (sadece genişlediğinde)
          AnimatedOpacity(
            opacity: expandProgress,
            duration: const Duration(milliseconds: 200),
            child: expandProgress > 0.3
                ? const Padding(
                    padding: EdgeInsets.only(bottom: 8, top: 8),
                    child: Text(
                      'Açıklama',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          // Açıklama
          Text(
            widget.job.description ?? widget.job.subtitle,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14 + (1 * expandProgress), // 14 -> 15
              fontWeight: FontWeight.w400,
              color: Colors.grey[isExpanded ? 700 : 600],
              height: 1.5 + (0.1 * expandProgress),
            ),
            maxLines: isExpanded ? null : 2,
            overflow: isExpanded ? null : TextOverflow.ellipsis,
          ),

          // Ek detaylar (sadece genişlediğinde)
          if (isExpanded && widget.job.duties != null) ...[
            const SizedBox(height: 24),
            const Text(
              'Görevler',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.job.duties!,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],

          // İş detayları kartları (sadece genişlediğinde)
          if (isExpanded) ...[
            const SizedBox(height: 24),
            _buildInfoCard('Tarih ve Saat', [
              if (widget.job.startDateTime != null)
                _buildInfoRow(
                  Icons.calendar_today,
                  'Başlangıç',
                  '${widget.job.startDateTime!.day}/${widget.job.startDateTime!.month}/${widget.job.startDateTime!.year} - ${widget.job.startDateTime!.hour}:${widget.job.startDateTime!.minute.toString().padLeft(2, '0')}',
                ),
              if (widget.job.endDateTime != null)
                _buildInfoRow(
                  Icons.calendar_today,
                  'Bitiş',
                  '${widget.job.endDateTime!.day}/${widget.job.endDateTime!.month}/${widget.job.endDateTime!.year} - ${widget.job.endDateTime!.hour}:${widget.job.endDateTime!.minute.toString().padLeft(2, '0')}',
                ),
            ]),
          ],

          if (isExpanded) ...[
            const SizedBox(height: 16),
            _buildInfoCard('Gereksinimler', [
              if (widget.job.minAge != null || widget.job.maxAge != null)
                _buildInfoRow(
                  Icons.person,
                  'Yaş Aralığı',
                  '${widget.job.minAge ?? ''}-${widget.job.maxAge ?? ''} yaş',
                ),
              if (widget.job.experienceRequired != null)
                _buildInfoRow(
                  Icons.work,
                  'Deneyim',
                  widget.job.experienceRequired! ? 'Gerekli' : 'Gerekli Değil',
                ),
              if (widget.job.insuranceRequired != null)
                _buildInfoRow(
                  Icons.health_and_safety,
                  'Sigorta',
                  widget.job.insuranceRequired! ? 'Gerekli' : 'Gerekli Değil',
                ),
              if (widget.job.dressCode != null)
                _buildInfoRow(
                  Icons.checkroom,
                  'Kıyafet',
                  widget.job.dressCode!,
                ),
            ]),
          ],

          if (isExpanded &&
              (widget.job.sector != null || widget.job.position != null)) ...[
            const SizedBox(height: 16),
            _buildInfoCard('İş Bilgileri', [
              if (widget.job.sector != null)
                _buildInfoRow(Icons.business, 'Sektör', widget.job.sector!),
              if (widget.job.position != null)
                _buildInfoRow(Icons.badge, 'Pozisyon', widget.job.position!),
            ]),
          ],

          // Konum bilgisi (sadece genişlediğinde)
          AnimatedOpacity(
            opacity: expandProgress,
            duration: const Duration(milliseconds: 200),
            child: expandProgress > 0.3
                ? Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: ThemeConstants.primaryColor,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Konum',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  widget.job.address ??
                                      '${widget.job.latitude.toStringAsFixed(4)}, ${widget.job.longitude.toStringAsFixed(4)}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // TODO: Haritada göster
                            },
                            child: const Text(
                              'Haritada Gör',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          SizedBox(height: MediaQuery.of(context).padding.bottom + 100),
        ],
      ),
    );
  }

  AnimatedContainer appBar(double expandProgress) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 8 + (56 * expandProgress), // 8 -> 64 (padding + buton yüksekliği)
      child: expandProgress > 0.3
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black87,
                    ),
                    onPressed: _closeSheet,
                  ),
                  Opacity(
                    opacity: expandProgress,
                    child: Text(
                      widget.job.category.displayName,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: ThemeConstants.primaryColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
