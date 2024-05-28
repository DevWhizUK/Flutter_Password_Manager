# SecuroScanner

SecuroScanner is a mobile password manager application built with Flutter. This app allows users to securely manage their passwords and organize them into folders. The app includes features such as adding, editing, and deleting passwords, as well as generating secure passwords.

## Features

- **User Authentication**: Login and sign-up functionality.
- **Password Management**: Add, edit, delete, and view password details.
- **Folder Organization**: Organize passwords into folders.
- **Password Generator**: Generate strong passwords with customizable criteria.
- **Theming**: Support for light and dark modes, with customizable fonts and font sizes.
- **Accessibility**: Settings for adjusting font size and switching between themes.

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- [PHP](https://www.php.net/manual/en/install.php)
- [MySQL](https://dev.mysql.com/downloads/installer/)

### Installation

1. **Clone the repository**:
    ```sh
    git clone https://github.com/DevWhizUK/flutter_password_manager.git
    cd flutter_password_manager
    ```

2. **Install Flutter dependencies**:
    ```sh
    flutter pub get
    ```

3. **Set up the backend**:
    - Upload the PHP files to your server.
    - Ensure the database connection in `connection.php` is correct.
    - Create the necessary tables in your MySQL database:
        ```sql
        CREATE TABLE users (
            UserID INT AUTO_INCREMENT PRIMARY KEY,
            UserName VARCHAR(255) NOT NULL,
            Email VARCHAR(255) NOT NULL,
            PasswordHash VARCHAR(255) NOT NULL,
            RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );

        CREATE TABLE folders (
            FolderID INT AUTO_INCREMENT PRIMARY KEY,
            UserID INT,
            FolderName VARCHAR(255) NOT NULL,
            FOREIGN KEY (UserID) REFERENCES users(UserID)
        );

        CREATE TABLE passwords (
            PasswordID INT AUTO_INCREMENT PRIMARY KEY,
            UserID INT,
            Name VARCHAR(255) NOT NULL,
            Username VARCHAR(255) NOT NULL,
            Password VARCHAR(255) NOT NULL,
            URL VARCHAR(255),
            DateCreated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (UserID) REFERENCES users(UserID)
        );

        CREATE TABLE passwordfolders (
            PasswordID INT,
            FolderID INT,
            FOREIGN KEY (PasswordID) REFERENCES passwords(PasswordID),
            FOREIGN KEY (FolderID) REFERENCES folders(FolderID)
        );
        ```

### Running the App

1. **Connect a device or start an emulator**.

2. **Run the app**:
    ```sh
    flutter run
    ```


