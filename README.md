# ParisSportif

ParisSportif is an iOS application developed using SwiftUI and following the principles of a clean architecture with MVVM (Model-View-ViewModel) design. The app leverages async/await for efficient and modern asynchronous programming, providing a seamless user experience.
The application uses the open API www.thesportsdb.com/api/v1.

Features
Feature 1: Fetch all leagues from API.
Feature 2: Filter leagues by displaying 1 of 2 leagues sorted by anti alphabetical.
Feature 3: Fetch and display teams by league 

Architecture
The app is designed using the clean architecture principles, separating concerns into distinct layers:

Presentation: SwiftUI views and ViewModels (MVVM).
Domain: Business logic and entities.
Data: Repository and data sources.
This architecture promotes a modular and testable codebase, making it easier to maintain and extend.

Async/Await
The app takes advantage of the async/await paradigm to handle asynchronous tasks in a more concise and readable manner. This ensures that the UI remains responsive while fetching and processing data.

Unit Testing
The project has a test coverage of 83%, ensuring the reliability and stability of the codebase. The tests cover various aspects, including ViewModel logic, data processing, and UI behavior.

Requirements
iOS 17.0+
Xcode 15.0+
Swift 5.5+

License
ParisSportif is released under the MIT License.

