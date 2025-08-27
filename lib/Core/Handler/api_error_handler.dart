import 'package:dio/dio.dart';

import '../Failures/failures.dart';
import 'response_code.dart';
import 'response_message.dart';

/// A class containing a static method for handling DioException and mapping it to a Failure object.
///
///  It contains a static method [handleAPIError] for handling DioException
///  and mapping it to a Failure object. This class is designed to handle
///  various error scenarios and provide meaningful failure information based
///  on the type of exception.
abstract class APIErrorHandler {
  /// Handle DioException and return a corresponding Failure object.
  static Failure handleAPIError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return Failure(
          code: APIResponseCode.connectTimeout,
          message: APIResponseMessages.connectTimeout,
        );
      case DioExceptionType.sendTimeout:
        return Failure(
          code: APIResponseCode.sendTimeout,
          message: APIResponseMessages.sendTimeout,
        );
      case DioExceptionType.receiveTimeout:
        return Failure(
          code: APIResponseCode.receiveTimeout,
          message: APIResponseMessages.receiveTimeout,
        );
      case DioExceptionType.badResponse:
        final errorMessage = dioException.response?.data['message'];
        switch (dioException.response?.statusCode) {
          // Success responses
          case APIResponseCode.success:
            return Failure(
              code: APIResponseCode.success,
              message: errorMessage ?? APIResponseMessages.success,
            );
          case APIResponseCode.noContent:
            return Failure(
              code: APIResponseCode.noContent,
              message: errorMessage ?? APIResponseMessages.noContent,
            );

          // Client errors
          case APIResponseCode.badRequest:
            return Failure(
              code: APIResponseCode.badRequest,
              message: errorMessage ?? APIResponseMessages.badRequest,
            );
          case APIResponseCode.conflict:
            return Failure(
              code: APIResponseCode.conflict,
              message: errorMessage ?? APIResponseMessages.conflict,
            );
          case APIResponseCode.methodNotAllowed:
            return Failure(
              code: APIResponseCode.methodNotAllowed,
              message: errorMessage ?? APIResponseMessages.conflict,
            );
          case APIResponseCode.unauthorized:
            return Failure(
              code: APIResponseCode.unauthorized,
              message: errorMessage ?? APIResponseMessages.unauthorized,
            );
          case APIResponseCode.forbidden:
            return Failure(
              code: APIResponseCode.forbidden,
              message: errorMessage ?? APIResponseMessages.forbidden,
            );
          case APIResponseCode.notFound:
            return Failure(
              code: APIResponseCode.notFound,
              message: errorMessage ?? APIResponseMessages.notFound,
            );

          // Server error
          case APIResponseCode.internalServerError:
            return Failure(
              code: APIResponseCode.internalServerError,
              message: errorMessage ?? APIResponseMessages.internalServerError,
            );

          // Default case for unknown status codes
          default:
            return Failure(
              code: APIResponseCode.unknown,
              message: APIResponseMessages.unknown,
            );
        }
      case DioExceptionType.cancel:
        return Failure(
          code: APIResponseCode.cancel,
          message: APIResponseMessages.cancel,
        );
      case DioExceptionType.badCertificate:
        return Failure(
          code: APIResponseCode.badRequest,
          message: APIResponseMessages.badRequest,
        );
      case DioExceptionType.connectionError:
        return Failure(
          code: APIResponseCode.connectTimeout,
          message: APIResponseMessages.connectTimeout,
        );
      case DioExceptionType.unknown:
        return Failure(
          code: APIResponseCode.unknown,
          message: APIResponseMessages.unknown,
        );
    }
  }
}
