
## Getting Started

A modern Flutter application for task management and user authentication, designed with clean architecture principles and best practices for maintainability, scalability, and testability.

---

## 1. About

**assessment_miles_edu** is a robust Flutter project that demonstrates a full-stack approach to building a production-ready mobile application. The app features a modular architecture, leveraging the BLoC pattern for state management, Firebase for authentication, and a layered structure that separates presentation, domain, and data concerns. This ensures the codebase is easy to extend, test, and maintain.

The application provides a seamless user experience for managing tasks, including creating, reading, updating, and deleting tasks, as well as secure authentication flows such as sign-up, sign-in, password reset, and session management.

---

## 2. Features

- **User Authentication**
  - Email/password sign-up and sign-in
  - Password reset via email
  - Secure session management
  - Sign-out functionality

- **Task Management**
  - Create, read, update, and delete tasks
  - Task completion tracking
  - Due date assignment and management

- **Architecture & Code Quality**
  - Clean Architecture: clear separation of presentation, domain, and data layers
  - BLoC pattern for predictable state management
  - Dependency injection for easy testing and scalability
  - Error handling and user feedback for all operations

- **UI/UX**
  - Responsive and modern UI with glassmorphic effects
  - Reusable widgets for forms, buttons, and input fields
  - Loading indicators and error/success messages

- **Extensibility**
  - Easily add new features or swap out backend services
  - Modular codebase for rapid development and onboarding

---

## 3. Setup & Running the App

Follow these steps to set up and run the application on your local machine:

### 3.1 Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable)
- [Dart SDK](https://dart.dev/get-dart) (usually included with Flutter)
- [Firebase Project](https://console.firebase.google.com/) (for authentication)
- An emulator or physical device for testing

### 3.2 Clone the Repository

```sh
git clone https://github.com/your-username/assessment_miles_edu.git
cd assessment_miles_edu
```

### 3.3 Install Dependencies
 
 ```
 flutter pub get
 ```

### 3.4 Configure Firebase

To add Firebase to your project:

- Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.
- In your Flutter project, add the required Firebase packages:

    ```sh
    flutter pub add firebase_core
    flutter pub add firebase_auth
    ```

- Follow the [FlutterFire documentation](https://firebase.flutter.dev/docs/overview) to complete creaeting flutter app on firebase.
- In your Flutter project, run:

    ```
    dart pub global activate flutterfire_cli
    flutterfire configure

    ```

---

## 4. Additional Notes

- The Firebase-generated configuration file (such as `DefaultFirebaseOptions`) is not included in this repository for security reasons. You will need to generate and add your own Firebase config file to run the app locally. This ensures your Firebase credentials remain secure, but does not affect your ability to use or test the application after setup.

Note: There is "User Data Fetch error" while after Login And SignUp. I have handled it for now by Clicking "Refresh Button" on Top right corner of Home Screen, i.e next to Log Out Button. Apart from that the code could be much more optimized, but I had to submit as per Deadline, Since I will be unavailable and could not give time for the project for next Four Days. So I thought it is best to submit the project at current phase itself. Later after this period of time, i'll try to resolve and optimize the app and push the changes.

edit as of 21/06/1999: The issue regarding "User Data fetch" has been resolved. Kindly review the project and update me regarding it.

Regards
