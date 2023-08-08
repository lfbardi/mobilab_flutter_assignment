# Smart Shopping List

Smart Shopping List is a simple and user-friendly shopping list application designed to make your everyday shopping a breeze. The app allows you to effortlessly create and manage your shopping lists, ensuring you never forget any essential items while shopping.

## How to run the Application

- Clone the Flutter Project

- Open the Project in Your Preferred Code Editor

- Get Dependencies:
	> flutter pub get
	
- Connect a Device or Emulator:
	> Tested on:
	>  Iphone 14 Pro Máx simulator (IOS 16.4)
	>  Nexus 5 simulator (Android 12)

- Run the Application:
	> flutter run

## How to run the Tests

- Go to the root project directory
- Run the tests command:
	> flutter test
 
## Architecture

Overall the project use a architecture inspired by the Clean Architecture by Uncle Bob but with some few changes, since its a small project, I shrinked some Layers like the domain and usecase layers, to improve the coding speed but still having the code organized.

![](https://blog.cleancoder.com/uncle-bob/images/2012-08-13-the-clean-architecture/CleanArchitecture.jpg)

## Data Layer
> Models > Datasources > Repositories

## Presentation Layer
> Store > StateNotifier > UI

## Packages

- flutter_riverpod
	> Dependency Injection and State Management
- dio
	> HTTP Requests
- dartz
	> Error handling easier with Either
- uuid
	> ID generation
- mocktail, state_notifier_test and dartz_test
	> Mocks and testing