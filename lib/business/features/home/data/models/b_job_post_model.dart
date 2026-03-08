import 'package:koala/employee/features/home/data/models/job_model.dart';
import 'package:koala/business/features/home/data/models/b_applicant_model.dart';

/// İşveren tarafında iş ilanı + başvuranlar modeli
class BJobPostModel {
  final JobModel job;
  final bool isActive;
  final List<BApplicantModel> applicants;
  final BApplicantModel? worker;
  final DateTime createdAt;

  const BJobPostModel({
    required this.job,
    required this.isActive,
    this.applicants = const [],
    this.worker,
    required this.createdAt,
  });

  BJobPostModel copyWith({
    JobModel? job,
    bool? isActive,
    List<BApplicantModel>? applicants,
    BApplicantModel? worker,
    DateTime? createdAt,
  }) {
    return BJobPostModel(
      job: job ?? this.job,
      isActive: isActive ?? this.isActive,
      applicants: applicants ?? this.applicants,
      worker: worker ?? this.worker,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
