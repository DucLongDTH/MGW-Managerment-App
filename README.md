# MGW-Managerment-App

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

- Run `dart fix --apply && flutter format .` to quick fix dart syntax and format all source code.

Open terminal and run command to generate code:
\
flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs && flutter gen-l10n
\
In the seconds time just run:
flutter packages pub run build_runner build --delete-conflicting-outputs && flutter gen-l10n
\
## Step to implementation

This app follow clean architecture

<img src="https://blog.cleancoder.com/uncle-bob/images/2012-08-13-the-clean-architecture/CleanArchitecture.jpg" style="display: block; margin-left: auto; margin-right: auto; width: 75%;"/>

Call follow
<img src="https://miro.medium.com/max/1112/0*zZzajnC5VvfKiZi0.png" style="display: block; margin-left: auto; margin-right: auto; width: 75%;"/>
&nbsp;
\
&nbsp;
\
Real Implementation
===================

To materialize the architectural decisions and to make it more useful to our team, we’ve started to choose flutter packages to suit our needs, following the philosophy of using as fewer third-party packages as possible.

\- To implement _UseCases_ as the Business Logic Components of the application, we felt that the natural decision was the [**_Bloc package_**](https://pub.dev/packages/flutter_bloc), as it is a mature, robust, and well-known solution for state management in _Flutter_ context, and it is easy to test as well.

\- To represent _Bloc_ states and events, _Models_ and _Entities_, we’ve decided to use [**_Freezed package_**](https://pub.dev/packages/freezed), as it is an elegant and easy solution to implement sealed classes, union types and data classes as it is not available by default in _Dart_ (yet!). It’s based in code generation and it has ready-to-use integration with [**_Json\_serializable package_**](https://pub.dev/packages/json_serializable) that we’ve decided to use to deal with serialization.

\- To deal with dependency injection we’ve decided to use a simple service locator: [**_GetIt_**](https://pub.dev/packages/get_it) and define a simple set of rules-of-thumb to keep consistency over project’s development and maintenance life cycles. Rules-of-Thumb:

> _— If a class depends on another, it must be passed at instantiation by constructor and the instance control should be made by the service locator._
>
> _— Dependency injection setup for a module/feature should be split in each feature (each feature/module will contain its own file explicitly defining its dependency injection setup)._
>
> _— The service locator should never be referenced in a place other than a constructor call._

\- To deal with internationalization we’ve decided to use pure Object Oriented Programming, and keep all Strings of the application as static constants of an implementation of an abstract class to be defined.

\- To deal with navigation we’ve decided to use the _Flutters_ native _Navigator_, as it poses as a complete solution, and with the arrival of [**Auto Router api**](https://pub.dev/packages/auto_route), we think that it is an elegant declarative solution to deal with navigation.

\- To deal with http requests we’ve decided to use [**Dio package**](https://pub.dev/packages/dio) as it is a better option than the native _Flutter_ solution presenting good features like Interceptors, base options like headers, base url etc., and is a well known and popular solution. Then we made a wrapper over the client to model errors and responses into our system context.

\- To persist sensitive local data we’ve decided to use the package [**_flutter\_secure\_storage_**](https://pub.dev/packages/flutter_secure_storage) because it is a popular and performative solution when there isn’t the need of storing complex data.

We’ve defined helper classes/types to deal with the Result of actions, the _Result_ type (generic Freezed union type that has two types: a _Success_ and a _Failure_), the _RequestStatus_ type (generic Freezed union type that has four types: _Idle_, _Loading_, _Succeeded_, _Failed_) to help dealing with the visual response of requests, the AppError (abstract class that is implemented in each relevant particular error type), and to help with forms, the _Maybe_ type (generic Freezed union type that has two types: _Nothing_ and _Just_) used in the definition of _FormField_ type (generic Freezed data class containing the name of the field and the Maybe instance representing the actual possible inputted value to the form field).

## How to build app

### Android: Execute ./scripts/build-android-dev.sh

For automation testing or debug mode:  flutter build apk --debug --dart-define=environment=auto
\ Optimization build by target: flutter build apk --debug --dart-define=environment=auto --target-platform android-x64,android-x86
\For release mode: flutter build apk --release --dart-define=environment=production

### iOS: Execute ./scripts/distribution-ios.sh  -e "devevelopment" -v "1.4.2"

For automation testing or debug mode:  flutter build ios --debug --dart-define=environment=auto --no-codesign
\For release mode: flutter build ios --release --dart-define=environment=auto
\
After that go to the folder where the output is stored.
Android:
example/build/outputs/app/flutter-apk
iOS:
example/build/ios/iphonesimulator/Runner.app
