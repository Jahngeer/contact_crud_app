# 📇 Contact CRUD App - Flutter & SQFLite

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-2.x-blue?logo=dart)
![SQLite](https://img.shields.io/badge/SQLite-LocalDB-green?logo=sqlite)

A professional, high-performance **Contact Management Application** built using Flutter and SQLite. This app provides a seamless offline experience for managing contacts with a modern Material 3 interface.

---

## 📸 App Screenshots

| Add/Edit Contact | Contact List | Search Filter |
| :---: | :---: | :---: |
| <img src="https://raw.githubusercontent.com/Jahngeer/contact_crud_app/main/assets/images/main_view.png" width="300" /> | <img src="https://raw.githubusercontent.com/Jahngeer/contact_crud_app/main/assets/images/screenshot1.png" width="300" /> | <img src="https://raw.githubusercontent.com/Jahngeer/contact_crud_app/main/assets/images/screenshot2.png" width="300" /> |
---

## ✨ Key Features

*   **🔄 Full CRUD Support:** Create, Read, Update, and Delete contacts with ease.
*   **💾 SQLite Persistence:** All data is stored locally using `sqflite`, ensuring your contacts remain accessible offline.
*   **🔍 Real-time Search Filter:** Instantly find any contact by searching for their Name or Phone Number.
*   **🖼️ Profile Image Integration:** Pick and display profile pictures from the Device Gallery using `image_picker`.
*   **🎨 Material 3 Design:** A professional Deep Indigo (Navy) theme providing a branded and modern look.

---

## 📦 Dependencies Used

*   `sqflite`: Local SQLite database for mobile.
*   `path`: For managing database file paths.
*   `image_picker`: To select profile photos from the gallery.

---


## 📂 Project Structure

```text
lib/
├── data/           # Database helpers (SQLite) & Data Models
├── screens/        # UI Screens (Home, Add/Edit, etc.)
├── widgets/        # Reusable UI components (Buttons, Cards)
└── main.dart       # App entry point & Configuration
```




## ⚙️ Setup & Permissions

Before running the app, ensure you have the following permissions added:


### Android (`AndroidManifest.xml`)
```
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

**Developed by [Jahngeer](https://github.com/Jahngeer)** 👨‍💻
