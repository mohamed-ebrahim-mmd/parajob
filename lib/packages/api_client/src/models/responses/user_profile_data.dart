import 'package:para_job/packages/api_client/src/models/models.dart';

// class UserProfileData {
//   final int? id;
//   final String? name;
//   final String? profilePicture;
//   final int? jobsCount;
//   final String? income;
//   final int? companiesCount;
//   final List<Job>? jobs;
//   final List<Job>? savedJobs;
//   final int? strikeCount;
//   final List<dynamic>? strikeHistory;

//   UserProfileData({
//     this.id,
//     this.name,
//     this.profilePicture,
//     this.jobsCount,
//     this.income,
//     this.companiesCount,
//     this.jobs,
//     this.savedJobs,
//     this.strikeCount,
//     this.strikeHistory,
//   });

//   factory UserProfileData.fromJson(Map<String, dynamic> json) {
//     return UserProfileData(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? '',
//       profilePicture: json['profile_picture'] ?? '',
//       jobsCount: json['jobs_count'] ?? 0,
//       income: json['income'] ?? '',
//       companiesCount: int.tryParse(json['companies_count'].toString()) ?? 0,
//       jobs: (json['jobs'] as List<dynamic>?)
//               ?.map((e) => Job.fromJson(e as Map<String, dynamic>))
//               .toList() ??
//           [],
//       savedJobs: (json['saved_jobs'] as List<dynamic>?)
//               ?.map((e) => Job.fromJson(e as Map<String, dynamic>))
//               .toList() ??
//           [],
//       strikeCount: json['strike_count'] ?? 0,
//       strikeHistory: json['strike_history'] ?? [],
//     );
//   }

// }

class UserProfileData {
  final int? id;
  final String? name;
  final String? profilePicture;
  final int? jobsCount;
  final String? income;
  final String? companiesCount;
  final List<Job>? jobs;
  final List<Job>? savedJobs;
  final int? strikeCount;
  final List<dynamic>? strikeHistory;

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
  final List<Skill>? additionalSkills;
  final List<Skill>? skills;
  final String? graduationYear;
  final String? educationStatus;
  final String? nationalIdFront;
  final String? nationalIdBack;
  final String? universityId;
  final String? cv;
  final String? accountStatus;
  final bool? isVerified;

  UserProfileData({
    this.id,
    this.name,
    this.profilePicture,
    this.jobsCount,
    this.income,
    this.companiesCount,
    this.jobs,
    this.savedJobs,
    this.strikeCount,
     this.strikeHistory,
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
    this.nationalIdFront,
    this.nationalIdBack,
    this.universityId,
    this.cv,
    this.accountStatus,
    this.isVerified,
  });

  /// Factory constructor to parse JSON from API
  factory UserProfileData.fromJson(Map<String, dynamic> json) {


     List<Job> safeJobList(dynamic data) {
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map((e) => Job.fromJson(e))
          .toList();
    }
    return [];
  }

  List<Skill> safeSkillList(dynamic data) {
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map((e) => Skill.fromJson(e))
          .toList();
    }
    return [];
  }




    return UserProfileData(
      id: json['id'],
      name: json['name'],
      profilePicture: json['profile_picture'],
      jobsCount: json['jobs_count'],
      income: json['income'],
      companiesCount: json['companies_count'],
      jobs:safeJobList(json['jobs']),
          // (json['jobs'] as List<dynamic>?)
          //     ?.map((e) => Job.fromJson(e as Map<String, dynamic>))
          //     .toList() ??
          // [],
      savedJobs:safeJobList(json['saved_jobs']),
          
      strikeCount: json['strike_count'],
      strikeHistory: json['strike_history'] ?? [],
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
      additionalSkills:safeSkillList(json['additional_skills']),
          // (json['additional_skills'] as List<dynamic>?)
          //     ?.map((e) => Skill.fromJson(e as Map<String, dynamic>))
          //     .toList() ??
          // [],
      skills:safeSkillList(json['skills']),
          
      graduationYear: json['graduation_year'],
      educationStatus: json['education_status'],
      nationalIdFront: json['national_id_front'],
      nationalIdBack: json['national_id_back'],
      universityId: json['university_id'],
      cv: json['cv'],
      accountStatus: json['account_status'],
      isVerified: json['is_verified'],
    );
  }
}
