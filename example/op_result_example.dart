import 'package:op_result/op_result.dart';

// ================================
// Basic Success & Failure Handling
// ================================

enum ApiError { networkFailure, unauthorized, notFound, unknown }

void basicSuccessFailureHandling() {
  final OpResult<String> successResult = OpResult.success(
    "User fetched successfully",
  );
  final OpResult<String> failureResult = OpResult.failure(
    OpError(type: ApiError.notFound),
  );

  if (successResult.isSuccess) {
    print("Success: ${successResult.data}");
  }

  if (failureResult.isFailure) {
    print("Error: ${failureResult.error.message}");
  }
}

// =================
// API Call Example
// =================

class User {
  final String name;
  User(this.name);
  factory User.fromJson(Map<String, dynamic> json) =>
      User(json['name'] as String);
}

Future<OpResult<User>> fetchUser() async {
  // Simulated API client
  final response = {
    "statusCode": 200,
    "body": {"name": "Alice"},
  };

  if (response['statusCode'] == 200) {
    return OpResult.success(
      User.fromJson(response['body'] as Map<String, dynamic>),
    );
  }
  switch (response['statusCode']) {
    case 200:
      return OpResult.success(
        User.fromJson(response['body'] as Map<String, dynamic>),
      );
    case 404:
      return OpResult.failure(OpError(type: ApiError.notFound));
    // ... handle other cases, if needed
    default:
      return OpResult.failure(OpError(type: ApiError.unknown));
  }
}

Future<void> apiCallExample() async {
  final result = await fetchUser();

  result.isSuccess
      ? print("User: ${result.data.name}")
      : print("Failed: ${result.error}");
}

// =================
// Form Validation Example
// =================

enum ValidationError { empty, tooShort }

OpResult<void> validatePassword(String password) {
  if (password.isEmpty) {
    return OpResult.failure(OpError(type: ValidationError.empty));
  }

  if (password.length < 8) {
    return OpResult.failure(OpError(type: ValidationError.tooShort));
  }

  return OpResult.success(null);
}

void formValidationExample() {
  final result = validatePassword("123");

  result.isFailure
      ? print("Validation Error: ${result.error.message}")
      : print("Password is valid!");
}

// =================
// Custom Error Messages Example
// =================

enum AuthError { invalidCredentials, accountLocked, serverError }

const Map<AuthError, String> errorMessages = {
  AuthError.invalidCredentials: "Invalid username or password.",
  AuthError.accountLocked:
      "Your account has been locked. Please contact support.",
  AuthError.serverError: "An error occurred on the server. Try again later.",
};

OpResult<void> authenticate(String username, String password) {
  if (username != "admin" || password != "password123") {
    return OpResult.failure(OpError(type: AuthError.invalidCredentials));
  }
  return OpResult.success(null);
}

void customErrorMessagesExample() {
  final result = authenticate("user", "wrongpass");

  if (result.isFailure) {
    print("Error: ${errorMessages[result.error.type]}");
  }
}

// =================
// Main
// =================

Future<void> main() async {
  basicSuccessFailureHandling();
  await apiCallExample();
  formValidationExample();
  customErrorMessagesExample();
}
