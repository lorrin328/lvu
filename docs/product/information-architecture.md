# LVU Information Architecture and MVP Priority

## Core Conclusion

1. The product structure should be centered on `Trip`, not on generic attractions or maps.
2. The primary user flow is: create trip -> plan by day -> store place and route details -> record expenses -> review totals.
3. The first build should prioritize closed-loop usability over automation depth.
4. The app information architecture must be localization-ready for Simplified Chinese and English from V1.

## Information Architecture

```text
LVU
- Trip List
  - Create Trip
  - Open Existing Trip
- Trip Overview
  - Basic Info
  - Daily Plans
  - Places
  - Routes
  - Expenses
- Daily Plan
  - Timeline Items
  - Add Place
  - Reorder Stops
  - Day Notes
- Place Detail
  - Attraction Info
  - Dining Info
  - Parking / Parent-Child Notes
  - Map Handoff
- Route Planning
  - From / To
  - Distance / Duration
  - Drive Mode
  - Fuel / Rest Notes
- Expense Center
  - Expense List
  - Manual Entry
  - Screenshot Parsing
  - Summary
- Settings
  - Default Preferences
```

## Main User Flow

### Flow 1: Create a New Trip

1. User enters trip basics
2. User selects self-drive or not
3. User indicates whether children are included
4. User sets budget and dates
5. App creates the trip and opens trip overview

### Flow 2: Build a Daily Plan

1. User opens a trip
2. User creates a day plan
3. User adds attractions, restaurants, and support points
4. User arranges stop order
5. User saves the day plan

### Flow 3: Record an Expense from Screenshot

1. User opens expense center
2. User uploads a screenshot
3. OCR extracts amount, merchant, time, and address clues
4. App recommends candidate places
5. User edits if needed and confirms
6. Expense is saved to the selected trip and day

### Flow 4: Review a Trip During Travel

1. User opens the current trip
2. User checks today's itinerary
3. User opens the next place or route
4. User jumps to an external map app if needed
5. User records spending along the way

## Screen Priority

### P0 Screens

- Trip List
- Create/Edit Trip
- Trip Overview
- Daily Plan
- Place Detail
- Expense List
- Expense Entry
- Screenshot Parsing

### P1 Screens

- Route Planning
- Cost Summary Dashboard
- Place Favorites / Template Entry

### P2 Screens

- Collaborative Planning
- AI Generated Draft Plan
- Packing List Assistant

## MVP Priority Table

| Module | Priority | Why It Matters | Version 1 Scope |
| --- | --- | --- | --- |
| Trip management | P0 | Entry point for every workflow | Create, edit, list |
| Daily itinerary | P0 | Core planning function | Day timeline, ordering, notes |
| Place management | P0 | Supports attractions, food, rest, support points | Manual add and edit |
| Expense tracking | P0 | Critical for travel execution and review | Manual entry + screenshot parse |
| Route handoff | P0 | Users need directional support | Save route info + external maps |
| Budget analysis | P1 | Useful after core loop is stable | Totals, category summary, alerts |
| Gas / rest suggestions | P1 | Valuable for self-drive trips | Nearby support recommendations |
| AI itinerary assistance | P2 | Nice-to-have after data model is stable | Draft suggestions only |

## MVP Success Criteria

- A user can create one complete trip from start to finish
- A user can plan at least one day with multiple stops
- A user can save route notes and open map navigation externally
- A user can record a receipt from a screenshot with manual confirmation
- A user can review total spend for a trip

## Risks and Constraints

### Product Risks

- Too many feature ideas can delay the first usable version
- Route intelligence can expand into full navigation scope
- Place information quality may vary if entered manually

### Technical Risks

- OCR extraction accuracy will differ by payment app and screenshot quality
- Local-first data must still support future migration to cloud sync
- Parent-child metadata should stay simple in V1 to avoid over-modeling

## Recommended Build Sequence

### Phase 1

- Trip model
- Itinerary model
- Place model
- SwiftUI navigation skeleton

### Phase 2

- Daily plan editing
- Place detail and notes
- Basic route records

### Phase 3

- Expense list
- Manual expense entry
- Screenshot OCR pipeline

### Phase 4

- Cost summary
- UX polish
- Demo-ready review pass

## Localization Notes

- Screen titles, CTA buttons, field labels, and validation messages must use shared localization keys
- Expense categories and place types should be defined as enum-backed keys, not hard-coded display text
- Information architecture labels must keep one-to-one mapping between Chinese and English to reduce product drift
