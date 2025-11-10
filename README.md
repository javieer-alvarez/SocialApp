<div align="center">
<img src="https://github.com/javieer-alvarez/SocialApp/blob/main/Social/Assets.xcassets/AppIcon.appiconset/AppIcon.png" alt="App Icon" width="400"">
</div>

# Social

A modern SwiftUI social networking app that lets users share photos, write posts, and interact through comments — all powered by Firebase.

<div align="center">
<img src="https://github.com/javieer-alvarez/SocialApp/blob/main/Social/Assets.xcassets/posts.imageset/posts.PNG" alt="Posts View" width="400">
</div>

## 📱 Overview

**Social** is a social network built entirely with **SwiftUI** and **Firebase SDKs**.  
It allows users to:
- Create, view, and delete posts
- Upload and view images
- Comment and interact with other users’ posts
- Authenticate securely with Firebase
- Capture new images using the device camera

It’s a clean, scalable Swift app designed to explore backend integration, authentication, and UI architecture.

---

## 🛠️ Tech Stack

- **Swift / SwiftUI** — UI and app logic  
- **Firebase Authentication** — user management  
- **Firebase Firestore & Storage** — data and images  
- **Combine Framework** — reactive bindings  
- **MVVM Architecture** — separation of logic and UI  
- **UIKit bridge** — for camera and media integration

---

## 🚀 Getting Started

### Prerequisites
- **Xcode 16.0** or later  
- **iOS 18.5+** deployment target  
- Firebase project setup (to obtain your GoogleService-Info.plist)

### Setup Instructions

1. **Fork & Clone the repository**
   ```bash
   git clone https://github.com/javieer-alvarez/SocialApp.git
   cd SocialApp
   ```

2. **Create a Firebase project**
   - Go to [Firebase Console](https://console.firebase.google.com)
   - Add a new iOS app  
   - Download your `GoogleService-Info.plist` file  
   - Place it inside your Xcode project "Resources" folder (replacing the .example one)

3. **Open in Xcode**
   - Open `Social.xcodeproj`
   - Choose your device or simulator
   - Build & run (`Cmd + R`)

⚠️ **Note:** Make sure your `GoogleService-Info.plist` and API key are **not committed** to version control.  
Always use placeholders or example files in public repositories.

---

## 🧠 Architecture Overview

The app follows a **Clean MVVM** pattern:
- **Models:** User, Post, Comment  
- **ViewModels:** Business logic and data handling  
- **Views:** Declarative SwiftUI UI components  
- **Services:** Firebase authentication and storage layers  

This structure ensures **scalability**, **testability**, and **clarity** in data flow.

---

## 📸 Some Screenshots

<div align="center">
<img src="https://github.com/javieer-alvarez/SocialApp/blob/main/Social/Assets.xcassets/favorites.imageset/favorites.PNG" alt="Favorites View" width="225">
<img src="https://github.com/javieer-alvarez/SocialApp/blob/main/Social/Assets.xcassets/comments.imageset/comments.PNG" alt="Comments View" width="225">
<img src="https://github.com/javieer-alvarez/SocialApp/blob/main/Social/Assets.xcassets/profile.imageset/profile.PNG" alt="Profile View" width="225">
<img src="https://github.com/javieer-alvarez/SocialApp/blob/main/Social/Assets.xcassets/login.imageset/login.PNG" alt="LogIn View" width="230">
</div>

---

## ✨ Features

- Firebase Authentication (Email/Password)
- CRUD operations for posts
- Image picker & Camera integration
- Real-time Firestore updates
- Clean SwiftUI interface
- Light & Dark Mode support

---

## 💡 Future Improvements

- Direct messaging  
- Push notifications  
- User profiles with followers system  
- Cloud Functions for moderation  

---

<div align="center">
Made with ❤️ using SwiftUI and Firebase
</div>
