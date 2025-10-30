import 'package:para_job/packages/api_client/src/models/requests/documents.dart';

class EditUserRequest {
  final String? name;
  final int? cityId;
  final int? areaId;
  final String? gender;
  final String? dateOfBirth;
  final String? educationStatus;
  final List<int>? skills;
  final String? additionalSkills;
  final int? universityId;
  final int? facultyId;
  final String? graduationYear;
  final Documents? documents;

  EditUserRequest({
    this.name,
    this.cityId,
    this.areaId,
    this.gender,
    this.dateOfBirth,
    this.educationStatus,
    this.skills,
    this.additionalSkills,
    this.universityId,
    this.facultyId,
    this.graduationYear,
    this.documents,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "city_id": cityId,
      "area_id": areaId,
      "gender": gender,
      "date_of_birth": dateOfBirth,
      "education_status": educationStatus,
      "skills": skills,
      "additional_skills": additionalSkills,
      "university_id": universityId,
      "faculty_id": facultyId,
      "graduation_year": graduationYear,
      "documents": documents?.toJson(),
    };
  }
}
