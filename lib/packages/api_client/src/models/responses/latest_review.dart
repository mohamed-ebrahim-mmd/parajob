import 'package:para_job/packages/api_client/src/models/responses/reviewer.dart';

class LatestReview {
  final int? id;
  final String? review;
  final double? rate;
  final String? createdAt;
  final Reviewer? reviwer;

  LatestReview({this.id, this.review, this.rate, this.createdAt, this.reviwer});

  factory LatestReview.fromJson(Map<String, dynamic> json) => LatestReview(
    id: json["id"],
    review: json["review"],
    rate: (json["rate"] as num?)?.toDouble(),
    createdAt: json["created_at"],
    reviwer: Reviewer.fromJson(json["user"]),
  );
}
