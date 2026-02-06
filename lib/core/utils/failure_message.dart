import 'package:roadmap_ai/core/utils/failures.dart';

String failureMessage(Object error) {
  if (error is Failure) return error.message;
  return "$error";
}
