class Failure {
  final String errorMessage;
  Failure(this.errorMessage);
}

class FirebaseFailure extends Failure {
  FirebaseFailure(String errorMessage) : super(errorMessage);
}
