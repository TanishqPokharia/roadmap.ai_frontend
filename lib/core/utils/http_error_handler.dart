import 'package:roadmap_ai/core/utils/failures.dart';

Failure httpErrorHandler(int statusCode) {
  switch (statusCode) {
    case 400:
      return BadRequestFailure('Bad Request');
    case 401:
      return UnauthorizedFailure('Unauthorized');
    case 403:
      return ForbiddenFailure('Forbidden');
    case 404:
      return NotFoundFailure('Not Found');
    case 500:
      return ServerFailure('Internal Server Error');
    default:
      return UnknownFailure('Unknown Error');
  }
}
