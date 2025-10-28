import 'package:dio/dio.dart';
import 'package:para_job/packages/api_client/src/models/responses/contract.dart';
import 'package:retrofit/retrofit.dart';

import '../models/models.dart';
import '../models/requests/application_verification_otp_request.dart';
import '../models/requests/application_verification_request.dart';
import '../models/responses/base_response.dart';
import '../models/responses/upload_file_response.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://para-jobs-be-staging.v4.mmd-technology.com')
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @GET("/api/user/home")
  Future<HomeResponse> fetchHomeJobs();

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

  @POST("/api/reset/password")
  Future<ResetPasswordResponse> resetPassword(
    @Body() ResetPasswordRequest request,
  );

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
}
