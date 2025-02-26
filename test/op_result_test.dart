import 'package:op_result/op_result.dart';
import 'package:test/test.dart';

enum SampleError { invalidInput, timeout }

void main() {
  group('OpResult', () {
    test('should return success result', () {
      final result = OpResult.success(data: 42);

      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
      expect(result.data, equals(42));
    });

    test('should return failure result', () {
      final error = OpResultError(
        type: SampleError.timeout,
        message: "Operation timed out.",
      );
      final result = OpResult.failure(error: error);

      expect(result.isSuccess, isFalse);
      expect(result.isFailure, isTrue);
      expect(result.error.type, equals(SampleError.timeout));
      expect(result.error.getErrorMessage(), equals("Operation timed out."));
    });

    test('should throw when accessing data on failure', () {
      final error = OpResultError(
        type: SampleError.invalidInput,
        message: "Invalid input provided.",
      );
      final result = OpResult.failure(error: error);

      expect(() => result.data, throwsStateError);
    });

    test('should throw when accessing error on success', () {
      final result = OpResult.success(data: 100);

      expect(() => result.error, throwsStateError);
    });

    test('should return default error message if none is provided', () {
      final error = OpResultError(type: SampleError.timeout);
      final result = OpResult.failure(error: error);

      expect(
        result.error.getErrorMessage(),
        equals("An unknown error occurred."),
      );
    });

    test('should use a custom error map', () {
      final customErrorMap = {
        SampleError.invalidInput: "The provided input is incorrect.",
        SampleError.timeout: "The operation took too long.",
      };

      final error = OpResultError(
        type: SampleError.invalidInput,
        errorMap: customErrorMap,
      );
      final result = OpResult.failure(error: error);

      expect(
        result.error.getErrorMessage(),
        equals("The provided input is incorrect."),
      );
    });
  });
}
