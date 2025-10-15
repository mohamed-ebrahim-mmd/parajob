import 'package:dio/dio.dart';
import 'package:get/get.dart';

extension DioErrorExtension on DioException {
  String handleDioError() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'connectionTimeout'
            .tr; // Translate to "Timeout occurred while sending or receiving"

      case DioExceptionType.badResponse:
        final statusCode = response?.statusCode;
        if (statusCode != null) {
          switch (statusCode) {
            case 400:
              return '400'.tr; // Translate to "Bad Request"
            case 401:
            case 403:
              return '401'.tr; // Translate to "Unauthorized"
            case 404:
              return '404'.tr; // Translate to "Not Found"
            case 409:
              return '409'.tr; // Translate to "Conflict"
            case 500:
              return '500'.tr; // Translate to "Internal Server Error"
          }
        }
        break;

      case DioExceptionType.cancel:
        return 'cancel'.tr; // Translate to "Request was canceled"

      case DioExceptionType.unknown:
        return 'unknown'.tr; // Translate to "No Internet Connection"

      case DioExceptionType.badCertificate:
        return 'badCertificate'.tr; // Translate to "Internal Server Error"

      case DioExceptionType.connectionError:
        return 'connectionError'.tr; // Translate to "Connection Error"
      // Translate to "Unknown Error"
    }
    return "Unknown Error";
  }
}
