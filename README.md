<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->
# OpResult 
*A lightweight, type-safe result wrapper for handling success and failure cases in Dart.*

## Features
OpResult is a generic class designed to handle operations that return either a success or a failure in a structured and type-safe manner.

- Generic over Success and Error Types (OpResult<T, E>)
- Prevents null checks—ensures only one of data or error exists
- Encapsulates errors in a structured way using enums
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

```
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

**Form Validation Example**s
```
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


