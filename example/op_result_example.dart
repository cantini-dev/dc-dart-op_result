import 'package:op_result/op_result.dart';

enum ApiErrorType { unauthorized, notFound, serverError }

void main() {
  final OpResult<String> successResult = OpResult.success(
    "User data retrieved",
  );
  final OpResult<String> failureResult = OpResult.failure(
    OpError(
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
