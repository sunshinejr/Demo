## Demo

This one is a demo project for handling online/offline states of application.<br />
Current status is still **WIP (Work In Progress)**.

## Launching

Environment: Xcode 9 beta 6, Swift 4.0 for the app and 3.2 for libraries.<br />
To handle libraries I've used CocoaPods. Process:

1. Clone the repo.
2. Install dependencies (`pod install`) & open `Demo.xcworkspace`.
3. Have fun!

Also iOS 10 was chosen as a base iOS deployment target just because of `Core Data` updates (more below).

## Technology Stack

- Moya 8 for networking
- Core Data for persistance
- RxSwift/RxCocoa 3.6 for Reactive Programming
- Quick 7 / Nimble 1.1 for BDD-ish testing (with `given/when/then` aliases)
- RxTest 3.6 for stream/events testing

