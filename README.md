# OpResult  
*A lightweight, type-safe result wrapper for handling success and failure cases in Dart.*

## Features
OpResult is a generic class designed to handle operations that return either a success or a failure in a structured and type-safe manner.

- Generic over Success and Error Types (`OpResult<T, E>`)
- Prevents null checks—ensures only one of `data` or `error` exists
- Encapsulates errors in a structured way using enums
- Easily maps error types to custom/multi-language messages
- Works seamlessly in any context, with APIs, validation, domain logic, etc.
- No dependencies—lightweight and efficient

## Getting started

Add `op_result` to your project’s `pubspec.yaml`:
```sh
dart pub add op_result
or
flutter pub add op_result
```

## Usage

**Basic Success & Failure Handling**

```dart
import 'package:op_result/op_result.dart';

enum ApiError {
  networkFailure,
  unauthorized,
  notFound,
}

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
```

**API Call Example**

```dart
Future<OpResult<User, ApiError>> fetchUser() async {
  final response = await apiClient.get("/user");

  if (response.statusCode == 200) {
    return OpResult.success(User.fromJson(response.body));
  }

  return OpResult.failure(ApiError.notFound);
}

void main() async {
  final result = await fetchUser();

  result.isSuccess
      ? print("User: ${result.data}")
      : print("Failed: ${result.error}");
}
```

**Form Validation Example**
```dart
OpResult<void, ValidationError> validatePassword(String password) {
  if (password.isEmpty) {
    return OpResult.failure(ValidationError.empty);
  }

  if (password.length < 6) {
    return OpResult.failure(ValidationError.tooShort);
  }

  return OpResult.success(null);
}

void main() {
  final result = validatePassword("123");

  result.isFailure
      ? print("Validation Error: ${result.error}")
      : print("Password is valid!");
}
```

**Custom Error Messages**

```dart
import 'package:op_result/op_result.dart';

enum AuthError {
  invalidCredentials,
  accountLocked,
  serverError,
}

// Example message mapping (could be loaded from a localization system)
const Map<AuthError, String> errorMessages = {
  AuthError.invalidCredentials: "Invalid username or password.",
  AuthError.accountLocked: "Your account has been locked. Please contact support.",
  AuthError.serverError: "An error occurred on the server. Try again later.",
};

OpResult<void, AuthError> authenticate(String username, String password) {
  if (username != "admin" || password != "password123") {
    return OpResult.failure(AuthError.invalidCredentials);
  }
  return OpResult.success(null);
}

void main() {
  final result = authenticate("user", "wrongpass");

  if (result.isFailure) {
    print("Error: ${errorMessages[result.error]!}"); 
  }
}
```

## License ##

This package is licensed under the BSD 3-Clause License. See the LICENSE file for details.