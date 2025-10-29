class SubmitReviewRequest {
  final String review;
  final double rate;
  final int companyId;
  final bool isAnonymous;

  SubmitReviewRequest({
    required this.review,
    required this.rate,
    required this.companyId,
    this.isAnonymous = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'review': review,
      'rate': rate,
      'company_id': companyId,
      'is_anonymous': isAnonymous,
    };
  }
  @override
  String toString() {
    return 'SubmitReviewRequest(review: $review, rate: $rate, companyId: $companyId, isAnonymous: $isAnonymous)';
  }
}
