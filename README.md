# Laundrix Frontend

Welcome to the frontend repository of the Laundrix application, built using Flutter. Laundrix is a smart laundry service app designed to simplify your laundry routine.

## Features

- User registration and authentication
- Find nearby laundry vendor
- Order history

## Getting Started

### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Android Studio or Xcode for mobile development
- A device or emulator for testing

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/FahryIbrahim/laundrixfe
    ```
2. Navigate to the project directory:
    ```sh
    cd laundrixfe
    ```
    
3. Configure the REST API in lib/config/app_constants.dart:

    Find Your Local IP Address:
        Ensure the laundrixbe run in your static Wi-Fi IP address (e.g., 192.168.1.88).

    Edit app_constants.dart:
        Locate the lib/config/app_constants.dart file in your Flutter project.
        Update the baseURL constant to match your local IP address.

    For example, if your laundrixbe is running on 192.168.1.88 and on port 8080, the configuration would look like this: 
```
class AppConstants {
    static const appName = 'Laundrix';

    static const _host = 'http://192.168.1.88:8000';

    //other const
}
```
4. Install dependecies:
    ```sh
    flutter pub get
    ```

### Running the App

1. Connect your device or start an emulator.
2. Run the app:
    ```sh
    flutter run
    ```

## Folder Structure

```plaintext
lib/
├── config/          # Configuration of the application
├── datasources/     # Data sources, including APIs and services
├── models/          # Data models
├── pages/           # Application pages or screens
├── providers/       # State management providers
├── widgets/         # Reusable UI components
└── main.dart        # Entry point of the application
```


