import 'package:dio/dio.dart';
import 'package:firebase_performance_dio/firebase_performance_dio.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/localization_manger/controller/localization_controller.dart';

final dio =
    Dio(
        BaseOptions(
          connectTimeout: const Duration(minutes: 1),
          receiveTimeout: const Duration(minutes: 1),
          sendTimeout: const Duration(minutes: 1),
          headers: {
            'Accept': 'application/json',
            'Locale':
                Get.find<LocalizationController>().currentLocale.languageCode,
          },
          receiveDataWhenStatusError: true,
          followRedirects: true,
        ),
      )
      ..interceptors.add(
        DioFirebasePerformanceInterceptor(),
      ); // This works globally!
