abstract class Failure {
  final String message;
  final Exception? exception;
  final StackTrace? stackTrace;

  Failure(this.message, [this.exception, this.stackTrace]);
}

class ServerFailure extends Failure {
  ServerFailure(String message, [Exception? exception, StackTrace? stackTrace])
    : super(message, exception, stackTrace);
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure(
    String message, [
    Exception? exception,
    StackTrace? stackTrace,
  ]) : super(message, exception, stackTrace);
}
