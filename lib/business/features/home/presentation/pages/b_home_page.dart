import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/business/features/home/data/fake_business_company.dart';
import 'package:koala/business/features/home/data/models/b_applicant_model.dart';
import 'package:koala/business/features/home/data/models/b_job_post_model.dart';
import 'package:koala/business/features/home/presentation/providers/b_jobs_provider.dart';
import 'package:koala/employee/features/home/data/models/job_model.dart';
import 'package:koala/product/constants/app_colors.dart';
import 'package:koala/product/constants/app_padding.dart';
import 'package:provider/provider.dart';

class BHomePage extends StatelessWidget {
  const BHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final company = FakeBusinessCompany.instance;
    final bJobsProvider = context.watch<BJobsProvider>();
    final activePosts = bJobsProvider.activePosts;
    final pastPosts = bJobsProvider.pastPosts;
    final totalApplicants = activePosts.fold<int>(
      0,
      (sum, post) => sum + post.applicants.length,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // =================== APP BAR ===================
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            toolbarHeight: 70,
            title: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text('🐨', style: const TextStyle(fontSize: 22)),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'KOALA',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: AppColors.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      'İşveren Paneli',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => context.push('/business/notifications'),
                icon: Badge(
                  smallSize: 8,
                  backgroundColor: Colors.red,
                  child: Icon(
                    HugeIcons.strokeRoundedNotification03,
                    color: Colors.grey[700],
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 4),
            ],
          ),

          // =================== CONTENT ===================
          SliverToBoxAdapter(
            child: Padding(
              padding: AppPadding.primaryHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // ===== HOŞGELDİN BANNER =====
                  _welcomeBanner(context, company.name),

                  const SizedBox(height: 24),

                  // ===== İSTATİSTİKLER =====
                  _statsRow(
                    activeCount: activePosts.length,
                    pastCount: pastPosts.length,
                    applicantCount: totalApplicants,
                  ),

                  const SizedBox(height: 28),

                  // ===== HIZLI İŞLEMLER =====
                  _quickActionsSection(context),

                  const SizedBox(height: 28),

                  // ===== SON BAŞVURULAR =====
                  _recentApplicantsSection(context, bJobsProvider),

                  const SizedBox(height: 28),

                  // ===== AKTİF İLANLAR =====
                  _activePostsSection(context, activePosts),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =================== HOŞGELDİN BANNER ===================

  Widget _welcomeBanner(BuildContext context, String companyName) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor.withValues(alpha: 0.8),
            const Color(0xff5a9a58),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hoş geldin! 👋',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  companyName,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified,
                        size: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Onaylı İşveren',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.95),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/koala_business.png',
                width: 56,
                height: 56,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Icon(
                  HugeIcons.strokeRoundedBuilding06,
                  size: 36,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =================== İSTATİSTİKLER ===================

  Widget _statsRow({
    required int activeCount,
    required int pastCount,
    required int applicantCount,
  }) {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            icon: HugeIcons.strokeRoundedWork,
            label: 'Aktif İlan',
            value: '$activeCount',
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            icon: HugeIcons.strokeRoundedUserMultiple,
            label: 'Başvuru',
            value: '$applicantCount',
            color: const Color(0xff5B8DEF),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            icon: HugeIcons.strokeRoundedCheckmarkCircle02,
            label: 'Tamamlanan',
            value: '$pastCount',
            color: const Color(0xffF5A623),
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // =================== HIZLI İŞLEMLER ===================

  Widget _quickActionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hızlı İşlemler',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _quickActionCard(
                icon: HugeIcons.strokeRoundedPlusSign,
                label: 'Yeni İlan',
                subtitle: 'İlan oluştur',
                color: AppColors.primaryColor,
                onTap: () => context.push('/business/create'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _quickActionCard(
                icon: HugeIcons.strokeRoundedWork,
                label: 'İlanlarım',
                subtitle: 'Tümünü gör',
                color: const Color(0xff5B8DEF),
                onTap: () => context.go('/business/posts'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _quickActionCard(
                icon: HugeIcons.strokeRoundedUser,
                label: 'Profilim',
                subtitle: 'Düzenle',
                color: const Color(0xffF5A623),
                onTap: () => context.go('/business/profile'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _quickActionCard({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
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
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 22, color: color),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // =================== SON BAŞVURULAR ===================

  Widget _recentApplicantsSection(
    BuildContext context,
    BJobsProvider provider,
  ) {
    // Tüm aktif ilanlardan son başvuranları topla
    final List<_RecentApplicant> recentApplicants = [];
    for (final post in provider.activePosts) {
      for (final applicant in post.applicants) {
        recentApplicants.add(
          _RecentApplicant(applicant: applicant, post: post),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Son Başvurular',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            if (recentApplicants.isNotEmpty)
              GestureDetector(
                onTap: () => context.go('/business/posts'),
                child: Text(
                  'Tümünü Gör',
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
        const SizedBox(height: 12),
        if (recentApplicants.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                Icon(
                  HugeIcons.strokeRoundedUserMultiple,
                  size: 40,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 10),
                Text(
                  'Henüz başvuru yok',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'İlanlara başvuru geldiğinde burada görünecek',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        else
          ...recentApplicants
              .take(3)
              .map((ra) => _recentApplicantCard(context, ra)),
      ],
    );
  }

  Widget _recentApplicantCard(BuildContext context, _RecentApplicant ra) {
    return GestureDetector(
      onTap: () {
        context.push('/business/job-detail', extra: ra.post.job.id);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(ra.applicant.profileImage),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ra.applicant.fullName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    ra.post.job.title,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: ra.post.job.category.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                ra.post.job.category.displayName,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: ra.post.job.category.color,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right, size: 20, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  // =================== AKTİF İLANLAR ===================

  Widget _activePostsSection(
    BuildContext context,
    List<BJobPostModel> activePosts,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Aktif İlanlar',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            if (activePosts.isNotEmpty)
              GestureDetector(
                onTap: () => context.go('/business/posts'),
                child: Text(
                  'Tümünü Gör',
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
        const SizedBox(height: 12),
        if (activePosts.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                Icon(
                  HugeIcons.strokeRoundedWork,
                  size: 40,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 10),
                Text(
                  'Aktif ilan yok',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => context.push('/business/create'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Hemen İlan Oluştur',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          ...activePosts.take(3).map((post) => _activePostCard(context, post)),
      ],
    );
  }

  Widget _activePostCard(BuildContext context, BJobPostModel post) {
    final job = post.job;
    return GestureDetector(
      onTap: () {
        context.push('/business/job-detail', extra: job.id);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
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
            // Üst: Kategori + Tip
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: job.category.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        job.category.icon,
                        size: 13,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Aktif',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                    ),
                  ),
                ),
                const Spacer(),
                Icon(Icons.chevron_right, size: 20, color: Colors.grey[400]),
              ],
            ),

            const SizedBox(height: 12),

            // Başlık
            Text(
              job.title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              job.subtitle,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: Colors.grey[600],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            // Alt: Fiyat + Konum + Başvuru sayısı
            Row(
              children: [
                Icon(
                  Icons.monetization_on_outlined,
                  size: 16,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 4),
                Text(
                  '₺${job.price.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    job.address ?? 'Ankara',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: post.applicants.isNotEmpty
                        ? const Color(0xff5B8DEF).withValues(alpha: 0.1)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        HugeIcons.strokeRoundedUserMultiple,
                        size: 12,
                        color: post.applicants.isNotEmpty
                            ? const Color(0xff5B8DEF)
                            : Colors.grey[400],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${post.applicants.length}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: post.applicants.isNotEmpty
                              ? const Color(0xff5B8DEF)
                              : Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Başvuran + ait olduğu ilan çifti (dahili yardımcı sınıf)
class _RecentApplicant {
  final BApplicantModel applicant;
  final BJobPostModel post;

  const _RecentApplicant({required this.applicant, required this.post});
}
