import 'package:test/test.dart';
import 'package:op_result/op_result.dart';

enum SampleError { invalidInput, timeout }

void main() {
  group('OpResult', () {
    test('should return success result', () {
      final result = OpResult.success(42);

      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
      expect(result.data, equals(42));
    });

    test('should return failure result', () {
      final result = OpResult.failure(SampleError.timeout);

      expect(result.isSuccess, isFalse);
      expect(result.isFailure, isTrue);
      expect(result.error, equals(SampleError.timeout));
    });

    test('should throw when accessing data on failure', () {
      final result = OpResult.failure(SampleError.invalidInput);

      expect(() => result.data, throwsStateError);
    });

    test('should throw when accessing error on success', () {
      final result = OpResult.success(100);

      expect(() => result.error, throwsStateError);
    });
  });
}
