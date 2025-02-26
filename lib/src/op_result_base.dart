import 'op_result_error.dart';

/// A generic result type that encapsulates success or failure.
///
/// - `T` is the success data type.
/// - `E` is an enum representing possible error types.
class OpResult<T, E extends Enum> {
  final T? _data;
  final OpResultError<E>? _error;
  final bool _isSuccess;

  /// Creates a success result containing `data`.
  OpResult.success({required T data})
    : _data = data,
      _error = null,
      _isSuccess = true {
    if (data == null && !_isNullable<T>()) {
      throw ArgumentError(
        "data cannot be null when success is true and T is non-nullable. Type: ${T.toString()}",
        "data",
      );
    }
  }

  /// Creates a failure result containing an `OpResultError`.
  OpResult.failure({required OpResultError<E> error})
    : _data = null,
      _error = error,
      _isSuccess = false;

  /// Returns `true` if the result is successful.
  bool get isSuccess => _isSuccess;

  /// Returns `true` if the result is a failure.
  bool get isFailure => !_isSuccess;

  /// Retrieves the success data, if available.
  T get data {
    if (!isSuccess) {
      throw StateError("Attempted to access data on a failed OpResult.");
    }
    return _data!;
  }

  /// Retrieves the error, if available.
  OpResultError<E> get error {
    if (!isFailure) {
      throw StateError("Attempted to access error on a successful OpResult.");
    }
    return _error!;
  }

  /// Utility to check if a type is nullable.
  static bool _isNullable<T>() => null is T;

  @override
  String toString() => isSuccess ? "Success($data)" : "Failure($error)";
}
