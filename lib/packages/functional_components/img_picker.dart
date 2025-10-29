/* import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';


/// Pick a single image (jpg, jpeg, png) and return it as MultipartFile.
Future<MultipartFile?> pickImageAsMultipart({bool fromCamera = false}) async {
  final ImagePicker picker = ImagePicker();

  try {
    final XFile? pickedFile = await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 85, // optional compression
    );

    if (pickedFile == null) return null;

    final ext = pickedFile.path.split('.').last.toLowerCase();
    if (!['jpg', 'jpeg', 'png'].contains(ext)) {
      throw Exception('Unsupported file type: $ext');
    }

    final multipartFile = await MultipartFile.fromFile(
      pickedFile.path,
      filename: pickedFile.name,
    );

    log("📸 Picked image: ${pickedFile.name}");
    return multipartFile;
  } catch (e) {
    log("❌ Error picking image: $e");
    return null;
  }
}
 */


import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

/// Pick a single image (jpg, jpeg, png) and return it as a File.
Future<File?> pickImageFile({bool fromCamera = false}) async {
  final ImagePicker picker = ImagePicker();

  try {
    final XFile? pickedFile = await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 85, // optional compression
    );

    if (pickedFile == null) return null;

    final ext = pickedFile.path.split('.').last.toLowerCase();
    if (!['jpg', 'jpeg', 'png'].contains(ext)) {
      throw Exception('Unsupported file type: $ext');
    }

    final file = File(pickedFile.path);

    log("📸 Picked image file: ${file.path}");
    return file;
  } catch (e) {
    log("❌ Error picking image: $e");
    return null;
  }
}
