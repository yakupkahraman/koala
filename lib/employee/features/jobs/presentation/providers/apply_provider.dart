import 'package:flutter/material.dart';
import 'package:koala/employee/features/home/data/models/job_model.dart';
import 'package:koala/employee/features/jobs/data/models/my_jobs_model.dart';

class ApplyProvider extends ChangeNotifier {
  final List<MyJobsModel> _appliedJobs = [];

  List<MyJobsModel> get appliedJobs => List.unmodifiable(_appliedJobs);

  bool hasApplied(String jobId) {
    return _appliedJobs.any((job) => job.id == 'applied_$jobId');
  }

  void applyToJob(JobModel job, {String? coverLetter}) {
    if (hasApplied(job.id)) return;

    final now = DateTime.now();
    final dateStr =
        '${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}';

    final myJob = MyJobsModel(
      id: 'applied_${job.id}',
      title: job.title,
      company: job.company ?? 'Bilinmeyen Şirket',
      description: job.description ?? job.subtitle,
      date: dateStr,
      price: job.price,
      status: MyJobStatus.pending,
    );

    _appliedJobs.insert(0, myJob);
    notifyListeners();
  }
}