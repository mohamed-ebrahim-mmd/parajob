/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 22/02/2025 5:23 PM
 ==================================================================
*/
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  /// Storage instance for persisting user data.
  final _storage = GetStorage();

  /// Reactive user state.
  final Rxn<User> _user = Rxn<User>();

  /// Checks if there is a user
  bool get isGuest => _user.value == null;

  /// Gets the current user.
  User? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _loadUser(); // Load user data when controller initializes
  }

  /// Updates and saves user information.
  Future<void> updateUser(User newUser) async {
    _user.value = newUser;
    await _storage.write('user', newUser.toJson()); // Persist to storage
  }

  /// Loads user data from storage.
  void _loadUser() {
    final storedUserJson = _storage.read('user');
    if (storedUserJson != null) {
      _user.value = User.fromJson(storedUserJson);
    }
  }

  /// Clears user data and logs out.
  void clearUser() {
    _user.value = null;
    _storage.remove('user'); // Remove from storage
  }
}

/// **User Model**
class User {
  final String name;
  final String id;
  final String token;

  User({this.name = '', this.id = '', this.token = ''});

  /// Converts `User` object to JSON.
  Map<String, dynamic> toJson() => {'name': name, 'id': id, 'token': token};

  /// Creates `User` object from JSON.
  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json['name'] ?? '',
    id: json['id'] ?? '',
    token: json['token'] ?? '',
  );

  @override
  String toString() => 'User(name: $name, id: $id, token: $token)';
}
