/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-28 11:35 AM
 ==================================================================
*/
import 'package:para_job/packages/api_client/src/models/requests/documents.dart'
    show Documents;

class RegisterRequestModel {
  String? name;
  String? email;
  int? cityId;
  int? areaId;
  String? phoneNumber;
  String? gender;
  String? dateOfBirth;
  String? nationalId;
  List<int>? skills;
  String? additionalSkills;
  int? graduationYear;
  String? educationStatus;
  Documents? documents;
  String? password;
  String? passwordConfirmation;

  RegisterRequestModel({
    this.name,
    this.email,
    this.cityId,
    this.areaId,
    this.phoneNumber,
    this.gender,
    this.dateOfBirth,
    this.nationalId,
    this.skills,
    this.additionalSkills,
    this.graduationYear,
    this.educationStatus,
    this.documents,
    this.password,
    this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() => {
    if (name != null) "name": name,
    if (email != null) "email": email,
    if (cityId != null) "city_id": cityId,
    if (areaId != null) "area_id": areaId,
    if (phoneNumber != null) "phone_number": phoneNumber,
    if (gender != null) "gender": gender,
    if (dateOfBirth != null) "date_of_birth": dateOfBirth,
    if (nationalId != null) "national_id": nationalId,
    if (skills != null) "skills": skills,
    if (additionalSkills != null) "additional_skills": additionalSkills,
    if (graduationYear != null) "graduation_year": graduationYear,
    if (educationStatus != null) "education_status": educationStatus,
    if (documents != null) "documents": documents!.toJson(),
    if (password != null) "password": password,
    if (passwordConfirmation != null)
      "password_confirmation": passwordConfirmation,
  };

  @override
  String toString() {
    return 'RegisterRequestModel{name: $name, email: $email, cityId: $cityId, areaId: $areaId, phoneNumber: $phoneNumber, gender: $gender, dateOfBirth: $dateOfBirth, nationalId: $nationalId, skills: $skills, additionalSkills: $additionalSkills, graduationYear: $graduationYear, educationStatus: $educationStatus, documents: $documents, password: $password, passwordConfirmation: $passwordConfirmation}';
  }
}
