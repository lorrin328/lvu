# iOS App Skeleton Notes

## Core Conclusion

1. The repository now includes a SwiftUI app shell backed by `SwiftData`.
2. The project remains localization-ready for Simplified Chinese and English from V1.
3. Trips can now be created in-app, and trip details can add itinerary days and places.

## Current Structure

- `project.yml`: XcodeGen project definition
- `App/`: SwiftUI source files
- `App/Models/`: SwiftData models
- `Resources/en.lproj/Localizable.strings`: English strings
- `Resources/zh-Hans.lproj/Localizable.strings`: Simplified Chinese strings
- `Resources/Assets.xcassets/`: asset catalog placeholder

## Implemented Screens

- Trip list
- Trip creation
- Trip detail
- Add itinerary day
- Add place
- Add route
- Expense records
- Expense creation
- Settings

## Implemented Models

- `Trip`
- `ItineraryDay`
- `Place`
- `RoutePlan`
- `Expense`

## Implemented Baseline

- `TabView` root navigation
- `SwiftData` model container
- First-launch sample data seeding
- Bilingual localization resources
- Currency and date formatting helpers

## How to Generate on Mac

### Step 1

Install XcodeGen:

```bash
brew install xcodegen
```

### Step 2

Run in the project root:

```bash
xcodegen generate
```

### Step 3

Open the generated `LVU.xcodeproj`

### Step 4

Choose a simulator and run the app

## Current Limitation

- This Windows environment cannot compile or run the iOS app
- Runtime validation still needs macOS + Xcode

## Recommended Next Step

1. Add route creation and editing
2. Add expense and trip association
3. Build a receipt OCR placeholder flow
4. Start replacing free-text route notes with structured fields
