## 0.3.0 - 2025-03-01
### Breaking Changes
- **Refactored `OpResult<T>` to remove `E extends Enum`**
  - `OpResult` no longer requires an error type at the class level. **Errors are now enforced as enums only at failure creation.**
  - **Before:**
   ```dart 
  OpResult<T, E extends Enum>
  ```
  - **Now:** 
  ```dart 
  OpResult<T>
  ```
  - This allows returning any error type (e.g., validation and API errors) in the result.

- **Breaking change in `failure()` constructor**
  - `failure()` only accepts a single error. 
  - `multipleFailures()` must be used to pass a list of errors.
  - **Before:**
    ```dart
    OpResult.failure([error1, error2]); 
    ```
  - **Now:**
    ```dart
    OpResult.multipleFailures([error1, error2]); 
    ```
  - This ensures strong typing while allowing flexibility in `OpResult`.

- **Breaking change:** `OpResultError` has been renamed to `OpError`. 

## 0.2.2 - 2025-02-28
### Maintenance
- Bumped version to **0.2.2** for consistency and dependency updates.
- No functional changes.
 
## 0.2.1 - 2025-02-28
### Initial Public Release
- **Added support for nullable success values (`T?`)** in `OpResult.success()`
- **Improved failure handling** by supporting both **single and multiple errors**
- **Refactored `OpResult.success()`** to use a **positional argument** instead of a named parameter

## 0.2.0 - 2025-02-27
### Breaking Changes
- **Refactored `OpResult.success()` to use a positional argument instead of `data:`**
  - Now, call `OpResult.success(value)` instead of `OpResult.success(data: value)`.
  - Example:
    - **Before**: `OpResult.success(data: user);`
    - **Now**: `OpResult.success(user);`
- **Refactored `OpResult` to support multiple errors**:
  - Replaced `_error` (single error) with `_errors` (list of errors).
  - `OpResult.failure()` now supports **both single and multiple errors** via a **factory constructor**:
    - `OpResult.failure(singleError)`
    - `OpResult.failure([multipleErrors])`

### Improvements
- **Unified failure handling**:
  - Removed `OpResult.failure({required OpResultError<E> error})` in favor of a flexible factory constructor.
  - Supports passing either **a single error** or **a list of errors** dynamically.
- **Ensured `failure()` cannot receive an empty list**, preventing invalid states.
- **Refactored error access**:
  - **`error`** → Returns the first error (default for single-error scenarios).
  - **`errors`** → Provides full access to all errors when multiple exist.

## 0.1.0 - 2025-02-26
- Initial version.