/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2024-12-25 10:40 AM
 ==================================================================
*/

// validation_utils.dart

/// Validates the email address.
/// Returns an error message if invalid, otherwise null.
String? validateEmail(String email) {
  final trimmedEmail = email.trim();

  if (trimmedEmail.isEmpty) {
    return 'Email cannot be empty';
  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(trimmedEmail)) {
    return 'Invalid email format';
  }

  return null; // No error, email is valid
}

String? validateAddress(String address) {
  final trimmedAddress = address.trim();

  if (trimmedAddress.isEmpty) {
    return 'Address cannot be empty';
  } else if (trimmedAddress.length < 5) {
    return 'Address is too short';
  }

  return null; // No error, address is valid
}

String? validatePostalCode(String postalCode) {
  final trimmedPostalCode = postalCode.trim();

  if (trimmedPostalCode.isEmpty) {
    return 'Postal code cannot be empty';
  } else if (!RegExp(r'^\d{5}$').hasMatch(trimmedPostalCode)) {
    return 'Invalid postal code. Must be exactly 5 digits.';
  }

  return null; // No error, postal code is valid
}

String? validateEgyptianPhone(String phone) {
  final trimmedPhone = phone.trim();

  if (trimmedPhone.isEmpty) {
    return 'Phone number cannot be empty';
  }

  // Check both shape and length together
  if (!(trimmedPhone.startsWith('01') && trimmedPhone.length == 11)) {
    return 'Phone number must be 11 digits (e.g. 01*********)';
  }

  return null; // ✅ valid
}

String? validateName(String name) {
  final trimmedName = name.trim();

  if (trimmedName.isEmpty) {
    return 'Name cannot be empty';
  } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(trimmedName)) {
    return 'Invalid name format. Only letters and spaces are allowed.';
  }

  return null; // No error, name is valid
}

/// Validates the password.
/// Returns an error message if invalid, otherwise null.
String? validatePassword(String password) {
  final trimmedPassword = password.trim();

  if (trimmedPassword.isEmpty) {
    return 'Password cannot be empty';
  } else if (trimmedPassword.length < 6) {
    return 'Password must be at least 6 characters';
  }

  return null; // No error, password is valid
}

String? validateConfirmPassword(String password, String confirmPassword) {
  final trimmedConfirmPassword = confirmPassword.trim();

  if (trimmedConfirmPassword.isEmpty) {
    return 'Confirm Password cannot be empty';
  } else if (trimmedConfirmPassword != password) {
    return 'Passwords do not match';
  }

  return null; // No error, confirm password is valid
}
