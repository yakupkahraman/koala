import 'package:koala/employee/features/jobs/data/models/review_model.dart';

class ReviewRepository {
  static final ReviewRepository _instance = ReviewRepository._internal();
  factory ReviewRepository() => _instance;
  ReviewRepository._internal();

  final List<ReviewModel> _reviews = [];

  List<ReviewModel> get reviews => List.unmodifiable(_reviews);

  Future<void> submitReview(ReviewModel review) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _reviews.add(review);
  }

  bool hasReviewed(String jobId) {
    return _reviews.any((r) => r.jobId == jobId);
  }
}
