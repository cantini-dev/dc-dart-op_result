## 0.2.0 - 2025-02-27
### Breaking Changes
- **Refactored `OpResult.success()` to use a positional argument instead of `data:`**
  - Now, call `OpResult.success(value)` instead of `OpResult.success(data: dvalue)`.
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
