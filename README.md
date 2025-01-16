# Todo List Application

A simple and user-friendly Todo List application built with Flutter and the BLoC pattern for state management. This app allows users to add, edit, delete, and filter tasks (All, Completed, Pending).

---

## Features

- Add new tasks with a title and description.
- Edit existing tasks.
- Delete tasks (using swipe-to-delete or a delete button).
- Mark tasks as completed or pending.
- Filter tasks by:
  - All
  - Completed
  - Pending

---

## Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.x or higher recommended)
- [Dart](https://dart.dev/get-dart)
- An IDE such as [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/) with Flutter extensions.

---

## Getting Started

Follow these steps to set up and run the application:

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/todo-list-app.git
cd todo-list-app
```

### 2. Install Dependencies

Run the following command to install the required dependencies:

```bash
flutter pub get
```

### 3. Run the Application

To launch the application on an emulator or connected device, use:

```bash
flutter run
```

> Note: Ensure that a device (emulator or physical) is connected and properly set up.

---

## Project Structure

The project uses the BLoC pattern for state management. Here's an overview of the project structure:

```
lib/
├── main.dart           # Application entry point
├── blocs/              # BLoC logic for managing tasks
│   ├── bloc.dart
│   ├── event.dart
│   └── state.dart
├── models/             # Data models
│   └── task.dart
├── repository/
│   └── database.dart
|   └── task_repository.dart
├── screens/            # UI screens
│   └── home.dart
```

---

## How to Use

### Adding a Task

1. Tap the `+` button in the bottom right corner.
2. Enter the task title and description.
3. Press **Add** to save the task.

### Editing a Task

1. Tap on an existing task in the list.
2. Modify the title or description in the dialog.
3. Press **Save** to update the task.

### Deleting a Task

- Swipe a task to the left or tap the delete button to remove it.

### Filtering Tasks

1. Tap the menu icon in the top right corner.
2. Select one of the options: All, Completed, or Pending.

---

## Testing

To run the tests for this application, use:

```bash
flutter test
```

Ensure you have created appropriate test cases under the `test/` directory.

---

## Troubleshooting

1. **Error: Device not detected**

   - Ensure that you have a device/emulator connected.
   - Use `flutter devices` to check available devices.

2. **Packages not resolving**

   - Run `flutter pub get` to resolve dependencies.

3. **Slow build times**

   - Run `flutter clean` to clean the build directory and try again.

---

## Contributing

Contributions are welcome! Feel free to fork the repository, make changes, and submit a pull request.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
