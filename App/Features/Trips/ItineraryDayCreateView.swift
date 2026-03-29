import SwiftUI

struct ItineraryDayCreateView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var dayNumber = 1
    @State private var date = Date()
    @State private var summary = ""
    @State private var notes = ""

    let onSave: (ItineraryDay) -> Void

    var body: some View {
        Form {
            Section(L10n.Trips.basicInfo) {
                Stepper(value: $dayNumber, in: 1...30) {
                    Text("\(L10n.Trips.dayTitle) \(dayNumber)")
                }
                DatePicker(L10n.Trips.startDate, selection: $date, displayedComponents: .date)
            }

            Section(L10n.Trips.planning) {
                TextField(L10n.Trips.daySummaryField, text: $summary, axis: .vertical)
                    .lineLimit(2...4)
                TextField(L10n.Trips.dayNotesField, text: $notes, axis: .vertical)
                    .lineLimit(3...5)
            }
        }
        .navigationTitle(L10n.Trips.addDay)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(L10n.Common.cancel) {
                    dismiss()
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(L10n.Trips.save) {
                    onSave(
                        ItineraryDay(
                            dayNumber: dayNumber,
                            date: date,
                            summary: summary.isEmpty ? L10n.Trips.noData : summary,
                            notes: notes.isEmpty ? L10n.Trips.noData : notes
                        )
                    )
                    dismiss()
                }
                .disabled(summary.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ItineraryDayCreateView { _ in }
    }
}
