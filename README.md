# GymFlow App

**GymFlow** is a Flutter mobile application that helps users find consistent workout partners at the same gym, time, and for their preferred workout type.  
The app is designed with a **clean architecture**, modular structure, and **GetX state management** to ensure scalability and maintainability.

---

## 🌟 Features

### Current / Planned Features

- **Splash Screen & Onboarding Flow**
  - Splash screen with app logo
  - Onboarding pages with PageView, skip button, and dot indicators
- **User Authentication**
  - Login / Register (Firebase integration planned)
- **Gym Partner Matching**
  - Find gym partners based on location, schedule, and workout type
- **Profile & Preferences**
  - User profile management
  - Workout schedule settings
- **Notifications**
  - Push notifications for partner availability

---

## 🛠 Tech Stack

- **Flutter** – Frontend cross-platform UI  
- **GetX** – State management, dependency injection, routing  
- **Firebase** – Authentication & optional backend (future integration)  
- **Google Fonts** – Custom typography  
- **Material 3** – Modern design system

---

## 🏗 Architecture

The project follows a **feature-based modular structure**:

lib/
├── core/ # Theme, constants, services, utilities
├── modules/ # Feature modules (Splash, Onboarding, Auth, Home, etc.)
│ ├── splash/
│ ├── onboarding/
│ ├── auth/
│ ├── home/
│ └── ...
├── routes/ # App routes and bindings
└── widgets/ # Shared UI components


**GetX Bindings** are used for automatic dependency injection and controller lifecycle management, ensuring clean separation of UI and logic.

---

## 📂 Branching Strategy

To maintain a clean and professional workflow, each feature or milestone is developed on its own branch:

| Branch | Description |
|--------|-------------|
| `01-project-setup-and-onboarding` | Project initialization and onboarding module |
| `02-authentication` | Login/Register features |
| `03-home-and-dashboard` | Main dashboard and home screen |
| `04-gym-partner-matching` | Partner search and matching |
| `05-chat-system` | In-app chat between users |
| `06-user-profile` | Profile management |
| `07-app-settings` | App preferences and settings |

---

## 🚀 Getting Started

1. **Clone the repository**
```bash
git clone https://github.com/AbdallaHossam186/gymflow-app.git
cd gymflow-app

Install dependencies
flutter pub get

Run the app
flutter run


Make sure you have Flutter SDK installed and a connected device/emulator.

📌 Contribution

This is a personal project intended for portfolio purposes.
For future contributions, please fork the repository and create a pull request with detailed notes.

📄 License

This project is open-source for portfolio use. Feel free to review the code and provide feedback.