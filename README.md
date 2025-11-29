# 📕 Para Job Flutter Project — Developer Playbook

**Welcome to the team!** This document serves as the official guide to the project's architecture,
conventions, and operational rules. Following this playbook ensures stability, quality, and
maintainability across the entire codebase.

---

## 🧭 Table of Contents

1. [Project Structure](#-project-structure)
2. [Packages Overview](#-packages-overview)

* [themeing](#themeing)
* [api\_client](#api\_client)
* [ui\_components](#ui\_components)
* [functional\_components](#functional\_components)
* [route\_manager](#route\_manager)
* [user\_manager](#user\_manager)
* [localization\_manager](#localization\_manager)


3. [Conventions and Rules](#-conventions-and-rules)

---

## 🏗️ Project Structure

The application follows a **Package-by-Convenience** architecture, isolating specific business
features from shared, reusable infrastructure.

| Path            | Purpose                                                                                                                                                         |
|:----------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `lib/main.dart` | The **App entry point**. Initializes services and runs the app widget.                                                                                          |
| `lib/features/` | **Feature Modules**. Contains all screens, controllers, and business logic grouped by functionality (e.g., `authentication`, `home`, `profile`, `job_details`). |
| `lib/packages/` | **Shared Packages**. Contains reusable utilities, infrastructure, and cross-cutting concerns (e.g., networking, routing, theming).                              |
| `lib/res/`      | **Project Resources**. Holds generated files like Firebase options and asset paths.                                                                             |

> **📝 Notes:**
> * We strictly follow **Package-by-Convenience**.
> * Each feature is isolated; shared functionality **must** go into one of the packages.
> * **developers should not modify shared packages (e.g., `user_manager`, `route_manager`)
    without lead developer approval.**

---

## 📦 Packages Overview

### themeing

* **Purpose:** Contains all **Shared theme definitions** and **responsive utilities** used across
  the application.

* **Files:**

| File                      | Purpose                                                                                        |
|:--------------------------|:-----------------------------------------------------------------------------------------------|
| `app_colors.dart`         | Defines the **centralized color palette** (e.g., `AppColors.midnightBlue`).                    |
| `media_query_values.dart` | Provides responsive helper extensions for sizing and spacing (`hPct`, `wPct`, `hBox`, `wBox`). |

* **Rules:**
    1. **No static numbers for sizes.** You must use responsive helpers from
       `media_query_values.dart` (`hPct`, `wPct`, etc.) for all sizing, spacing, and dimensions.
    2. All shared theme changes (e.g., color palette updates, font families, shadows) must go here.
    3. Ensure styling changes maintain **consistency** across the entire app.

```dart
// Example: Using responsive sizing and centralized colors
Container
(
// Sets height to 10% of the screen height
height: context.hPct(10),
// Sets width to 50% of the screen width
width: context.wPct(50),
color: AppColors.
midnightBlue
,
)
``` 

### api\_client

* **Purpose:** Handles all **network requests** using **Dio** and **Retrofit**. Centralizes request
  setup, serialization, and error handling.

| Path                               | File/Folder                   | Responsibility                                                |
|:-----------------------------------|:------------------------------|:--------------------------------------------------------------|
| `packages/api_client/src/models/`  | `requests/`, `responses/`     | Request and Response **DTOs** (Data Transfer Objects).        |
| `packages/api_client/src/models/`  | `models.dart`                 | **Barrel file** exporting all Request/Response models.        |
| `packages/api_client/src/service/` | `api_client.dart`             | The **Retrofit client interface** defining all API endpoints. |
| `packages/api_client/src/service/` | `dio_singleton_instance.dart` | Provides a **single Dio instance** for all requests.          |
| `packages/api_client/src/service/` | `dio_error_extension.dart`    | Centralized logic for **error handling**.                     |
| `packages/api_client/`             | `api_client.dart`             | **Barrel file** exporting the package components.             |
| `packages/api_client/`             | `api_client.g.dart`           | **Generated** Retrofit client implementation.                 |

**Rules for Adding New API Endpoints (Sequential Process):**

1. **Define Models:** Add any new request/response models in `models/requests` or
   `models/responses`.
2. **Export Models:** Export all new models in `models.dart`.
3. **Define Contract:** Add the endpoint to the `ApiClient` interface using `@GET`, `@POST`, etc.
4. **Generate Implementation:** Call the **build runner** (to generate the implementation in
   `api_client.g.dart`).
5. **Configure Headers:** **Do not** add Dio configuration or headers here—all shared headers are
   set in `dio_singleton_instance.dart`.
6. **Make Call:** Use the `apiClient` singleton to make calls.
7. **Handle Errors:** Always handle errors using a centralized function like `handleDioError()`.

```dart
// Example: Adding a new endpoint
@GET("/api/user/profile")
Future<ProfileResponse> getUserProfile(@Header("Authorization") String? token);
``` 

### ui\_components

* **Purpose:** This package is the central repository for **Reusable UI components (Widgets)** that
  are shared across different features of the application.

* **Examples of Components:**
    * `AppLoader`: The standardized loading spinner used app-wide.
    * `AppNetworkImage`: An image widget that includes placeholders and error handling for network
      sources.
    * `AppStarRating`: The standardized widget for displaying ratings.
    * `showApplicationDialog()`: Custom dialogs and pop-ups used for user feedback.
    * `JobCard`, `SkillItem`, `StrikeCard`: Complex, reusable display units.

* **Rules:**
    1. Only **shared UI widgets** that are used in **more than one feature** should be placed here.
    2. Widgets in this package must be purely presentational; they should not contain
       feature-specific business logic.
    3. All styling must utilize the constants defined in the **`themeing`** package (i.e.,
       `AppColors` and `MediaQueryValues`).

### functional\_components

* **Purpose:** This package holds **shared non-UI utilities** (pure Dart logic) that are used across
  **all features** of the application.

* **Examples of Utilities:**
    * `getFormattedDate()`: Logic for formatting date strings.
    * `pickImageFile()`: Handles image selection from the camera or gallery.
    * `requestNotificationPermission()`: Manages requesting push notification permissions.
    * **Validation Helpers:** Functions like `validateEmail`, `validatePhone`, and
      `validatePassword`.

* **Rules:**
    1. Only place **logic utilities** here (pure Dart/non-widget logic).
    2. **No feature-specific UI** should ever go here.
    3. The components **must** be intended for use across **all features** of the application.

### route\_manager

* **Purpose:** Provides **Centralized navigation** and **route management** for the application
  using GetX.

* **Files:**

| Path                                 | File/Folder               | Responsibility                                               |
|:-------------------------------------|:--------------------------|:-------------------------------------------------------------|
| `packages/route_manager/controller/` | `routes.dart`             | Defines **all route constants** (e.g., `Routes.homeScreen`). |
| `packages/route_manager/controller/` | `routing_controller.dart` | Handles programmatic navigation state and helper methods.    |
| `packages/route_manager/`            | `route_manager.dart`      | Package barrel file.                                         |

* **Key Concepts:**
    * **Nested routes:** Defines complex navigation where some screens are children of parent
      screens (`AppPages`).
    * **LoaderOverlay:** An overlay used on screens making API calls to prevent multi-tap during
      loading states.
    * **RoutingController:** The main service handling programmatic navigation and persistence of
      the current screen context.

* **Rules:**
    1. Always use the constants defined in **`Routes`** for navigation.
    2. Do not navigate using raw string paths.
    3. For new screens, ensure the parent/child relationship is correctly defined in `AppPages`.

```dart
// Example: Simple navigation
Get.toNamed
(
Routes.emailLoginScreen);

// Example: Navigation using the controller (e.g., post-login)
await Get.find<RoutingController>().goHomeAsUser(user, token); 
``` 

### user\_manager

* **Purpose:** This package is responsible for managing the global **user state** (user data) and
  the current **authentication token** throughout the application's lifecycle.

* **File:** `user_controller.dart` (This file typically implements the `GetxController` or similar
  state management logic).

* **Usage:**
    * **Access the User:** `Get.find<UserController>().user`
    * **Access the Token:** `Get.find<UserController>().token`
    * **Check Auth Status:** `Get.find<UserController>().isGuest`

* **Rules:**
    1. Always use **`Get.find<UserController>()`** to retrieve the controller instance; never create
       a new instance.
    2. Any modification or update to the user's data or token must be done via the centralized
       `updateUser()` method within the controller.
    3. When a user logs out or the session expires, the **`clearUser()`** method must be called to
       reset the state.

### localization\_manager

* **Purpose:** Handles **multi-language support** and localization management using **GetX**.

* **Files:**

| Path                                        | File/Folder                    | Responsibility                             |
|:--------------------------------------------|:-------------------------------|:-------------------------------------------|
| `packages/localization_manager/controller/` | `localization_controller.dart` | Manages the current locale/language state. |
| `packages/localization_manager/lang/`       | `app_translations.dart`        | Contains all language key-value maps.      |
| `packages/localization_manager/`            | `localization_manager.dart`    | Barrel file.                               |

* **Translation Structure (Keys and Values):**
    * All translation keys and values are defined in `app_translations.dart`.

```dart
// Example: English Translations (enUS in app_translations.dart)
const Map<String, String> enUS = {
  // ============================================================
  // 🏠 Onboarding Screen
  // ============================================================
  'onboarding_title': 'Welcome to Para Job!',
  // ...
  // ============================================================
  // 🔐 Login Screen
  // ============================================================
  'login_title': 'Welcome back',
  // ...
};

// Example: Arabic Translations (arSA in app_translations.dart)
const Map<String, String> arSA = {
  // ============================================================
  // 🏠 Onboarding Screen
  // ============================================================
  'onboarding_title': 'مرحبًا بك في بارا جوب!',
  // ...
  // ============================================================
  // 🔐 Login Screen
  // ============================================================
  'login_title': 'مرحبًا بعودتك',
  // ...
};
``` 

* **Usage in Screen:**
    * Access translations anywhere using the `.tr` extension on the key:
    ```dart
    // Example usage in a Flutter Widget:
    Text('login_title'.tr),
    Text('onboarding_subtitle'.tr),
    ```

* **Notes:**
    * Changing the language updates Dio headers automatically.
    * **Only approved languages and keys should be added.**


