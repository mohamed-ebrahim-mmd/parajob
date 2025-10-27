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

/// ✅ OTP Validation
String? validatePin(String pin) {
  final trimmed = pin.trim();

  if (trimmed.isEmpty) {
    return 'OTP cannot be empty';
  } else if (trimmed.length != 5) {
    return 'OTP must be exactly 5 digits';
  }

  return null;
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

String? validateMessage(String message) {
  final trimmedMessage = message.trim();

  if (trimmedMessage.isEmpty) {
    return 'Message cannot be empty';
  } else if (trimmedMessage.length < 10) {
    return 'Message must be at least 10 characters long';
  } else if (trimmedMessage.length > 100) {
    return 'Message is too long. Maximum 100 characters allowed';
  }

  return null; // Valid message
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
