import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/employee/features/chat/data/chat_service.dart';
import 'package:koala/employee/features/chat/presentation/pages/chat_page.dart';
import 'package:koala/employee/features/company_detail/domain/company_model.dart';
import 'package:koala/employee/features/home/data/repositories/job_repository.dart';
import 'package:koala/employee/features/home/data/models/job_model.dart';
import 'package:koala/product/constants/app_padding.dart';

class CompanyDetailPage extends StatefulWidget {
  final CompanyModel company;

  const CompanyDetailPage({super.key, required this.company});

  @override
  State<CompanyDetailPage> createState() => _CompanyDetailPageState();
}

class _CompanyDetailPageState extends State<CompanyDetailPage> {
  bool _isFollowing = false;
  final JobRepository _jobRepository = JobRepository();
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  late Future<List<JobModel>> _companyJobsFuture;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
    _companyJobsFuture = _loadCompanyJobs();
  }

  Future<List<JobModel>> _loadCompanyJobs() async {
    final allJobs = await _jobRepository.getJobs();
    return allJobs.where((job) => job.company == widget.company.name).toList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AppBar'ın collapse olma durumuna göre opacity hesapla
    // expandedHeight - kToolbarHeight = collapse başlangıcı
    final double collapsedStartOffset = 180 - kToolbarHeight;
    final double titleOpacity = (_scrollOffset - collapsedStartOffset) / 40;
    final double clampedOpacity = titleOpacity.clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          appBar(context, clampedOpacity),
          actionButtons(context),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: AppPadding.primaryAll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Approval Status
                  if (!widget.company.isApproved)
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.orange.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            HugeIcons.strokeRoundedAlert02,
                            color: Colors.orange[700],
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Bu şirket henüz onaylanmamıştır',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.orange[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Description
                  if (widget.company.description != null) ...[
                    _buildSectionTitle('Hakkında'),
                    const SizedBox(height: 8),
                    Text(
                      widget.company.description!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Contact Information
                  _buildSectionTitle('İletişim Bilgileri'),
                  const SizedBox(height: 12),
                  _buildInfoCard([
                    _buildInfoRow(
                      HugeIcons.strokeRoundedMail01,
                      'E-posta',
                      widget.company.email,
                    ),
                    if (widget.company.phoneNumber != null)
                      _buildInfoRow(
                        HugeIcons.strokeRoundedCall,
                        'Telefon',
                        widget.company.phoneNumber!,
                      ),
                    if (widget.company.website != null)
                      _buildInfoRow(
                        HugeIcons.strokeRoundedInternetAntenna01,
                        'Website',
                        widget.company.website!,
                      ),
                  ]),

                  // Address
                  if (widget.company.address != null) ...[
                    const SizedBox(height: 24),
                    _buildSectionTitle('Adres'),
                    const SizedBox(height: 12),
                    _buildInfoCard([
                      _buildInfoRow(
                        HugeIcons.strokeRoundedLocation01,
                        'Adres',
                        widget.company.address!.fullAddress,
                      ),
                    ]),
                  ],

                  // İlanlar Section
                  const SizedBox(height: 24),
                  _buildSectionTitle('İlanlar'),
                  const SizedBox(height: 12),
                  _buildJobsSection(),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter actionButtons(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: AppPadding.primaryAll,
        color: Colors.white,
        child: Column(
          children: [
            // Action Buttons Row
            Row(
              children: [
                // Takip Et Butonu
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isFollowing = !_isFollowing;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _isFollowing
                                  ? '${widget.company.name} takip edildi'
                                  : '${widget.company.name} takipten çıkarıldı',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: Icon(
                        _isFollowing
                            ? HugeIcons.strokeRoundedUserCheck01
                            : HugeIcons.strokeRoundedUserAdd01,
                        size: 18,
                      ),
                      label: Text(
                        _isFollowing ? 'Takip Ediliyor' : 'Takip Et',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isFollowing
                            ? Colors.grey[100]
                            : Theme.of(context).colorScheme.primary,
                        foregroundColor: _isFollowing
                            ? Colors.grey[700]
                            : Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: _isFollowing
                              ? BorderSide(color: Colors.grey[300]!)
                              : BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Mesaj At Butonu
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        final chatService = ChatService();
                        final chat = chatService.getOrCreateChatByCompany(
                          companyId: widget.company.id,
                          companyName: widget.company.name,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(chat: chat),
                          ),
                        );
                      },
                      icon: const Icon(
                        HugeIcons.strokeRoundedMessage01,
                        size: 18,
                      ),
                      label: const Text(
                        'Mesaj At',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar appBar(BuildContext context, double clampedOpacity) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 180,
      backgroundColor: Theme.of(context).colorScheme.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: false,
      title: Opacity(
        opacity: clampedOpacity,
        child: Text(
          widget.company.name,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: widget.company.logo != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                widget.company.logo!.url,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.business,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                              ),
                            )
                          : const Icon(
                              Icons.business,
                              size: 40,
                              color: Colors.grey,
                            ),
                    ),
                    const SizedBox(height: 12),
                    // Company Name
                    Text(
                      widget.company.name,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Type
                    if (widget.company.type != null) ...[
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.company.type!.displayName,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJobsSection() {
    return FutureBuilder<List<JobModel>>(
      future: _companyJobsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'İlanlar yüklenirken bir hata oluştu',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ),
          );
        }

        final companyJobs = snapshot.data ?? [];

        if (companyJobs.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Icon(
                    HugeIcons.strokeRoundedJobSearch,
                    size: 64,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Henüz ilan yok',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Column(
          children: companyJobs
              .map(
                (job) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildJobCard(job),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildJobCard(JobModel job) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Badge & Type
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: job.category.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      job.category.icon,
                      size: 14,
                      color: job.category.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      job.category.displayName,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: job.category.color,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  job.type.displayName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Title
          Text(
            job.title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          // Subtitle
          Text(
            job.subtitle,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 12),

          // Price & Location
          Row(
            children: [
              Icon(
                HugeIcons.strokeRoundedMoneyBag02,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 4),
              Text(
                '₺${job.price.toStringAsFixed(0)}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                HugeIcons.strokeRoundedLocation01,
                size: 16,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  job.address ?? 'Ankara',
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
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
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
