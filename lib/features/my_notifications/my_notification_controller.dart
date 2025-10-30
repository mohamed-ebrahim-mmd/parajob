import 'package:get/get.dart';

import '../../packages/user_manager/user_controller.dart';

class MyNotificationController extends GetxController {
  final token = Get.find<UserController>().token!;
}
