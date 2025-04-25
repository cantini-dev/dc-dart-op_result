# OpResult  
*A lightweight, type-safe result wrapper for handling success and failure cases in Dart.*

## Features
OpResult is a generic class designed to handle operations that return either a success or a failure in a structured and type-safe manner.

- Generic over Success Type (`OpResult<T>`) — errors are wrapped using `OpError` with enum types
- Prevents null checks—ensures only one of `data` or `error` exists
- Encapsulates errors in a structured way using enums
- Easily maps error types to custom/multi-language messages
- Works seamlessly in any context, with APIs, validation, domain logic, etc.
- No dependencies—lightweight and efficient

## Getting started

Add `op_result` to your project’s `pubspec.yaml`:
```sh
> dart pub add op_result
```
or
```
> flutter pub add op_result
```

## Usage

See [example/op_result_example.dart](example/op_result_example.dart) for runnable usage examples.

## License ##

This package is licensed under the BSD 3-Clause License. See the LICENSE file for details.


