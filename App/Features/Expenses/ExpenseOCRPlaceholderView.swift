import SwiftUI
import SwiftData
import PhotosUI

struct ExpenseOCRPlaceholderView: View {
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Trip.startDate, order: .reverse) private var trips: [Trip]

    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var rawText = ""
    @State private var merchantName = ""
    @State private var amount = ""
    @State private var location = ""
    @State private var date = Date()
    @State private var confidence = 0.0
    @State private var category: ExpenseCategory = .other
    @State private var selectedTripID: UUID?
    @State private var selectedDayID: UUID?

    let parser: ReceiptParser
    let onSave: (Expense) -> Void

    init(parser: ReceiptParser = PlaceholderReceiptParser(), onSave: @escaping (Expense) -> Void) {
        self.parser = parser
        self.onSave = onSave
    }

    private var selectedTrip: Trip? {
        guard let selectedTripID else { return nil }
        return trips.first(where: { $0.id == selectedTripID })
    }

    private var availableDays: [ItineraryDay] {
        guard let selectedTrip else { return [] }
        return selectedTrip.itineraryDays.sorted { $0.dayNumber < $1.dayNumber }
    }

    private var saveDisabled: Bool {
        selectedTripID == nil || merchantName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        Form {
            Section(L10n.Expenses.ocrPlaceholderTitle) {
                Text(L10n.Expenses.ocrPlaceholderHint)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                    Label(L10n.Expenses.capture, systemImage: "photo")
                }
                if selectedPhotoItem != nil {
                    Label(L10n.Expenses.selectedImage, systemImage: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }
            }

            Section(L10n.Expenses.rawText) {
                TextEditor(text: $rawText)
                    .frame(minHeight: 120)
                Button(L10n.Expenses.parseDraft) {
                    applyParsedDraft()
                }
                .disabled(rawText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }

            Section(L10n.Expenses.parseResult) {
                TextField(L10n.Expenses.merchant, text: $merchantName)
                TextField(L10n.Expenses.amount, text: $amount)
                    .keyboardType(.decimalPad)
                TextField(L10n.Expenses.location, text: $location)
                Picker(L10n.Expenses.category, selection: $category) {
                    ForEach(ExpenseCategory.allCases) { item in
                        Text(item.localizedName).tag(item)
                    }
                }
                DatePicker(L10n.Expenses.date, selection: $date)
                LabeledContent(L10n.Expenses.confidence, value: "\(Int(confidence * 100))%")
            }

            Section(L10n.Expenses.linking) {
                Picker(L10n.Expenses.trip, selection: $selectedTripID) {
                    Text(L10n.Expenses.selectTripPlaceholder).tag(Optional<UUID>.none)
                    ForEach(trips) { trip in
                        Text(trip.title).tag(Optional(trip.id))
                    }
                }

                Picker(L10n.Expenses.itineraryDay, selection: $selectedDayID) {
                    Text(L10n.Expenses.noDay).tag(Optional<UUID>.none)
                    ForEach(availableDays) { day in
                        Text("\(L10n.Trips.dayTitle) \(day.dayNumber)")
                            .tag(Optional(day.id))
                    }
                }
                .disabled(selectedTripID == nil)
            }
        }
        .onAppear {
            if selectedTripID == nil, let firstTrip = trips.first {
                selectedTripID = firstTrip.id
            }
        }
        .onChange(of: selectedTripID) { _, _ in
            let dayStillValid = availableDays.contains(where: { $0.id == selectedDayID })
            if !dayStillValid {
                selectedDayID = nil
            }
        }
        .navigationTitle(L10n.Expenses.ocrPlaceholderTitle)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(L10n.Common.cancel) {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(L10n.Trips.save) {
                    onSave(
                        Expense(
                            merchantName: merchantName,
                            amount: Double(amount) ?? 0,
                            category: category,
                            location: location.isEmpty ? L10n.Trips.noData : location,
                            date: date,
                            receiptDetected: true,
                            trip: selectedTrip,
                            itineraryDay: availableDays.first(where: { $0.id == selectedDayID })
                        )
                    )
                    dismiss()
                }
                .disabled(saveDisabled)
            }
        }
    }

    private func applyParsedDraft() {
        let parsed = parser.parse(rawText: rawText, occurredAt: date)
        merchantName = parsed.merchantName ?? merchantName
        if let parsedAmount = parsed.amount {
            amount = String(format: "%.2f", parsedAmount)
        }
        location = parsed.address ?? location
        date = parsed.occurredAt
        confidence = parsed.confidence
    }
}

#Preview {
    NavigationStack {
        ExpenseOCRPlaceholderView { _ in }
    }
    .modelContainer(for: [Trip.self, ItineraryDay.self, Place.self, RoutePlan.self, Expense.self], inMemory: true)
}
