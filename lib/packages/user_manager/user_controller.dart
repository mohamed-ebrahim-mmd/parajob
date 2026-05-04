/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 22/02/2025 5:23 PM
 ==================================================================
*/

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:para_job/packages/api_client/src/models/responses/user.dart';

class UserController extends GetxController {
  final _storage = GetStorage();
  final _secureStorage = const FlutterSecureStorage();

  final Rxn<User> _user = Rxn<User>();
  String? _token;

  bool get isGuest => _user.value == null;

  User? get user => _user.value;

  String? get token => _token;

  // 1. Change this to a public init method returning the class type
  Future<UserController> init() async {
    final storedUserJson = _storage.read('user');
    if (storedUserJson != null) {
      _user.value = User.fromJson(storedUserJson);
      _token = await _secureStorage.read(key: 'token');
    }
    // Return 'this' so Get.putAsync knows the service is ready
    return this;
  }

  Future<void> updateUser(User newUser, String token) async {
    _user.value = newUser;
    _token = token;
    await _storage.write('user', newUser.toJson());
    await _secureStorage.write(key: 'token', value: token);
  }

  Future<void> clearUser() async {
    _user.value = null;
    _token = null;
    await _storage.remove('user');
    await _secureStorage.delete(key: 'token');
  }
}
