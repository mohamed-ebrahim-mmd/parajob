/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-23 11:49 AM
 ==================================================================
*/
import 'package:get/get.dart';
import 'package:para_job/packages/api_client/api_client.dart';

class SearchJobController extends GetxController {
  // Unified call state
  final searchDataCallState = ApiCallState.loading.obs;

  // Data
  List<Skill> skills = [];
  List<CompanyListItem> companies = [];

  @override
  void onInit() {
    super.onInit();
    fetchSearchData();
  }

  Future<void> fetchSearchData() async {
    searchDataCallState.value = ApiCallState.loading;

    try {
      final results = await Future.wait([
        apiClient.getSkills(),
        apiClient.getCompanies(),
      ]);

      final skillsResponse = results[0] as SkillResponse;
      final companiesResponse = results[1] as CompanyListResponse;

      if (skillsResponse.isSuccess && companiesResponse.isSuccess) {
        skills = skillsResponse.data;
        companies = companiesResponse.data;
        searchDataCallState.value = ApiCallState.success;
      } else {
        searchDataCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      searchDataCallState.value = ApiCallState.failure;
    }
  }
}
