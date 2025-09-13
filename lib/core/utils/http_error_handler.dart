import 'package:roadmap_ai/core/utils/failures.dart';

/// A decoupled utility function to handle HTTP errors based on status codes and return user-friendly messages.
Failure httpErrorHandler(int statusCode) {
  switch (statusCode) {
    case 400:
      return BadRequestFailure('Invalid input, please check and try again');
    case 401:
      return UnauthorizedFailure('You need to log in to access this resource');
    case 403:
      return ForbiddenFailure('Access Denied!, you do not have permission');
    case 404:
      return NotFoundFailure('The requested resource was not found');
    case 500:
      return ServerFailure('Server error, please try again later');
    default:
      return UnknownFailure('An unknown error occurred, please try again');
  }
}
