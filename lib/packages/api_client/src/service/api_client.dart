import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/models.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://para-jobs-be-staging.v4.mmd-technology.com')
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @GET("/api/user/home")
  Future<HomeResponse> fetchHomeJobs(@Header("Authorization") String? token);

  @GET("/api/department")
  Future<DepartmentResponse> getDepartments();

  @GET("/api/skill")
  Future<SkillResponse> getSkills();

  @GET("/api/company")
  Future<CompanyListResponse> getCompanies();

  // 🏙️ Fetch all cities
  @GET("/api/city")
  Future<CityResponse> getCities();

  // 📍 Fetch areas for a specific city
  @GET("/api/area/city/{cityId}")
  Future<AreaResponse> getAreasByCity(@Path("cityId") int cityId);

  // 🎓 Fetch all universities
  @GET("/api/university")
  Future<UniversityResponse> getUniversities();

  // 🏫 Fetch faculties for a specific university
  @GET("/api/faculty/university/{universityId}")
  Future<FacultyResponse> getFacultiesByUniversity(
    @Path("universityId") int universityId,
  );

  @GET("/api/job/{id}")
  Future<JobDetailsResponse> fetchJobDetails(@Path("id") int id);

  @GET("/api/company/{id}")
  Future<CompanyDetailsResponse> fetchCompanyDetails(@Path("id") int id);

  @GET("/api/job")
  Future<JobListResponse> fetchJobs({
    @Query("filter[title]") String? title,
    @Query("filter[category]") String? category,
    @Query("filter[type]") String? type,
    @Query("filter[company_id]") int? companyId,
    @Query("filter[skills]") int? skillId,
    @Query("filter[department_id]") int? departmentId,
    @Query("page") int? page,
  });

  @GET("/api/user/jobs")
  Future<MyJobsResponse> fetchMyJobs({
    @Header('Authorization') required String token,
    @Query('filter[status]') String? status,
    @Query('page') int? page,
    @Query('per_page') int? perPage,
  });

  @POST("/api/user/login")
  Future<LoginWithMailResponse> loginWithMail(
    @Body() LoginWithMailRequest request,
  );

  @POST("/api/send/otp")
  Future<SendOtpResponse> sendOtp(@Body() SendOtpRequest request);

  @GET("/api/verify/otp")
  Future<VerifyOtpResponse> verifyOtp(@Body() VerifyOtpRequest request);

  @GET("/api/company/{id}")
  Future<CompanyResponse> fetchCompany({
    @Header('Authorization') String? token,
    @Path("id") required int id,
  });

  @GET("/api/review/company/{id}")
  Future<CompanyReviewsResponse> fetchCompanyReviews({
    @Path("id") required int companyId,
    @Query('page') int? page,
  });

  @POST("/api/review")
  Future<SubmitReviewResponse> submitReview({
    @Header('Authorization') required String token,
    @Body() required SubmitReviewRequest request,
  });

  @POST("/api/reset/password")
  Future<ResetPasswordResponse> resetPassword(
    @Body() ResetPasswordRequest request,
  );

  @POST('/api/user/register')
  Future<RegisterResponse> registerUser(@Body() RegisterRequestModel request);

  @GET("/api/page/slug/about-parajob-mobile")
  Future<AboutUsResponse> getAboutUs();

  @GET("/api/user/profile")
  Future<UserProfileResponse> fetchUserProfile({
    @Header('Authorization') required String token,
  });

  @GET("/api/page/slug/contract")
  Future<ContractResponse> getContract();

  @POST("/api/job/{jobId}/application/verification")
  Future<VerifyOtpResponse> applicationVerificationOtp({
    @Header('Authorization') required String token,
    @Path("jobId") required int jobId,
    @Body() required ApplicationVerificationOtpRequest request,
  });

  @POST("/api/contract")
  Future<BaseResponse> applicationVerification({
    @Header('Authorization') required String token,
    @Body() required ApplicationVerificationRequest request,
  });

  @POST("/api/upload")
  Future<UploadFileResponse> uploadFile(
    @Part(name: "files[]") List<MultipartFile> files,
  );

  @GET("/api/notification")
  Future<MyNotificationsResponse> getNotifications({
    @Header('Authorization') required String token,
    @Query('page') int? page,
  });

  @POST("/api/contactus/store")
  Future<ContactUsResponse> contactUs(@Body() ContactUsRequest request);

  @GET("/api/contact/info")
  Future<ContactInfoResponse> getContactInfo();

  @DELETE("/api/user")
  Future<DeleteAccountResponse> deleteAccount({
    @Header('Authorization') required String token,
  });

  @PUT("/api/user/change/photo")
  Future<UpdateUserPhotoResponse> updateUserPhoto(
    @Body() UpdateUserPhotoRequest request,
    @Header("Authorization") String token,
  );

  @DELETE("/api/user/delete/photo")
  Future<DeleteUserPhoto> deleteUserPhoto({
    @Header('Authorization') required String token,
  });

  @PUT("/api/user")
  Future<EditUserResponse> updateUserProfile(
    @Body() EditUserRequest request,
    @Header("Authorization") String token,
  );

  // --- Add Bookmark ---
  @POST("/api/bookmark")
  Future<BaseResponse> addBookmark(
    @Body() BookmarkRequest request,
    @Header("Authorization") String token,
  );

  // --- Delete Bookmark ---
  @DELETE("/api/bookmark")
  Future<BaseResponse> deleteBookmark(
    @Body() BookmarkRequest request,
    @Header("Authorization") String token,
  );

  @GET("/api/bookmark")
  Future<BookmarkedJobsResponse> fetchBookmark({
    @Header('Authorization') String? token,
    @Query("page") int? page,
  });
}
