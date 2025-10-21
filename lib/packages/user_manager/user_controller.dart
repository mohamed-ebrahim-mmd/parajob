/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 22/02/2025 5:23 PM
 ==================================================================
*/
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:para_job/packages/api_client/src/models/responses/user.dart'
    show User;

class UserController extends GetxController {
  /// Storage instance for persisting user data.
  final _storage = GetStorage();

  /// Reactive user state.
  final Rxn<User> _user = Rxn<User>();

  /// Reactive token state.
  final RxnString _token = RxnString();

  /// Checks if there is a user
  bool get isGuest => _user.value == null;

  /// Gets the current user.
  User? get user => _user.value;

  String? get token => _token.value;

  @override
  void onInit() {
    super.onInit();
    _loadUser(); // Load user data when controller initializes
  }

  /// Updates and saves user information.
  Future<void> updateUser(User newUser, String token) async {
    _user.value = newUser;
    _token.value = token;
    await _storage.write('user', newUser.toJson()); // Persist to storage
    await _storage.write('token', token);
  }

  /// Loads user data from storage.
  void _loadUser() {
    final storedUserJson = _storage.read('user');
    if (storedUserJson != null) {
      _user.value = User.fromJson(storedUserJson);
      _token.value = _storage.read('token');
    }
  }

  /// Clears user data and logs out.
  Future<void> clearUser() async {
    _user.value = null;
    _token.value = null;
    await _storage.remove('user'); // Remove from storage
    await _storage.remove('token');
  }
}
