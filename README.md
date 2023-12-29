# ParisSportif

ParisSportif is an iOS application developed using SwiftUI and following the principles of a clean architecture with MVVM (Model-View-ViewModel) design. The app leverages async/await for efficient and modern asynchronous programming, providing a seamless user experience.
The application uses the open API www.thesportsdb.com/api/v1.

![Simulator Screen Recording - iPhone 15 iOS 17 - 2023-12-28 at 22 11 04](https://github.com/redamimouni/ParisSportif/assets/4302565/76755342-48bd-4d45-b26b-5d1f0b2664c6)

### Features:
Feature 1: Fetch all leagues from API.

Feature 2: Filter leagues by displaying 1 of 2 leagues sorted by anti alphabetical.

Feature 3: Fetch and display teams by league 

### Architecture:
The app is designed using the clean architecture principles, separating concerns into distinct layers:

Presentation: SwiftUI views and ViewModels (MVVM).

Domain: Business logic and entities.

Data: Repository and data sources.

This architecture promotes a modular and testable codebase, making it easier to maintain and extend.

### Async/Await:
The app takes advantage of the async/await paradigm to handle asynchronous tasks in a more concise and readable manner. This ensures that the UI remains responsive while fetching and processing data.

### Unit Testing:
The project has a test coverage of 84%, ensuring the reliability and stability of the codebase. The tests cover various aspects, including ViewModel logic, data processing, and UI behavior.

### Improvements ideas:
Some improvements can be made, as:

- Adding some UI/Snapshot tests to test the views
- Create a service layer that will build the requests and perform the calls.
- Separate the network layer in an external core package (SPM for example) so it can be maintained easily.

### Requirements:
iOS 17.0+

Xcode 15.0+

Swift 5.5+

# License:
ParisSportif is released under the MIT License.

