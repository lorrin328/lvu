# iOS App Skeleton Notes

## Core Conclusion

1. The repository now contains a SwiftUI iOS app skeleton that can be generated from source.
2. The project is localization-ready for Simplified Chinese and English from the first version.
3. This machine cannot compile the app, so generation and runtime validation must happen on macOS with Xcode.

## Current Structure

- `project.yml`: XcodeGen project definition
- `App/`: SwiftUI source files
- `Resources/en.lproj/Localizable.strings`: English strings
- `Resources/zh-Hans.lproj/Localizable.strings`: Simplified Chinese strings
- `Resources/Assets.xcassets/`: asset catalog placeholder

## Implemented Screens

- Trip list
- Trip detail
- Expense records
- Settings

## Implemented Models

- `Trip`
- `Expense`

## Implemented Baseline

- `TabView` root navigation
- Bilingual localization resources
- Sample trip cards
- Sample expense records
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

## Recommended Next Step

1. Add SwiftData and replace sample data
2. Build trip create and edit screens
3. Add `ItineraryDay` and `Place` models
4. Add a receipt OCR placeholder flow
