import 'package:dio/dio.dart';

import '../Failures/failures.dart';
import 'api_error_handler.dart';
import 'response_code.dart';
import 'response_message.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  /// Constructor for the ErrorHandler class.
  ErrorHandler.handle(dynamic error) {
    // Check if the error is a DioException
    if (error is DioException) {
      // Use APIErrorHandler to handle the DioException and obtain a Failure object
      failure = APIErrorHandler.handleAPIError(error);
    } else {
      // If the error is not a DioException, create a generic Failure object
      failure = Failure(
        code: APIResponseCode.unknown,
        message: APIResponseMessages.unknown,
      );
    }
  }

}
