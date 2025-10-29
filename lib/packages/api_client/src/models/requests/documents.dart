/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-28 11:36 AM
 ==================================================================
*/
class Documents {
  String? profilePicture;
  String? nationalIdFront;
  String? nationalIdBack;
  String? universityId;
  String? cv;

  Documents({
    this.profilePicture,
    this.nationalIdFront,
    this.nationalIdBack,
    this.universityId,
    this.cv,
  });

  Map<String, dynamic> toJson() => {
    if (profilePicture != null) "profile_picture": profilePicture,
    if (nationalIdFront != null) "national_id_front": nationalIdFront,
    if (nationalIdBack != null) "national_id_back": nationalIdBack,
    if (universityId != null) "university_id": universityId,
    if (cv != null) "cv": cv,
  };
}
