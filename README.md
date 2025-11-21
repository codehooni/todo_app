# Todo App

A modern Flutter todo application with category-based task management, smooth animations, and progress tracking.

## Features

- ✅ Create, update, and delete tasks with confirmation (3-second undo)
- 📁 Category-based task organization with filtering
- 📊 Visual progress tracking with animated charts
- 🌙 Dark/Light theme support with smooth transitions
- 💾 Local data persistence with Hive
- 🎨 Smooth animations and transitions throughout the app
- 👆 Modern touch feedback and reorder animations
- ↔️ Swipe gestures for task management
- 📱 Clean and intuitive UI with side menu navigation

## Demo

<div align="center">
  <table>
    <tr>
      <td align="center">
        <h3>Demo Video</h3>
        <!-- 여기에 데모 영상 URL을 넣으세요 -->
        [![Video](https://img.youtube.com/vi/gHPb-ydLdWA/0.jpg)](https://youtube.com/shorts/gHPb-ydLdWA?feature=share)
      </td>
      <td align="center">
        <h3>Home Screen</h3>
        <img width="250" alt="Home Screen" src="https://github.com/user-attachments/assets/19a1defe-caa7-4e67-a967-9391c1aa19a6" />
      </td>
      <td align="center">
        <h3>Add Todo Screen</h3>
        <img width="250" alt="Add Todo Screen" src="https://github.com/user-attachments/assets/33453ead-c2f2-4d7c-8b22-b7224679a61b" />
      </td>
    </tr>
  </table>
</div>


## Tech Stack

- **Framework**: Flutter 3.9.2+
- **State Management**: Riverpod 3.0.3
- **Local Storage**: Hive 1.1.0
- **Routing**: go_router 17.0.0
- **Charts**: fl_chart 1.1.1
- **Swipe Actions**: flutter_slidable 4.0.3
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
2. **Filter Tasks**: Tap on category cards to filter tasks by category
3. **Add Task**: Tap the FAB button to create a new task with smooth animations
4. **Complete Task**: Check off tasks as you complete them
5. **Delete Task**: Swipe left to delete (3-second undo window with undo button or right swipe)
6. **Reorder Tasks**: Long press and drag to reorder tasks
7. **View Statistics**: Open the side menu to view progress charts
8. **Toggle Theme**: Switch between light and dark mode with smooth transitions

## Categories

- 🎓 Learning
- 🏋️ Health
- 💼 Work
- 🎯 Others

## Design Credits

Design inspired by [ToDo App Dark Theme](https://dribbble.com/shots/14153121-ToDo-App-Dark-Theme) by Alex Arutyunov on Dribbble.

## License

This project is open source and available under the [MIT License](LICENSE).
