# 🎮 Game Warrior - Khelo Exchange Full Stack Project

**Game Warrior (Khelo Exchange)** It is a complete full-stack gaming exchange platform. It features a Spring Boot-based backend and a HTML, CSS, JavaScript-based frontend. It manages features like users, wallets, games, deposits-withdrawals, and admin control.

---

## 🚀 Tech Stack

| Layer         | Technology                          |
|---------------|--------------------------------------|
| **Frontend**  | HTML, CSS, JavaScript                |
| **Backend**   | Java 17+, Spring Boot                |
| **Security**  | Spring Security                      |
| **Websocket** | STOMP/WebSocket (ChatConfig)         |
| **Database**  | MySQL (Spring Data JPA)              |
| **Build Tool**| Maven                                |
| **IDE**       | Springtool / IntelliJ                   |

---

## 📁 Folder Structure
├── src/
│ ├── main/
│ │ ├── java/ # Backend code
│ │ │ └── com/kheloexchange/
│ │ │ ├── controller/
│ │ │ ├── entity/
│ │ │ ├── repository/
│ │ │ ├── service/
│ │ │ └── config/
│ │ ├── resources/
│ │ │ ├── static/ # Frontend files (HTML, CSS, JS)
│ │ │ ├── templates/ # Thymeleaf (if used)
│ │ │ └── application.properties # Configuration
├── pom.xml # Maven config
└── README.md # This file
