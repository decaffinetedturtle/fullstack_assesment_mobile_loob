lib/
├── main.dart # App entry point
├── app_router.dart # Optional: Centralized routing (e.g., GoRouter)
|
├── features/ # Main application features (e.g., login, products)
│ └── example_feature/
│ ├── data/
│ │ ├── models/
│ │ │ └── example_model.dart
│ │ └── repositories/
│ │ └── example_repository.dart
│ ├── providers/
│ │ └── example_provider.dart
│ └── presentation/
│ ├── pages/
│ │ └── example_page.dart
│ └── widgets/
│ └── example_specific_widget.dart
│
├── core/ # Shared code used by all features
│ ├── api/
│ │ └── api_service.dart
│ ├── models/
│ │ └── user_model.dart
│ ├── providers/
│ │ └── global_providers.dart
│ └── utils/
│ └── date_formatter.dart
│
├── shared_widgets/ # Reusable UI widgets used across features
│ ├── custom_button.dart
│ └── loading_spinner.dart
│
└── config/ # App-level configuration
├── app_config.dart
└── theme.dart

---

### Detailed Breakdown

#### 1. `features/`

- **Purpose:** This is the heart of your application. Each sub-directory represents a distinct business feature (e.g., `auth`, `product_catalog`, `user_profile`, `map`). This approach keeps all code related to one feature isolated and easy to manage.

- **Sub-directories:**

  - `data/`: Contains the logic for data handling.
    - `models/`: Plain Dart objects representing the data structures for this feature (e.g., `ProductModel`).
    - `repositories/`: Classes that abstract the data source. They decide whether to fetch data from the network (API service) or a local cache.
  - `providers/`: Contains all Riverpod providers that are **specific to this feature**. This is where you manage the feature's state.
  - `presentation/`: Contains the UI code for the feature.
    - `pages/` (or `screens/`): The main screen widgets for the feature.
    - `widgets/`: Reusable widgets that are **only used within this feature**.

- **How Riverpod Fits In:**
  - A `FutureProvider` in `features/products/providers/` might fetch a list of products from the `ProductRepository`.
  - A `StateNotifierProvider` in `features/auth/providers/` would manage the login form state (email, password, loading status).

#### 2. `core/`

- **Purpose:** Contains foundational code that is shared and used by **multiple features**. If you find yourself needing the same service or model in different features, it belongs in `core`.

- **Sub-directories:**
  - `api/` or `services/`: Classes that handle raw external interactions, like making HTTP requests (e.g., a class using the `Dio` or `http` package).
  - `models/`: Data models that are used globally across the app (e.g., `UserModel`, `ApiResponse`).
  - `utils/`: Shared utility functions and helper classes (e.g., validators, formatters, constants).
  - `providers/`: **Globally accessible Riverpod providers**. These are the foundational providers that other providers across the app will depend on.
- **How Riverpod Fits In:**
  - This is the perfect place for providers that instantiate singletons or core services.
  - `dioProvider`: A provider that sets up and returns a configured `Dio` instance.
  - `sharedPreferencesProvider`: A provider that gives access to the `SharedPreferences` instance.
  - Feature repositories can then `ref.watch(dioProvider)` to make API calls without worrying about instantiation.

#### 3. `shared_widgets/`

- **Purpose:** Contains generic, reusable UI components that are not specific to any single feature. This is essentially your app's design system.
- **Examples:** `PrimaryButton`, `CustomAppBar`, `FormField`, `LoadingIndicator`.
- **Key Distinction:** A widget in `features/products/widgets/` might be a `ProductCard`, which is specific to displaying products. A widget in `shared_widgets/` is something like `StyledButton`, which can be used on the login page, the product page, and the profile page.

#### 4. `config/`

- **Purpose:** For setup and configuration files that are generally loaded once when the app starts. This keeps your `main.dart` clean.
- **Examples:**
  - `theme.dart`: Defines `ThemeData` for your app's light and dark modes (colors, fonts, etc.).
  - `app_config.dart`: Holds environment-specific variables, API base URLs, or other configuration constants.
