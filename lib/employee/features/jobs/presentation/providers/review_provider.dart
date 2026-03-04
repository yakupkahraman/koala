import 'package:flutter/material.dart';
import 'package:koala/employee/features/jobs/data/models/review_model.dart';
import 'package:koala/employee/features/jobs/data/repositories/review_repository.dart';

class ReviewProvider extends ChangeNotifier {
  final ReviewRepository _repository = ReviewRepository();

  List<ReviewModel> get reviews => _repository.reviews;

  bool hasReviewed(String jobId) => _repository.hasReviewed(jobId);

  Future<void> submitReview(ReviewModel review) async {
    await _repository.submitReview(review);
    notifyListeners();
  }
}
