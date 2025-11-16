/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2024-12-25 10:40 AM
 ==================================================================
*/
import 'package:get/get.dart';

String? validateEmail(String email) {
  final trimmedEmail = email.trim();

  if (trimmedEmail.isEmpty) {
    return 'validation_email_empty'.tr;
  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(trimmedEmail)) {
    return 'validation_email_invalid'.tr;
  }

  return null; // No error, email is valid
}

String? validatePin(String pin) {
  final trimmed = pin.trim();

  if (trimmed.isEmpty) {
    return 'validation_otp_empty'.tr;
  } else if (trimmed.length != 5) {
    return 'validation_otp_length'.tr;
  }

  return null;
}

String? validateEgyptianNationalId(String id) {
  final trimmed = id.trim();

  if (trimmed.isEmpty) {
    return 'validation_national_id_empty'.tr;
  }

  // Must be exactly 14 digits
  if (trimmed.length != 14) {
    return 'validation_national_id_length'.tr;
  }

  // Must contain only numbers
  if (!RegExp(r'^\d{14}$').hasMatch(trimmed)) {
    return 'validation_national_id_digits'.tr;
  }

  // Validate century (1 = 1800s, 2 = 1900s, 3 = 2000s)
  final century = int.parse(trimmed[0]);
  if (century < 2 || century > 3) {
    return 'validation_national_id_century'.tr;
  }

  // Validate birth date part (YYMMDD)
  final month = int.parse(trimmed.substring(3, 5));
  final day = int.parse(trimmed.substring(5, 7));

  if (month < 1 || month > 12) {
    return 'validation_national_id_month'.tr;
  }

  if (day < 1 || day > 31) {
    return 'validation_national_id_day'.tr;
  }

  return null; // ✅ Valid ID
}

String? validateEgyptianPhone(String phone) {
  final trimmedPhone = phone.trim();

  if (trimmedPhone.isEmpty) {
    return 'validation_phone_empty'.tr;
  }

  // Check both shape and length together
  if (!(trimmedPhone.startsWith('01') && trimmedPhone.length == 11)) {
    return 'validation_phone_format'.tr;
  }

  return null; // ✅ valid
}

String? validateName(String name) {
  final trimmedName = name.trim();

  if (trimmedName.isEmpty) {
    return 'validation_name_empty'.tr;
  } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(trimmedName)) {
    return 'validation_name_format'.tr;
  }

  return null; // No error, name is valid
}

String? validateMessage(String message) {
  final trimmedMessage = message.trim();

  if (trimmedMessage.isEmpty) {
    return 'validation_message_empty'.tr;
  } else if (trimmedMessage.length < 10) {
    return 'validation_message_min_length'.tr;
  } else if (trimmedMessage.length > 100) {
    return 'validation_message_max_length'.tr;
  }

  return null; // Valid message
}

String? validatePassword(String password) {
  final trimmedPassword = password.trim();

  if (trimmedPassword.isEmpty) {
    return 'validation_password_empty'.tr;
  } else if (trimmedPassword.length < 6) {
    return 'validation_password_min_length'.tr;
  }

  return null; // No error, password is valid
}

String? validateConfirmPassword(String password, String confirmPassword) {
  final trimmedConfirmPassword = confirmPassword.trim();

  if (trimmedConfirmPassword.isEmpty) {
    return 'validation_confirm_password_empty'.tr;
  } else if (trimmedConfirmPassword != password) {
    return 'validation_confirm_password_mismatch'.tr;
  }

  return null; // No error, confirm password is valid
}
