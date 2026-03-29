# LVU iOS App PRD (MVP)

## Core Conclusion

1. The first version should be positioned as a travel planning and execution app for family and parent-child trips.
2. The MVP focuses on five capabilities: trip creation, daily itinerary planning, place management, route planning, and expense tracking.
3. The differentiating feature is receipt screenshot parsing with auto-detected location suggestions plus manual confirmation.

## Problem Diagnosis

### Current Situation

Users planning a trip need to switch between maps, review apps, travel notes, chat logs, booking tools, and payment records. This is especially painful for parent-child trips, where users also need to consider timing, rest stops, parking, fuel, and meal planning.

### Target

Users should be able to complete a full loop around a single trip:

- Plan before departure
- Execute during the trip
- Review costs and decisions after the trip

### Gap

Existing tools solve isolated needs, but not the entire planning workflow centered around one trip.

## Cause Breakdown

### Business

Trip planning spans destinations, attractions, restaurants, transport, supplies, and spending records.

### Resource

Users do not have enough time to continuously search and reorganize information while traveling.

### Mechanism

Current products are organized by single function rather than by a complete trip workflow.

### User

Trips with children create more decision pressure and higher demand for certainty.

## Impact Assessment

### Scale

A 2-to-5-day trip often requires several hours or more of preparation.

### Efficiency

Repeated searching and app switching significantly increase planning time.

### Risk

Last-minute decisions increase the risk of bad routes, poor meal choices, poor child pacing, insufficient supplies, and uncontrolled expenses.

## Solution

## Product Positioning

### Product Name

LVU

### One-Sentence Positioning

An iOS app for family and parent-child travel planning that helps users prepare ahead, execute smoothly during the trip, and review costs afterward.

### Core Value

- Organize all travel information around one trip
- Increase certainty for family travel
- Reduce the cost of searching and recording information during the trip

## Target Users

### Core Users

- Family travelers aged 25 to 45
- Parents traveling with children
- Users who prefer self-driving or free-form trips
- Users willing to plan but unwilling to juggle many apps

### Secondary Users

- Couples traveling together
- Families taking short nearby trips
- Users who want to review trip spending

## Core User Scenarios

### Scenario 1: Pre-Trip Planning

- Decide where to go
- Decide what to do each day
- Plan where to eat
- Plan routes and driving arrangements
- Prepare parking, refueling, and rest-stop options

### Scenario 2: In-Trip Execution

- Quickly view the current day's plan
- Check place details
- Navigate to the next destination
- Review nearby support points
- Record trip expenses

### Scenario 3: Post-Trip Review

- View total spending
- Check spending by day
- Review whether itinerary pacing worked
- Reuse the structure for the next trip

## MVP Scope

### P0 Must-Have

#### 1. Trip Management

- Create a trip
- Edit trip details
- View trip list

Suggested fields:

- Trip title
- Origin
- Destination
- Date range
- Travel mode: self-drive / non-self-drive
- Parent-child toggle
- Kid age group
- Budget

#### 2. Daily Itinerary Planning

- Create itinerary by day
- Add multiple places to a day
- Reorder items
- Add notes

Suggested fields:

- Date
- Time slot
- Place
- Stay duration
- Notes
- Kid-friendly flag
- Reservation required

#### 3. Place Cards

- Manually add attractions, restaurants, and support points
- Save core place information
- Add tags and notes

Suggested fields:

- Name
- Address
- Type: attraction / restaurant / hotel / gas station / service area / other
- Description
- Opening hours
- Cost info
- Parking info
- Kid-friendly note
- User notes

#### 4. Route Planning

- Save routes between places
- Mark self-drive vs non-self-drive
- Show estimated distance and duration
- Open external map apps

Version 1 guideline:

- Do not build in-app navigation
- Store route info and jump to Apple Maps or other apps

#### 5. Expense Tracking

- Add expenses manually
- Upload screenshots to parse content
- Auto-suggest place candidates
- Let users confirm or edit before saving
- Summarize by trip and by day

Suggested fields:

- Amount
- Category: dining / tickets / transport / hotel / shopping / other
- Merchant name
- Address or place
- Occurred time
- Related trip
- Related itinerary day
- Receipt image

### P1 Phase Two

- Gas station, parking lot, and service area suggestions
- Budget alerts
- Place favorites
- Reusable itinerary templates
- Parent-child filters
- Destination guide summaries

### P2 Phase Three

- Multi-user collaborative planning
- AI-generated draft itineraries
- Parent-child pacing recommendations
- Better automatic expense categorization
- Auto-generated packing lists

## Differentiating Features

### 1. Parent-Child Friendly Planning

Goal:

Help users factor child suitability, pacing, parking, and rest conditions into the plan from the start.

Implementation:

- Ask whether the trip includes children during creation
- Add child-friendly metadata to places
- Represent daily plans by pacing, not just place count

### 2. Screenshot-Based Expense Entry

Goal:

Reduce friction for recording travel spending.

Minimum workable flow:

- User uploads a screenshot
- OCR extracts text
- System identifies amount, merchant, time, and address keywords
- System suggests matching place candidates
- User confirms or edits before saving

Important rule:

The first version must keep manual confirmation in the flow.

## Page Structure

### Storyline

The user creates a trip, arranges plans day by day, stores place and route information, and records expenses while traveling. After the trip, the app summarizes total spending and trip decisions.

### Pages

- Trip List
- New Trip
- Trip Overview
- Daily Plan
- Place Detail
- Route Planning
- Expense Records
- Receipt Parsing
- Cost Summary

### Page Notes

#### 1. Trip List

- Show all trip plans
- Display date, destination, travel mode, and budget summary
- Support create and duplicate actions

#### 2. New Trip

- Enter name, dates, destination, self-drive option, and parent-child setting
- Set budget and kid age group
- Navigate into trip overview after creation

#### 3. Trip Overview

- Show high-level trip information
- Navigate by day
- Summarize places, routes, and spending

#### 4. Daily Plan

- Timeline view of the day's itinerary
- Add attractions, restaurants, rest points, and support points
- Reorder items and add notes

#### 5. Place Detail

- Show summary, address, opening hours, parking, ticket cost, and average spend
- Support tags and notes
- Open map navigation

#### 6. Route Planning

- Show planned route between places
- Display estimated distance and duration
- Show self-drive flag and support point notes

#### 7. Expense Records

- View spending by day or category
- Show amount, merchant, place, and screenshot
- Support edit and delete

#### 8. Receipt Parsing

- Upload a screenshot
- Auto-detect amount, merchant, and address
- Recommend a related place
- Let the user confirm before saving

#### 9. Cost Summary

- Show total spending, category mix, and daily totals
- Compare budget against actual spending

## Core Data Objects

### Trip

- id
- title
- startDate
- endDate
- origin
- destination
- travelMode
- withKids
- kidAgeGroup
- budget
- notes

### ItineraryDay

- id
- tripId
- date
- summary
- notes

### Place

- id
- tripId
- dayId
- name
- type
- address
- description
- openHours
- costInfo
- parkingInfo
- kidFriendly
- notes

### Route

- id
- tripId
- dayId
- fromPlaceId
- toPlaceId
- mode
- distance
- duration
- fuelStopNote
- parkingNote

### Expense

- id
- tripId
- dayId
- placeId
- amount
- category
- merchantName
- address
- occurredAt
- receiptImage
- ocrText
- notes

## Business Rules

1. All content is organized under a single `Trip`.
2. One trip contains multiple `ItineraryDay` entries.
3. A place can belong to a specific day or the whole trip.
4. Expense recognition must support auto-detection followed by manual confirmation.
5. Route planning is for organization and map handoff, not real-time navigation.

## Phase One Plan

### Week 1

- Finalize PRD
- Confirm information architecture
- Draft page wireframes
- Confirm iOS technology stack

### Week 2

- Create iOS project structure
- Build core data models
- Complete the first version of trip, itinerary, and place pages

### Week 3

- Build expense tracking module
- Support manual expense entry first
- Then add screenshot OCR parsing

### Week 4

- Add route planning page
- Add map handoff
- Complete a demo-ready MVP loop

## Technical Recommendation

### Target Architecture

- Native iOS app
- Swift + SwiftUI
- Local-first data storage
- Revisit account system and cloud sync later

### Components

- UI: SwiftUI
- Storage: SwiftData or Core Data
- OCR: iOS Vision framework first
- Map handoff: Apple Maps URL scheme first
- Media input: PhotosPicker / Camera

### Risks

- OCR reliability will vary by receipt format
- Manual place entry can become heavy if external data is absent
- Deep route intelligence quickly expands scope

### Suggested Choice

Version 1 should be a trip organization tool rather than a travel content platform. Finish one complete trip workflow before adding recommendation intelligence.
