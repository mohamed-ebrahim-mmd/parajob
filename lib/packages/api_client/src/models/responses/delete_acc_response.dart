class DeleteAccountResponse {
  final bool isSuccess;
  //final  details;

  DeleteAccountResponse({
    required this.isSuccess,
    //required this.details,
  });

  factory DeleteAccountResponse.fromJson(Map<String, dynamic> json) {
    return DeleteAccountResponse(
      isSuccess: json['is_success'] ?? false,
      
     // details: Details.fromJson(json['details'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'is_success': isSuccess,
       // 'details': details.toJson(),
      };
}