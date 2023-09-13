enum FirebaseServiceResponseStatus { success, error }

class FirebaseServiceResponse<T> {
  FirebaseServiceResponse({
    required this.data,
    required this.status,
    this.errorMessage,
    this.errorCode,
  });

  FirebaseServiceResponse.success(T data)
      : this(
          data: data,
          status: FirebaseServiceResponseStatus.success,
        );

  FirebaseServiceResponse.error(String errorCode, String? errorMessage)
      : this(
          data: null,
          status: FirebaseServiceResponseStatus.error,
          errorMessage: errorMessage,
          errorCode: errorCode,
        );

  final T? data;
  final FirebaseServiceResponseStatus status;
  final String? errorMessage;
  final String? errorCode;
}
