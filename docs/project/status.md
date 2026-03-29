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
- Expense-to-trip and expense-to-day linking
- Expense list filtering by trip/day
- Trip expense total and per-day summary
- Route edit and delete flows
- Receipt OCR placeholder page and parser protocol boundary
- Structured route fields with legacy-text compatibility
- GitHub PR/Issue templates and baseline CI
- Minimal test target with key logic tests

## Current Data Models

- `Trip`
- `ItineraryDay`
- `Place`
- `RoutePlan`
- `Expense`

## Current Limitations

- Runtime verification still requires macOS + Xcode
- OCR is still placeholder-only and not connected to a real OCR engine

## Next Suggested Build Order

1. Integrate a real OCR engine (Vision or third-party) behind the parser protocol
2. Add expense edit/delete and bulk correction flow
3. Expand automated tests across model and user flows
4. Add budget alerts and richer expense analytics
