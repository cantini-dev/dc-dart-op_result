/// A generic error class that represents an operation failure.
///
/// - `E` must be an enum representing error types.
/// - Provides a default message system but allows customization.
class OpResultError<E extends Enum> {
  /// The type of error, defined by the enum `E`.
  final E type;

  /// A human-readable error message (optional, can be overridden).
  final String message;

  /// Default error messages mapped to enum values.
  final Map<E, String> errorMessages;

  /// Constructor for `OpResultError`
  OpResultError({required this.type, String? message, Map<E, String>? errorMap})
    : errorMessages = errorMap ?? {},
      message = message ?? (errorMap?[type] ?? "An unknown error occurred.");

  /// Retrieves the error message associated with the error type.
  String getErrorMessage() => message;

  @override
  String toString() => "OpResultError(type: $type, message: $message)";
}
