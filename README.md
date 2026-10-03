# Expense Tracker

A simple and clean Expense Tracker mobile application built with **Flutter**, **BLoC**, and **Firebase Cloud Firestore** as a practical task for the **CyphLab Flutter Developer Internship**.

The application focuses on a functional, responsive, and maintainable implementation of the requirements provided in the practical task.



## Features

### Core Requirements

- Add new expenses
- Edit existing expenses
- Delete expenses with confirmation
- Select expense category
- Store expenses using **Firebase Cloud Firestore**
- Display total expenses for the current month
- View expense history
- Filter expenses by category
- Filter expenses by date
- Form validation with inline error messages
- Loading states
- Empty states
- Error states with retry support

### Expense Details

Each expense contains:

- Title
- Amount
- Category
- Date
- Optional note/description

### Additional Features

Along with the required features, I implemented:

- Search by title or note
- Monthly spending summary
- Previous-month comparison
- Biggest spending category
- Daily average spending
- Category-wise spending chart
- Six-month spending overview
- Pull-to-refresh
- Dark mode
- Firebase Authentication
- User-specific expense data protected with Firestore security rules

---

## Categories

The application supports the following expense categories:

- Food
- Transport
- Shopping
- Bills
- Health
- Entertainment
- Other

---

## Tech Stack

- **Flutter** — Mobile application development
- **Dart** — Programming language
- **BLoC / flutter_bloc** — State management
- **Firebase Core** — Firebase integration
- **Cloud Firestore** — Expense data storage
- **Firebase Authentication** — User authentication
- **Font Awesome Flutter** — Icons
- **Intl** — Date and currency formatting
- **Google Fonts** — Typography

---

## Project Structure

The project follows a feature-oriented structure with BLoC-based state management and reusable widgets.

```text
lib/
├── core/
│   └── theme/
│       ├── app_theme.dart
│       └── bloc/
│           ├── theme_bloc.dart
│           └── theme_state.dart
│
├── features/
│   ├── bloc/
│   │   └── expensebloc/
│   │       ├── expense_bloc.dart
│   │       ├── expense_event.dart
│   │       └── expense_state.dart
│   │
│   └── presentation/
│       ├── home_screen.dart
│       ├── add_expense_page.dart
│       └── expense_history_page.dart
│
├── models/
│   └── expense_model.dart
│
├── repositories/
│   └── expense_repo.dart
│
└── widgets/
    ├── app_colors.dart
    ├── app_container.dart
    ├── app_header.dart
    ├── app_home_header.dart
    ├── app_nav_bar.dart
    ├── app_space.dart
    ├── app_tab.dart
    ├── app_text_style.dart
    ├── category_style.dart
    ├── date_picker.dart
    ├── dismiss.dart
    ├── expense_list_tile.dart
    ├── history_message_row.dart
    ├── history_summary.dart
    └── monthly_summary_card.dart
```

The general flow of the application is:

```text
UI
 ↓
BLoC
 ↓
Repository
 ↓
Firebase / Cloud Firestore
```

This keeps the UI, state management, and data operations separated.

---

## Firebase

The application uses Firebase for authentication and expense storage.

### Firebase Services

- Firebase Authentication
- Cloud Firestore

Each authenticated user accesses their own expense data, with Firestore security rules used to protect user-specific records.

---

## Setup

### Prerequisites

Make sure you have:

- Flutter SDK installed
- Dart SDK
- Android Studio or VS Code
- A Firebase project

### 1. Clone the repository

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
cd expens_tracker
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

Create Flutter application and connect it to the  Firebase projec .

Enable:

- Firebase Authentication
- Cloud Firestore

Then configure Firebase for the project using FlutterFire CLI:

```bash
flutterfire configure
```

This generates the required Firebase configuration for the application.

### 4. Run the application

```bash
flutter run
```

### 5. Build Release APK

```bash
flutter build apk --release
```

The generated APK will be available in:

```text
build/app/outputs/flutter-apk/
```

---


## Testing

The application was tested for the main user flows, including:

- Adding expenses
- Editing expenses
- Deleting expenses
- Category selection
- Date selection
- Searching expenses
- Filtering expenses
- Monthly calculations
- Validation
- Loading states
- Empty states
- Error handling
- Dark mode
- Firebase data operations

---

## Future Improvements

Possible future improvements include:

- Export expenses to CSV
- More detailed analytics
- Budget limits and notifications
- Recurring expenses
- Additional visualization options

---
THANK YOU !!!
