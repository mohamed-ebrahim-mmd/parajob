import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/models.dart';

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

  @GET("/api/job/{id}")
  Future<JobDetailsResponse> fetchJobDetails(@Path("id") int id);

  @GET("/api/company/{id}")
  Future<CompanyDetailsResponse> fetchCompanyDetails(@Path("id") int id);

  @GET("/api/job")
  Future<JobListResponse> fetchJobs({
    @Query("filter[category]") String? category,
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
}
