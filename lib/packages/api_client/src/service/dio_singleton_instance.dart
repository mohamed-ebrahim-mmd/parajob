import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 15),
    headers: {'Accept': 'application/json'},
    receiveDataWhenStatusError: true,
    followRedirects: true,
  ),
);
