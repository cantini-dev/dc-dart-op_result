import 'op_result_error.dart';

/// A generic result type that encapsulates success or failure.
///
/// - `T` is the success data type.
class OpResult<T> {
  final T? _data;
  final List<OpError> _errors;
  final bool _isSuccess;

  /// Creates a success result containing `data`.
  OpResult.success(this._data) : _errors = [], _isSuccess = true {
    if (_data == null && !_isNullable<T>()) {
      throw ArgumentError(
        "data cannot be null when success is true and T is non-nullable. Type: ${T.toString()}",
        "data",
      );
    }
  }

  /// Creates a failure result with a single error.
  factory OpResult.failure(OpError error) {
    return OpResult._failure([error]);
  }

  /// Creates a failure result with multiple errors.
  factory OpResult.multipleFailures(List<OpError> errors) {
    if (errors.isEmpty) {
      throw ArgumentError("errors cannot be empty");
    }
    return OpResult._failure(errors);
  }

  /// Private named constructor for failure cases.
  OpResult._failure(this._errors) : _data = null, _isSuccess = false;

  /// Returns `true` if the result is successful.
  bool get isSuccess => _isSuccess;

  /// Returns `true` if the result is a failure.
  bool get isFailure => !_isSuccess;

  /// Retrieves the success data, if available.
  T get data {
    if (!isSuccess) {
      throw StateError("Attempted to access data on a failed OpResult.");
    }
    // as T ensures that if T is non-nullable, _data is never null.
    return _data as T;
  }

  /// Retrieves all errors.
  List<OpError> get errors => _errors;

  /// Retrieves the first error (for standard single-error scenarios).
  OpError get error => _errors.first;

  @override
  String toString() =>
      isSuccess
          ? "Success($data)"
          : "Failure(${errors.map((e) => e.toString()).join(', ')})";

  /// Utility to check if a type is nullable.
  static bool _isNullable<T>() => null is T;
}
