import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/localization_manger/controller/localization_controller.dart';

final dio = Dio(
  BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 15),
    headers: {
      'Accept': 'application/json',
      'Locale': Get.find<LocalizationController>().currentLocale.languageCode,
    },
    receiveDataWhenStatusError: true,
    followRedirects: true,
  ),
);
