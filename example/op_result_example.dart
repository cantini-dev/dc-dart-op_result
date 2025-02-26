import 'package:op_result/op_result.dart';

enum ApiError { networkFailure, unauthorized, notFound }

void main() {
  final successResult = OpResult.success("User fetched successfully");
  final failureResult = OpResult.failure(ApiError.notFound);

  if (successResult.isSuccess) {
    print("Success: ${successResult.data}");
  }

  if (failureResult.isFailure) {
    print("Error: ${failureResult.error}");
  }
}
