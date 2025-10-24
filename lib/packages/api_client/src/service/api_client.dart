import 'package:dio/dio.dart';
import 'package:para_job/packages/api_client/src/models/responses/company_response.dart';
import 'package:para_job/packages/api_client/src/models/responses/company_reviews_response.dart';
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

  @GET("/api/job/{id}")
  Future<JobDetailsResponse> fetchJobDetails(@Path("id") int id);

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
  Future<CompanyResponse> fetchCompany(@Path("id") int id);

  @GET("/api/review/company/{id}")
  Future<CompanyReviewsResponse> fetchCompanyReviews({
    @Path("id") required int companyId,
    @Query('page') int? page,
  });

  @POST("/api/reset/password")
  Future<ResetPasswordResponse> resetPassword(
    @Body() ResetPasswordRequest request,
  );
}
