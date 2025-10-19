/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-19 9:42 AM
 ==================================================================
*/
class User {
  final int? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? gender;
  final String? city;
  final String? area;
  final String? university;
  final String? faculty;
  final bool? isApproved;
  final bool? isCompleted;
  final bool? isBlocked;
  final String? rejectionReason;
  final String? additionalSkills;
  final List<String>? skills;
  final String? graduationYear;
  final String? educationStatus;
  final String? profilePicture;
  final String? nationalIdFront;
  final String? nationalIdBack;
  final String? universityId;
  final String? cv;
  final String? accountStatus;

  User({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.city,
    this.area,
    this.university,
    this.faculty,
    this.isApproved,
    this.isCompleted,
    this.isBlocked,
    this.rejectionReason,
    this.additionalSkills,
    this.skills,
    this.graduationYear,
    this.educationStatus,
    this.profilePicture,
    this.nationalIdFront,
    this.nationalIdBack,
    this.universityId,
    this.cv,
    this.accountStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      city: json['city'],
      area: json['area'],
      university: json['university'],
      faculty: json['faculty'],
      isApproved: json['is_approved'],
      isCompleted: json['is_completed'],
      isBlocked: json['is_blocked'],
      rejectionReason: json['rejection_reason'],
      additionalSkills: json['additional_skills'],
      skills: json['skills'] != null ? List<String>.from(json['skills']) : [],
      graduationYear: json['graduation_year'],
      educationStatus: json['education_status'],
      profilePicture: json['profile_picture'],
      nationalIdFront: json['national_id_front'],
      nationalIdBack: json['national_id_back'],
      universityId: json['university_id'],
      cv: json['cv'],
      accountStatus: json['account_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'city': city,
      'area': area,
      'university': university,
      'faculty': faculty,
      'is_approved': isApproved,
      'is_completed': isCompleted,
      'is_blocked': isBlocked,
      'rejection_reason': rejectionReason,
      'additional_skills': additionalSkills,
      'skills': skills,
      'graduation_year': graduationYear,
      'education_status': educationStatus,
      'profile_picture': profilePicture,
      'national_id_front': nationalIdFront,
      'national_id_back': nationalIdBack,
      'university_id': universityId,
      'cv': cv,
      'account_status': accountStatus,
    };
  }
}
