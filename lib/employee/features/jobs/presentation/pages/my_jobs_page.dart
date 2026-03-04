import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koala/employee/features/jobs/data/models/my_jobs_model.dart';
import 'package:koala/employee/features/jobs/data/repositories/my_jobs_repository.dart';
import 'package:koala/employee/features/jobs/presentation/providers/review_provider.dart';
import 'package:koala/product/constants/app_colors.dart';
import 'package:koala/product/constants/app_padding.dart';
import 'package:provider/provider.dart';

class MyJobsPage extends StatefulWidget {
  const MyJobsPage({super.key});

  @override
  State<MyJobsPage> createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> {
  final MyJobsRepository _repository = MyJobsRepository();
  bool showAllPastJobs = false;
  List<MyJobsModel> _allJobs = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    final jobs = await _repository.getMyJobs();
    setState(() {
      _allJobs = jobs;
      _loading = false;
    });
  }

  List<MyJobsModel> _getJobsByStatus(MyJobStatus status) {
    return _allJobs.where((job) => job.status == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: _appBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final pendingJobs = _getJobsByStatus(MyJobStatus.pending);
    final approvedJobs = _getJobsByStatus(MyJobStatus.approved);
    final completedJobs = _getJobsByStatus(MyJobStatus.completed);
    final pastJobs = _getJobsByStatus(MyJobStatus.past);

    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.primaryHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Onaylanmış işler - en üstte ve belirgin
              if (approvedJobs.isNotEmpty) ...[
                _statusSection(
                  title: 'Gitmeniz Gereken İşler',
                  jobs: approvedJobs,
                  backgroundColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  icon: Icons.directions_walk_rounded,
                  statusChipColor: Colors.white,
                  statusChipTextColor: AppColors.primaryColor,
                ),
                SizedBox(height: 20),
              ],

              // Ödeme bekleyen işler
              if (completedJobs.isNotEmpty) ...[
                _completedSection(completedJobs),
                SizedBox(height: 20),
              ],

              // Başvuru bekleyen işler
              if (pendingJobs.isNotEmpty) ...[
                _statusSection(
                  title: 'Başvurularım',
                  jobs: pendingJobs,
                  backgroundColor: Color(0xFFF3E5F5),
                  textColor: Colors.black,
                  icon: Icons.hourglass_top_rounded,
                  statusChipColor: Colors.purple,
                  statusChipTextColor: Colors.white,
                ),
                SizedBox(height: 20),
              ],

              // Geçmiş işler
              if (pastJobs.isNotEmpty) ...[_pastJobsSection(pastJobs)],

              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: false,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        "İşlerim",
        style: TextStyle(
          fontFamily: "Poppins",
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _statusSection({
    required String title,
    required List<MyJobsModel> jobs,
    required Color backgroundColor,
    required Color textColor,
    required IconData icon,
    required Color statusChipColor,
    required Color statusChipTextColor,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, color: textColor, size: 24),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: statusChipColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${jobs.length}',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: statusChipTextColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: jobs.length,
            separatorBuilder: (context, index) => Divider(
              color: textColor.withValues(alpha: 0.2),
              thickness: 1,
              height: 1,
            ),
            itemBuilder: (context, index) {
              final job = jobs[index];
              return _jobTile(job, textColor);
            },
          ),
        ],
      ),
    );
  }

  Widget _completedSection(List<MyJobsModel> jobs) {
    final reviewProvider = context.watch<ReviewProvider>();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xFFFFF3E0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet_rounded,
                color: Colors.black,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Ödeme Bekleniyor',
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${jobs.length}',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: jobs.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.black.withValues(alpha: 0.2),
              thickness: 1,
              height: 1,
            ),
            itemBuilder: (context, index) {
              final job = jobs[index];
              final alreadyReviewed = reviewProvider.hasReviewed(job.id);

              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 4,
                ),
                title: Text(
                  job.title,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.company,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.black.withValues(alpha: 0.7),
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      job.description,
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.5),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                trailing: alreadyReviewed
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Değerlendirildi',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.green.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 36,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push('/review', extra: job);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Değerlendir',
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _jobTile(MyJobsModel job, Color textColor) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      title: Text(
        job.title,
        style: TextStyle(
          fontFamily: "Poppins",
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            job.company,
            style: TextStyle(
              fontFamily: "Poppins",
              color: textColor.withValues(alpha: 0.7),
              fontSize: 13,
            ),
          ),
          SizedBox(height: 2),
          Text(
            job.description,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.5),
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '₺${job.price.toStringAsFixed(0)}',
            style: TextStyle(
              fontFamily: "Poppins",
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            job.date,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pastJobsSection(List<MyJobsModel> pastJobs) {
    final int pastJobsToShow = showAllPastJobs ? pastJobs.length : 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(Icons.history_rounded, color: Colors.black54, size: 24),
            SizedBox(width: 8),
            Text(
              "Geçmiş",
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${pastJobs.length}',
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: pastJobsToShow,
          separatorBuilder: (context, index) => Divider(
            color: Colors.black.withValues(alpha: 0.1),
            thickness: 1,
            height: 1,
          ),
          itemBuilder: (context, index) {
            final job = pastJobs[index];
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              title: Text(
                job.title,
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.company,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    job.description,
                    style: TextStyle(color: Colors.black38, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₺${job.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.green.shade700,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    job.date,
                    style: TextStyle(color: Colors.black45, fontSize: 12),
                  ),
                  Icon(Icons.check_circle, color: Colors.green, size: 18),
                ],
              ),
            );
          },
        ),
        if (pastJobs.length > 2)
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 8),
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    showAllPastJobs = !showAllPastJobs;
                  });
                },
                icon: Icon(
                  showAllPastJobs
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppColors.primaryColor,
                ),
                label: Text(
                  showAllPastJobs
                      ? "Daha az göster"
                      : "Daha fazla göster (${pastJobs.length - 2} daha)",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
