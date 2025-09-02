sealed class Failure {
  final String message;
  Failure(this.message);
  @override
  String toString() => 'Failure: $message';
}

// Token Storage Failure
class TokenStorageFailure extends Failure {
  TokenStorageFailure(super.message);

  @override
  String toString() => 'TokenStorageFailure: $message';
}

// Http Failures

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure(super.message);
  @override
  String toString() => 'UnauthorizedFailure: $message';
}

class NotFoundFailure extends Failure {
  NotFoundFailure(super.message);

  @override
  String toString() => 'NotFoundFailure: $message';
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  @override
  String toString() => 'ServerFailure: $message';
}

// fix all the below

class BadRequestFailure extends Failure {
  BadRequestFailure(super.message);

  @override
  String toString() => 'BadRequestFailure: $message';
}

class ForbiddenFailure extends Failure {
  ForbiddenFailure(super.message);

  @override
  String toString() => 'ForbiddenFailure: $message';
}

class UnknownFailure extends Failure {
  UnknownFailure(super.message);

  @override
  String toString() => 'UnknownFailure: $message';
}
