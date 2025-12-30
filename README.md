# 🔐 Firebase Auth Service (iOS)

[![Swift](https://img.shields.io/badge/Swift-5.9+-F05138?style=flat-square&logo=swift&logoColor=white)](https://swift.org)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-Framework-61DAFB?style=flat-square&logo=swift&logoColor=black)](https://developer.apple.com/xcode/swiftui/)
[![Firebase](https://img.shields.io/badge/Firebase-Auth-FFCA28?style=flat-square&logo=firebase&logoColor=black)](https://firebase.google.com)

Простой и надежный сервис авторизации и регистрации для iOS-приложений. Написан на **Swift** с использованием **SwiftUI** и **Firebase Authentication**.

---

## 🌟 Основные возможности
* ✅ **Регистрация:** Создание нового аккаунта через Email/Password.
* ✅ **Вход:** Безопасная авторизация существующих пользователей.
* ✅ **Валидация:** Проверка корректности ввода email и сложности пароля.
* ✅ **Обработка ошибок:** Информативные алерты при неверном пароле или отсутствии сети.
* ✅ **SwiftUI интерфейс:** Чистый, декларативный код и современный UI.

---

## 📸 Скриншоты
<p align="center">
  <img src="https://via.placeholder.com/250x500?text=Login+Screen" width="200" alt="Login" />
  <img src="https://via.placeholder.com/250x500?text=Registration+Screen" width="200" alt="Register" />
</p>
<i>(Совет: замени эти ссылки на реальные скриншоты твоего приложения)</i>

---

## 🛠 Технологии
* **Language:** Swift
* **UI Framework:** SwiftUI
* **Backend:** Firebase Auth
* **Architecture:** MVVM (Model-View-ViewModel)

---

## 🚀 Как запустить проект

Чтобы проект заработал, тебе нужно подключить свой Firebase-проект:

1. **Клонируй репозиторий:**
   ```bash
   git clone [https://github.com/vsc05/reg-loginService.git](https://github.com/vsc05/reg-loginService.git)
   ```
2. **Настрой Firebase:**
  Перейди в Firebase Console.
  Создай новый проект iOS.
  Загрузи файл ```GoogleService-Info.plist.```
  Добавь этот файл в корень проекта через Xcode.

3. **Включи Auth:**
  В консоли Firebase перейди в раздел **Authentication -> Sign-in method.**
  Включи провайдер **Email/Password.**

4. **Установи зависимости:**
  Если используешь Swift Package Manager (SPM), Xcode сам подтянет Firebase.
  Если CocoaPods — пропиши ```pod install.```

👨‍💻 Автор
vsc05
Telegram: @vsc05
Email: gasa.abdullaev.99@bk.ru

