import SwiftUI

struct TripCreateView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var origin = ""
    @State private var destination = ""
    @State private var startDate = Date()
    @State private var endDate = Calendar.current.date(byAdding: .day, value: 2, to: Date()) ?? Date()
    @State private var isSelfDrive = true
    @State private var withKids = true
    @State private var kidAgeGroup: KidAgeGroup = .preschool
    @State private var budget = ""
    @State private var highlights = ""
    @State private var routeSummary = ""

    let onSave: (Trip) -> Void

    var body: some View {
        Form {
            Section(L10n.Trips.basicInfo) {
                TextField(L10n.Trips.titleField, text: $title)
                TextField(L10n.Trips.originField, text: $origin)
                TextField(L10n.Trips.destinationField, text: $destination)
                DatePicker(L10n.Trips.startDate, selection: $startDate, displayedComponents: .date)
                DatePicker(L10n.Trips.endDate, selection: $endDate, in: startDate..., displayedComponents: .date)
                TextField(L10n.Trips.budgetField, text: $budget)
                    .keyboardType(.decimalPad)
            }

            Section(L10n.Trips.planning) {
                Toggle(L10n.Common.selfDrive, isOn: $isSelfDrive)
                Toggle(L10n.Common.withKids, isOn: $withKids)

                if withKids {
                    Picker(L10n.Trips.kidAgeGroup, selection: $kidAgeGroup) {
                        ForEach(KidAgeGroup.allCases) { group in
                            Text(group.localizedName).tag(group)
                        }
                    }
                }

                TextField(L10n.Trips.highlightsField, text: $highlights, axis: .vertical)
                    .lineLimit(3...5)
                TextField(L10n.Trips.routeSummaryField, text: $routeSummary, axis: .vertical)
                    .lineLimit(2...4)
            }

            Section(L10n.Trips.preview) {
                LabeledContent(L10n.Trips.titleField, value: title.isEmpty ? L10n.Trips.noData : title)
                LabeledContent(L10n.Trips.fromTo, value: routePreview)
                LabeledContent(L10n.Common.budget, value: budget.isEmpty ? L10n.Trips.noData : budget)
            }
        }
        .navigationTitle(L10n.Trips.createTitle)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(L10n.Common.cancel) {
                    dismiss()
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(L10n.Trips.save) {
                    onSave(makeTrip())
                    dismiss()
                }
                .disabled(!isValid)
            }
        }
    }

    private var isValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !origin.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !destination.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private var routePreview: String {
        let parts = [origin, destination].filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        return parts.isEmpty ? L10n.Trips.noData : parts.joined(separator: " -> ")
    }

    private func makeTrip() -> Trip {
        let parsedBudget = Double(budget) ?? 0
        let highlightItems = highlights
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        return Trip(
            title: title,
            origin: origin,
            destination: destination,
            startDate: startDate,
            endDate: endDate,
            isSelfDrive: isSelfDrive,
            withKids: withKids,
            kidAgeGroup: withKids ? kidAgeGroup : .mixed,
            budget: parsedBudget,
            highlights: highlightItems,
            routeSummary: routeSummary.isEmpty ? L10n.Trips.noData : routeSummary
        )
    }
}

#Preview {
    NavigationStack {
        TripCreateView { _ in }
    }
    .modelContainer(for: [Trip.self, ItineraryDay.self, Place.self, RoutePlan.self, Expense.self], inMemory: true)
}
