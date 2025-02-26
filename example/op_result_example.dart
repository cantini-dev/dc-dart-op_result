import 'package:op_result/op_result.dart';

enum ApiErrorType { unauthorized, notFound, serverError }

void main() {
  final OpResult<String, ApiErrorType> successResult = OpResult.success(
    data: "User data retrieved",
  );
  final OpResult<String, ApiErrorType> failureResult = OpResult.failure(
    error: OpResultError(
      type: ApiErrorType.notFound,
      message: "User not found in the system",
    ),
  );

  if (successResult.isSuccess) {
    print("Success: ${successResult.data}");
  }

  if (failureResult.isFailure) {
    print("Error: ${failureResult.error.getErrorMessage()}");
  }
}
