# LVU Project Status

## Current Stage

- Stage: iOS app skeleton + SwiftData baseline
- Branch status: `main`
- Delivery status: repository bootstrapped and product docs in sync

## Completed

- GitHub repository binding
- Bilingual product documentation
- XcodeGen project definition
- SwiftUI tab shell
- Bilingual localization resources
- SwiftData model container
- First-launch sample data seeding
- Trip creation flow
- Trip detail add-day flow
- Trip detail add-place flow
- Trip detail add-route flow
- Expense create flow

## Current Data Models

- `Trip`
- `ItineraryDay`
- `Place`
- `RoutePlan`
- `Expense`

## Current Limitations

- Runtime verification still requires macOS + Xcode
- Expense and trip association are not built yet
- OCR flow is not connected yet

## Next Suggested Build Order

1. Link expenses to trips and days
2. Add route edit and delete flows
3. Add receipt OCR placeholder and parser pipeline boundary
4. Replace free-text route notes with structured fields
