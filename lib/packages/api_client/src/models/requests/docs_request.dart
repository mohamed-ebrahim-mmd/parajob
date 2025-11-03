

class Documents {
  final String? nationalIdFront;
  final String? nationalIdBack;
  final String? profilePicture;
  final String? universityId;
  final String? cv;

  Documents({
    this.nationalIdFront,
    this.nationalIdBack,
    this.profilePicture,
    this.universityId,
    this.cv,
  });

  Map<String, dynamic> toJson() {
    return {
      "national_id_front": nationalIdFront,
      "national_id_back": nationalIdBack,
      "profile_picture": profilePicture,
      "university_id": universityId,
      "cv": cv,
    };
  }
}
