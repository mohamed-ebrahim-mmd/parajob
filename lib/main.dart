import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:para_job/packages/api_client/src/models/requests/notification_token_request.dart';
import 'package:para_job/packages/api_client/src/service/api_client.dart';
import 'package:para_job/packages/api_client/src/service/dio_singleton_instance.dart';
import 'package:para_job/packages/themeing/theme.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

import 'packages/route_manager/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize GetStorage
  final apiClient = ApiClient(dio);

  // 🧪 TEST: Update device token
  try {
    final response = await apiClient.updateDeviceToken(
      NotificationtokenRequest(
        deviceToken:
            "cQYKPN7rTCCEEhD1gDLMTD:APA91bFScitHzqCRJmw3zrlBjIbwI069OUMsNz5TtzPdUUO7IjHxCkuhXO203V8IF25ws5C5bdQOmPJBmYwiq_mvrzYNcc6XV9OgqaUtbQd9YzL8LoEK1uVTS9mvmEdgMJn7w4oNP_Sg",
      ),
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWJkYWE0YTljYWRhYWVjMWVjOTA1OTI4NDhmNzM3MDNlZmM5NjVjNDEwYTU4YzQ5NjQ2MzVlNjhhNTRlNzhkYTE5MGY3M2QzMTg4ZDJiMDIiLCJpYXQiOjE3NjI5NTU3NDEuMDI3NzU0LCJuYmYiOjE3NjI5NTU3NDEuMDI3NzU4LCJleHAiOjE3OTQ0OTE3MzkuNjg3NTM5LCJzdWIiOiIyIiwic2NvcGVzIjpbInVzZXIiXX0.mF4eRgoNKKA40r04YeAjhUKovj9ZRomiZT4oycNBFKFJX9RbcgaQAQMHDNe94TrezXFKU5Y0-9nIR2QCHtpfDifCx8YVLR2PqXskAUYxtj3zkGQ4OTeqslz-txydyZ9YwHAE85NeBNdGvNQUMfnLIbi6BxtW-bEVkMC9gIKaSTGpk1Ks6sW5xjLbP72t4iadcnIuuMAHs2yRp0rVfee96xP7UZYtooCp_nT_S6kT99GSfgC7e9IlRNo79zqJ22bIc7klD1lnmBc5hcMcsci9gdH2ynzFIKe90G7yfC8TOeWbOjP_pWCF6dFZyQN6WOfmZz8_df4nMrhytW0UCRayDOvXKzj1wNxmJ_8GSrCKJPD7u_o_PqVH0mQq-nJ9Un1AOpe_I3DXdvTMDhF0rLzQ_uibmZFxeMFK8qR82K6TTfBWh010wrKUyU05GOA_vTJNAKvSPhZKq9mjqA0KUUPGuf9pMAMMKTklT-wvxjNRhIWqv4sTRLFQ9Hp5bKN-AQaq-NOTizaumLXSg_kuTu8X1S4fe-_IZmYm8uO6RdqtLBVrt6LtznFtHGb4yUarGrGOktyzWgLzKWnnUqtb9SrXTZkg-7RGsOfpapytBdp0KtEJfhiJiaXtfqj0MBAhfslmyRU3B1BPPaPX_UyhUSgbbgatSwh4cVpu1cGXEsrg_58", // 👈 حط التوكين الصحيح هنا
    );

    print("✅ Success: ${response.details.message}");
  } catch (e) {
    print("❌ Error: $e");
  }

  Get.put(RoutingController());
  Get.put(UserController()); // Instantiate RoutingController
  runApp(ParaJobApp());
}

class ParaJobApp extends StatelessWidget {
  final RoutingController routingController = Get.find();
  ParaJobApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(context),
      themeMode: ThemeMode.dark,
      title: 'Para Job',
      initialRoute: routingController.getInitialRoute(),
      //Routes.companyDetails,
      //routingController.getInitialRoute(),
      // Routes.createAccount,
      // Set initial route based on stored state
      getPages: AppPages.pages,
    );
  }
}
