Podracing

Podracing is a racing game inspired by the Star Wars universe, developed for iOS using Swift. The game simulates a fast-paced podracing experience where players navigate through obstacles and aim to achieve high scores.

📸 Screenshots

Gameplay Video:

[Watch Gameplay Video](https://drive.google.com/file/d/1Tfu2xLYMlGOZD7WSSr13AokSSUB4OQTO/view?usp=share_link)

Screenshots:

![Main Menu](https://drive.google.com/uc?export=view&id=15E7t7S02Kri748nTIwAlFvPV_DS1cbh9)  ![Game Screen](https://drive.google.com/uc?export=view&id=1uWmlXpsYRVqA6DDHmEG0Y8iZS9DUYigm)   

💻 Core Technologies

- Swift and UIKit: Fundamental technologies used to build the application and manage UI components, including views, buttons, and animations.

- CADisplayLink: Used to create a game loop for rendering dynamic animations at the display’s refresh rate, ensuring smooth gameplay.

- UIView.animate: Utilized for smooth transitions and motion effects, creating a dynamic visual experience.

- SnapKit: Simplifies Auto Layout with a declarative syntax, making UI code more readable and efficient.

- UserDefaults: Stores player preferences, high scores, and settings persistently between app launches.

- UITableView: Displays the list of player records on the leaderboard screen, utilizing a custom cell layout for better visualization.

- UIAction and UIButton: Used for interactive navigation and control, including the back button and clear leaderboard action.

- Navigation: Uses UINavigationController to manage screen transitions smoothly.

- Singleton Pattern: Used in LeaderboardManager to manage and persist player records efficiently.

- GCD (Grand Central Dispatch): Manages asynchronous tasks and ensures smooth UI updates during gameplay.

- Gesture Recognizers: Detects player interactions for responsive controls and input handling.

🛠 Installation

Clone the repository:

git clone https://github.com/Egor-Il/Podracing.git

Install dependencies:

pod install

Open the project in Xcode:

open Podracing.xcworkspace

📌 Roadmap

- Replace obstacle selection with track selection to provide more diverse racing experiences.

- Refactor and improve the obstacle generation logic to create more dynamic and engaging races.

- Increase the variety of racing pods, adding unique attributes and visuals.

- Introduce track-specific obstacles, where each track has its own unique challenges.

- Add effects when driving off-road to enhance realism and immersion.

- Implement tactile feedback (haptic responses) for collisions and off-road driving, with an option to enable or disable in settings.

- Integrate Game Center for online competition and leaderboard synchronization.

📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
