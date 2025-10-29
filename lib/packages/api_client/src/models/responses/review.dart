import 'package:para_job/packages/api_client/src/models/responses/user.dart';

class Review {
  final int? id;
  final String? review;
  final double? rate;
  final String? createdAt;
  final User? user;

  Review({this.id, this.review, this.rate, this.createdAt, this.user});

  factory Review.fromJson(Map<String, dynamic>? json) {
    double? parsedRate;
    if (json?['rate'] != null) {
      if (json!['rate'] is int) {
        parsedRate = (json['rate'] as int).toDouble();
      } else if (json['rate'] is double) {
        parsedRate = json['rate'] as double;
      } else {
        parsedRate = double.tryParse(json['rate'].toString());
      }
    }
    return Review(
      id: json?['id'],
      review: json?['review'],
      rate: parsedRate,
      createdAt: json?['created_at'],
      user: json?['user'] != null ? User.fromJson(json!['user']) : null,
    );
  }
}