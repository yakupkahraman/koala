/// İş ilanına başvuran kişi modeli
class BApplicantModel {
  final String id;
  final String fullName;
  final String jobTitle;
  final String profileImage;
  final String appliedDate;
  final String? coverLetter;

  const BApplicantModel({
    required this.id,
    required this.fullName,
    required this.jobTitle,
    required this.profileImage,
    required this.appliedDate,
    this.coverLetter,
  });
}
