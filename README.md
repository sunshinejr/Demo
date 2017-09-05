## Demo

This one is a demo project for handling online/offline states of application.
Current status is still WIP (Work In Progress).

## Launching

Environment: Xcode 9 beta 6, Swift 4.0 for the app and 3.2 for libraries.
To handle libraries I've used CocoaPods. Process:

1. Clone the repo.
2. Install dependencies (`pod install`).
3. Have fun!

Also iOS 10 was chosen as a base iOS deployment target just because of Core Data updates (more below).

## Technology Stack

I've used Moya 8.0.5 for networking and RxSwift/RxCocoa 3.6.1 for reactive programming.
For tests I've used Nimble 7.0.1 and Quick 1.1.0 for BDD-ish testing and RxTest to test streams.
For database I've chosen Core Data because it is really fun to write apps in it right now after iOS 10.0 changes.

