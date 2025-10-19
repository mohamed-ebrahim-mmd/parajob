/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 23/02/2025 8:18 AM
 ==================================================================
*/
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:para_job/packages/api_client/src/models/responses/user.dart'
    show User;
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class RoutingController extends GetxController {
  // Define a variable to store the current screen route in GetStorage
  final _navigationState = Routes.onboarding.val(
    'navigationState',
  ); // Default to onboarding screen

  // Method to set the navigation state to login screen from the onboarding
  Future<void> goAuthChoiceScreen() async {
    _navigationState.val = Routes.authChoice;
    await Get.offAllNamed(Routes.authChoice); // Navigate back to LoginScreen
  }

  // Method to set the navigation state to login screen
  Future<void> logOut() async {
    await Get.find<UserController>().clearUser();
    _navigationState.val = Routes.authChoice;
    await Get.offAllNamed(Routes.authChoice);
  }

  // Method to set the navigation state to home screen as a logged-in user
  Future<void> goHomeAsUser(User user) async {
    await Get.find<UserController>().updateUser(user);
    _navigationState.val = Routes.mainNavigator;
    await Get.offAllNamed(Routes.mainNavigator); // Navigate back to LoginScreen
  }

  // Method to set the navigation state to home screen as a guest user
  Future<void> goHomeAsGuest() async {
    _navigationState.val = Routes.mainNavigator;
    await Get.offAllNamed(Routes.mainNavigator); // Navigate back to LoginScreen
  }

  // Method to get the initial route based on the current navigation state
  String getInitialRoute() {
    return _navigationState.val; // Directly return the value from storage
  }
}
