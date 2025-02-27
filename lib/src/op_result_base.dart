import 'op_result_error.dart';

/// A generic result type that encapsulates success or failure.
///
/// - `T` is the success data type.
/// - `E` is an enum representing possible error types.
class OpResult<T, E extends Enum> {
  final T? _data;
  final List<OpResultError<E>> _errors;
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

  /// Factory constructor for failure, allowing either a single error or multiple errors.
  factory OpResult.failure(dynamic errorOrErrors) {
    List<OpResultError<E>> errors;

    if (errorOrErrors is OpResultError<E>) {
      errors = [errorOrErrors];
    } else if (errorOrErrors is List<OpResultError<E>>) {
      if (errorOrErrors.isEmpty) {
        throw ArgumentError("errors cannot be empty");
      }
      errors = errorOrErrors;
    } else {
      throw ArgumentError(
        "failure() must be called with an OpResultError<E> or List<OpResultError<E>>",
      );
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
  List<OpResultError<E>> get errors => _errors;

  /// Retrieves the first error (for standard single-error scenarios).
  OpResultError<E> get error => _errors.first;

  @override
  String toString() =>
      isSuccess
          ? "Success($data)"
          : "Failure(${errors.map((e) => e.toString()).join(', ')})";

  /// Utility to check if a type is nullable.
  static bool _isNullable<T>() => null is T;
}
