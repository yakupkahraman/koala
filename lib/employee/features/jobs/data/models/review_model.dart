class ReviewModel {
  final String id;
  final String jobId;
  final String jobTitle;
  final String company;
  final int rating;
  final String comment;
  final bool isAnonymous;
  final DateTime createdAt;

  const ReviewModel({
    required this.id,
    required this.jobId,
    required this.jobTitle,
    required this.company,
    required this.rating,
    required this.comment,
    required this.isAnonymous,
    required this.createdAt,
  });
}
