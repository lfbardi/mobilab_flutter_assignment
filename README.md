# Smart Shopping List

`Smart Shopping List` is a user-friendly application designed to simplify your shopping experience. With this app, you can easily create and manage your shopping lists, ensuring no essential items are forgotten during shopping.

## How to Run the Application

1. Clone the Flutter project.
2. Open the project in your preferred code editor.
3. Obtain dependencies:
   ```bash
   flutter pub get
   ```
4. Connect to a device or emulator. Tested on:
   > iPhone 14 Pro Max simulator (iOS 16.4)

   > Nexus 5 simulator (Android 12)
5. Run the application:
   ```bash
   flutter run
   ```

## How to Run the Tests

1. Navigate to the root project directory.
2. Execute the test command:
   ```bash
   flutter test
   ```

## Architecture

The project's architecture is inspired by Uncle Bob's Clean Architecture with slight modifications. Given the project's size, I consolidated certain layers, such as the domain and use case layers. This decision expedited the coding process while maintaining organized code.

![Clean Architecture](https://blog.cleancoder.com/uncle-bob/images/2012-08-13-the-clean-architecture/CleanArchitecture.jpg)

### Data Layer
> Models > Datasources > Repositories

### Presentation Layer
> Store > StateNotifier > UI

## Packages

- **flutter_riverpod**
> Dependency injection and state management.
- **dio**
> Used for HTTP requests.
- **dartz**
> Simplifies error handling with Either.
- **uuid**
> For ID generation.
- `Testing:` **mocktail**, **state_notifier_test**, **dartz_test**
> For mocks and testing.
