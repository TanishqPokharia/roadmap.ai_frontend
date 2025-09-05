import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/core/utils/failures.dart';

abstract class Usecase<Params, Success> {
  TaskEither<Failure, Success> call(Params params);
}
