import 'package:dio/dio.dart';
import 'package:weather_app_assignment4/app/core/error/failures.dart';

class ErrorHandler {
  static Failure handle(dynamic e, StackTrace stack) {
    if (e is DioException) {
      print('DioException type: ${e.type}');
      print('DioException message: ${e.message}');
      print('DioException response data: ${e.response?.data}');
      print('DioException status code: ${e.response?.statusCode}');
    }

    if (e is DioException) {
      return mapDioExceptionToFailure(e, stack);
    } else {
      final maybeException = e is Exception ? e : null;
      return UnexpectedFailure(
        'Unexpected error occurred. Please try again.',
        maybeException,
        stack,
      );
    }
  }

  static Failure mapDioExceptionToFailure(DioException e, StackTrace stack) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          "Connection timed out. Please try again.",
          e,
          stack,
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          "Send timeout. Please check your network and try again.",
          e,
          stack,
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          "Receive timeout. Please check your connection and try again.",
          e,
          stack,
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(
          "Bad certificate. Please check your device or network settings.",
          e,
          stack,
        );
      case DioExceptionType.badResponse:
        return ServerFailure(
          _getErrorMessageFromResponse(e.response),
          e,
          stack,
        );
      case DioExceptionType.cancel:
        return ServerFailure("Request cancelled. Please try again.", e, stack);
      case DioExceptionType.connectionError:
        return ServerFailure(
          "Network error. Please check your internet connection.",
          e,
          stack,
        );
      case DioExceptionType.unknown:
      default:
        return UnexpectedFailure(
          "Something went wrong. Please try again later.",
          e,
          stack,
        );
    }
  }

  static String _getErrorMessageFromResponse(Response? response) {
    if (response == null) return "Unknown error";

    final data = response.data;
    if (data is Map<String, dynamic> && data.containsKey('status_message')) {
      return data['status_message'];
    }

    return _getFallbackMessage(response.statusCode);
  }

  static String _getFallbackMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return "Bad request. Please try again.";
      case 401:
        return "Unauthorized access. Please log in again.";
      case 403:
        return "Access forbidden.";
      case 404:
        return "Resource not found.";
      case 498:
        return "Session expired. Please log in again.";
      case 500:
        return "Server error. Please try again later.";
      case 503:
        return "Service unavailable. Please try again later.";
      default:
        return "An unexpected error occurred.";
    }
  }
}
