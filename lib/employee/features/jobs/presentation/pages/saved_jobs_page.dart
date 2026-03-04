import 'package:flutter/material.dart';
import 'package:koala/employee/features/home/data/models/job_model.dart';
import 'package:koala/employee/features/home/presentation/widgets/job_detail_bottom_sheet.dart';
import 'package:koala/employee/features/jobs/presentation/providers/saved_jobs_provider.dart';
import 'package:koala/product/constants/app_padding.dart';
import 'package:provider/provider.dart';

class SavedJobsPage extends StatelessWidget {
  const SavedJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Kaydettiğim İşler",
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Consumer<SavedJobsProvider>(
        builder: (context, provider, child) {
          final savedJobs = provider.savedJobs;

          if (savedJobs.isEmpty) {
            return _emptyState();
          }

          return ListView.separated(
            padding: AppPadding.primaryAll,
            itemCount: savedJobs.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.black.withValues(alpha: 0.1),
              thickness: 1,
              height: 1,
            ),
            itemBuilder: (context, index) {
              final job = savedJobs[index];
              return _savedJobTile(context, job, provider);
            },
          );
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
            Icon(Icons.bookmark_border, size: 80, color: Colors.grey[300]),
            SizedBox(height: 16),
            Text(
              'Henüz kaydedilmiş iş yok',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'İş detaylarında kaydet butonuna basarak\nişleri buraya ekleyebilirsiniz.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _savedJobTile(
    BuildContext context,
    JobModel job,
    SavedJobsProvider provider,
  ) {
    return Dismissible(
      key: ValueKey(job.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        provider.removeJob(job.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${job.title} kaldırıldı'),
            action: SnackBarAction(
              label: 'Geri Al',
              onPressed: () => provider.toggleSave(job),
            ),
          ),
        );
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 24),
        color: Colors.red.shade400,
        child: Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        onTap: () => JobDetailBottomSheet.show(context, job),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: job.category.color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(job.category.icon, color: job.category.color, size: 24),
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
              job.company ?? '',
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
            SizedBox(height: 2),
            Text(
              job.subtitle,
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
              '${job.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}₺',
              style: TextStyle(
                fontFamily: "Poppins",
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: () => provider.removeJob(job.id),
              child: Icon(
                Icons.bookmark,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
