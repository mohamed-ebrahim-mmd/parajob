class LatestReview {
  final int? id;
  final String? review;
  final double? rate;
  final String? createdAt;

  LatestReview({
    this.id,
    this.review,
    this.rate,
    this.createdAt,
  });

  factory LatestReview.fromJson(Map<String, dynamic> json) => LatestReview(
        id: json["id"],
        review: json["review"],
        rate: (json["rate"] as num?)?.toDouble(),
        createdAt: json["created_at"],
      );
}