class UpdateUserPhotoRequest {
  final String? profilePicture;

  UpdateUserPhotoRequest({this.profilePicture});



  Map<String, dynamic> toJson() {
    return {
      'profile_picture': profilePicture,
    };
  }
}
