# LVU Stage Test Checklist (MVP Loop)

## Scope

- Branch: `codex/lvu-mvp-closure` and later merged versions
- Goal: validate the 5 core loop capabilities delivered in this stage

## Environment Setup

1. Open Xcode and choose an iOS Simulator (recommended: `iPhone 17`).
2. Clear app history (remove app from simulator and reinstall).
3. Launch app and confirm sample data is seeded (initial Trips / Expenses exist).

## Automated Pre-check (recommended first)

```bash
tmp=/tmp/lvu-stage-check
rm -rf "$tmp" && mkdir -p "$tmp"
git archive HEAD | tar -x -C "$tmp"
cd "$tmp"
/tmp/xcodegen generate
xcodebuild -project LVU.xcodeproj -scheme LVU -destination 'platform=iOS Simulator,name=iPhone 17' test -quiet
```

Pass criteria: command exits with code `0`.

## Manual Acceptance Steps

### 1. Expense linked to Trip / Day

- Steps:
1. Go to `Expenses` tab, tap `Add Receipt` -> `Add Manual`.
2. Fill merchant, amount, category, location, and date.
3. In `Linking`, select a `Trip` and an `Itinerary Day`.
4. Save.
- Expected:
1. New expense appears in list.
2. Expense row shows trip and `Day N`.
3. The same expense appears in the selected trip detail page.

### 2. Trip expense summary (total / per day)

- Steps:
1. Open the trip detail page used above.
2. Scroll to the `Expenses` section.
- Expected:
1. `Total` amount is displayed.
2. Per-day subtotals are displayed (`Day 1`, `Day 2`, etc.).
3. If any expense is not linked to a day, `Not linked to a day` subtotal appears.

### 3. Expense list filtering by Trip / Day

- Steps:
1. In `Expenses` filter section, choose a specific `Trip`.
2. Then choose a specific `Itinerary Day`.
3. Switch back to `All trips` / `All days`.
- Expected:
1. List items update with selected filters.
2. Non-matching expenses are hidden.
3. Full list is restored after resetting filters.

### 4. Route edit and delete

- Steps:
1. Open a trip detail page and go to `Routes`.
2. Swipe a route and tap `Edit Route`, update distance/duration/note, then save.
3. Swipe again, tap `Delete Route`, and confirm.
- Expected:
1. Edited route values are updated immediately and persisted.
2. Delete requires confirmation.
3. Deleted route disappears and does not return after re-entering page.

### 5. OCR placeholder flow (upload placeholder -> parse draft -> confirm/save)

- Steps:
1. In `Expenses`, tap `Add Receipt` -> `OCR Placeholder`.
2. Pick an image (placeholder only), then paste sample text:
   `Little Panda Cafe` + `Total: 168.50` + an address line.
3. Tap `Parse Draft`.
4. Review/adjust fields, select Trip/Day, and save.
- Expected:
1. UI shows selected image status.
2. Draft fields auto-populate merchant/amount (when matched) and confidence.
3. Saved expense is created with `receiptDetected = true`.

## Pass Criteria

- Stage passes when all 5 checks match expected behavior.
- If any check fails, record:
1. Failed step number
2. Actual behavior
3. Expected behavior
4. Screenshot/screen recording (optional)
