/// A generic result type that encapsulates success or failure.
class OpResult<T, E extends Enum> {
  final T? _data;
  final E? _error;
  final bool _isSuccess;

  /// Success constructor
  OpResult.success(this._data) : _error = null, _isSuccess = true;

  /// Failure constructor
  OpResult.failure(this._error) : _data = null, _isSuccess = false;

  /// Checks if the result is a success.
  bool get isSuccess => _isSuccess;

  /// Checks if the result is a failure.
  bool get isFailure => !_isSuccess;

  /// Retrieves the success data, if any.
  T get data {
    if (!isSuccess) {
      throw StateError("Attempted to access data on a failed OpResult.");
    }
    return _data!;
  }

  /// Retrieves the error, if any.
  E get error {
    if (!isFailure) {
      throw StateError("Attempted to access error on a successful OpResult.");
    }
    return _error!;
  }

  @override
  String toString() => isSuccess ? "Success($_data)" : "Failure($_error)";
}
