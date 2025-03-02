import 'package:op_result/op_result.dart';
import 'package:test/test.dart';

enum SampleError { invalidInput, timeout, networkFailure }

void main() {
  group('OpResult', () {
    test('should return success result', () {
      final result = OpResult.success(42);

      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
      expect(result.data, equals(42));
    });

    test('should return failure result with a single error', () {
      final error = OpResultError<SampleError>(
        type: SampleError.timeout,
        message: "Operation timed out.",
      );
      final result = OpResult.failure(error);

      expect(result.isSuccess, isFalse);
      expect(result.isFailure, isTrue);
      expect(result.error.type, equals(SampleError.timeout));
      expect(result.error.getErrorMessage(), equals("Operation timed out."));
    });

    test('should return failure result with multiple errors', () {
      final errors = [
        OpResultError<SampleError>(
          type: SampleError.invalidInput,
          message: "Invalid input.",
        ),
        OpResultError<SampleError>(
          type: SampleError.networkFailure,
          message: "Network issue.",
        ),
      ];
      final result = OpResult.multipleFailures(errors);

      expect(result.isSuccess, isFalse);
      expect(result.isFailure, isTrue);
      expect(result.errors.length, equals(2));
      expect(result.errors[0].type, equals(SampleError.invalidInput));
      expect(result.errors[1].type, equals(SampleError.networkFailure));
    });

    test('should throw when accessing data on failure', () {
      final error = OpResultError<SampleError>(
        type: SampleError.invalidInput,
        message: "Invalid input provided.",
      );
      final result = OpResult.failure(error);

      expect(() => result.data, throwsStateError);
    });

    test('should throw when accessing error on success', () {
      final result = OpResult.success(100);

      expect(() => result.error, throwsStateError);
    });

    test('should return default error message if none is provided', () {
      final error = OpResultError<SampleError>(type: SampleError.timeout);
      final result = OpResult.failure(error);

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
      final result = OpResult.failure(error);

      expect(
        result.error.getErrorMessage(),
        equals("The provided input is incorrect."),
      );
    });

    test(
      'should allow creating a failure with a single error via the factory constructor',
      () {
        final error = OpResultError<SampleError>(
          type: SampleError.networkFailure,
          message: "Network down.",
        );
        final result = OpResult.failure(error);

        expect(result.isFailure, isTrue);
        expect(result.error.type, equals(SampleError.networkFailure));
        expect(result.error.getErrorMessage(), equals("Network down."));
      },
    );

    test(
      'should allow creating a failure with multiple errors via the factory constructor',
      () {
        final errorList = [
          OpResultError<SampleError>(
            type: SampleError.timeout,
            message: "Request timeout.",
          ),
          OpResultError<SampleError>(
            type: SampleError.networkFailure,
            message: "No internet connection.",
          ),
        ];
        final result = OpResult.multipleFailures(errorList);

        expect(result.isFailure, isTrue);
        expect(result.errors.length, equals(2));
        expect(result.errors[0].type, equals(SampleError.timeout));
        expect(result.errors[1].type, equals(SampleError.networkFailure));
      },
    );
  });
}
