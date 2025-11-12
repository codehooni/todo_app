# Todo App

A modern Flutter todo application with category-based task management and progress tracking.

## Features

- ✅ Create, update, and delete tasks
- 📁 Category-based task organization
- 📊 Progress tracking for each category
- 🌙 Dark/Light theme support
- 📱 Clean and intuitive UI

## Screenshots

### Home Screen
![Home Screen](screenshots/home_screen.png)

### Add Todo Screen
![Add Todo Screen](screenshots/add_todo_screen.png)

## Tech Stack

- **Framework**: Flutter 3.9.2+
- **State Management**: Riverpod 3.0.3
- **Routing**: go_router 17.0.0
- **Date Formatting**: intl 0.20.2
- **Unique IDs**: uuid 4.5.2

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── todo.dart            # Todo model and categories
├── provider/
│   └── todo_provider.dart   # Riverpod state management
├── router/
│   └── go_router.dart       # App routing configuration
├── screens/
│   ├── home_screen.dart     # Main screen with categories
│   └── add_todo_screen.dart # Add/Edit todo screen
├── theme/
│   ├── dark_mode.dart       # Dark theme configuration
│   ├── light_mode.dart      # Light theme configuration
│   └── theme_provider.dart  # Theme state management
├── utils/
│   └── date_utils.dart      # Date formatting utilities
└── widgets/
    ├── category_container.dart # Category card widget
    └── todo_item.dart          # Todo list item widget
```

## Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. Clone the repository
```bash
git clone https://github.com/your-username/todo_app.git
cd todo_app
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## Usage

1. **View Tasks**: Browse your tasks organized by categories on the home screen
2. **Add Task**: Tap the add button to create a new task with a category and due date
3. **Complete Task**: Check off tasks as you complete them
4. **Track Progress**: View completion progress for each category
5. **Toggle Theme**: Switch between light and dark mode

## Categories

- 🎓 Learning
- 🏋️ Health
- 💼 Work
- 🎯 Others

## Design Credits

Design inspired by [ToDo App Dark Theme](https://dribbble.com/shots/14153121-ToDo-App-Dark-Theme) by Alex Arutyunov on Dribbble.

## License

This project is open source and available under the [MIT License](LICENSE).