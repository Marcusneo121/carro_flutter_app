enum ViewState {
  idle,
  busy, // loading
  empty, // no data
  error, // load failed
  unAuthorized, // pre-login
}

enum ErrorType {
  defaultError,
  networkError,
}

class ViewStateError {
  ErrorType errorType;
  String? message;
  String? errorMessage;

  ViewStateError(this.errorType, {this.message, this.errorMessage}) {
    errorType == null ? ErrorType.defaultError : errorType;
    message ??= errorMessage;
  }

  /// improper way to write getter but for convenience
  get isNetworkError => errorType == ErrorType.networkError;

  @override
  String toString() {
    return 'ViewStateError{errorType: $errorType, message: $message, errorMessage: $errorMessage}';
  }
}