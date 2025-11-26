# cookflow

CookFlow is a Flutter mobile app for discovering and browsing cooking recipes with a clean, modern Tasty-inspired UI.
This repository contains the full Flutter + Firebase source code.

## Getting Started

Follow this guide to install all required tools and run CookFlow locally.

### 🧰 1. System Requirements

- Windows 10/11
- Git installed → https://git-scm.com/downloads
- VS Code (recommended) → https://code.visualstudio.com/
- Stable internet connection

### 🛠 2. Install Flutter

1. [Download Flutter](https://docs.flutter.dev/get-started/install/windows)
2. Extract it to: _C:\src\flutter_
3. Add Flutter to your system PATH:

- Open Environment Variables
- Edit Path
- Add: _C:\src\flutter\bin_

4. Verify installation:

```
flutter doctor
```

### 🤖 3. Install Android Studio (Android SDK Only)

> Note: You do not need to code with Android Studio.
> Flutter simply needs the Android SDK.

1. [Download Android Studio](https://developer.android.com/studio)
2. Open More Actions → SDK Manager
3. Install:

- ✔ Android 14 (API 34+)
- ✔ Android SDK Platform-Tools
- ✔ Android SDK Build-Tools
- ✔ Android Command-Line Tools

4. Accept Android licenses:

```
flutter doctor --android-licenses
```

### 🗂 4. Clone the Repository

```
git clone https://github.com/YOUR_USERNAME/cookflow.git
cd cookflow
```

### 🔥 5. Enable Developer Mode (Required)

```
start ms-settings:developers
```

On Windows Settings Enable Developer Mode.

### 🔌 6. Install Firebase CLI

Firebase CLI is required for FlutterFire.

- [Install Node.js (LTS)](https://nodejs.org/en/)
- Install Firebase Tools

```
npm install -g firebase-tools
firebase login
```

### 🔧 7. Install Dependencies

- Inside the project directory:

```
flutter pub get
```

- If you want to update outdated packages:

```
flutter pub outdated
```

### 🔥 8. Configure Firebase (First-Time Setup)

- If you are setting up Firebase for the first time:

```
dart pub global activate flutterfire_cli
flutterfire configure
```

- This generates:
  _lib/firebase_options.dart_

### ▶️ 9. Run the App

```
flutter run
```
## Project Structure

### Database schema

<img width="744" height="663" alt="cookflow_schema" src="https://github.com/user-attachments/assets/db10bd70-9e9a-46a3-a034-5b8e092014c1" />
