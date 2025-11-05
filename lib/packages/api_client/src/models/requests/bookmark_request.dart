/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 05/11/2025 3:43 PM
 ==================================================================
*/
class BookmarkRequest {
  final int jobId;

  BookmarkRequest({required this.jobId});

  Map<String, dynamic> toJson() => {'job_id': jobId};
}
