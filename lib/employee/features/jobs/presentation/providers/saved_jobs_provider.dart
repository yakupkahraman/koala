import 'package:flutter/material.dart';
import 'package:koala/employee/features/home/data/models/job_model.dart';

class SavedJobsProvider extends ChangeNotifier {
  final List<JobModel> _savedJobs = [];

  List<JobModel> get savedJobs => List.unmodifiable(_savedJobs);

  bool isSaved(String jobId) {
    return _savedJobs.any((job) => job.id == jobId);
  }

  void toggleSave(JobModel job) {
    final index = _savedJobs.indexWhere((j) => j.id == job.id);
    if (index != -1) {
      _savedJobs.removeAt(index);
    } else {
      _savedJobs.add(job);
    }
    notifyListeners();
  }

  void removeJob(String jobId) {
    _savedJobs.removeWhere((job) => job.id == jobId);
    notifyListeners();
  }
}
