import Foundation

struct ExpenseDaySummary: Identifiable {
    let id: String
    let title: String
    let amount: Double
}

enum ExpenseDomain {
    static func filter(expenses: [Expense], tripID: UUID?, dayID: UUID?) -> [Expense] {
        let tripFiltered: [Expense]
        if let tripID {
            tripFiltered = expenses.filter { $0.trip?.id == tripID }
        } else {
            tripFiltered = expenses
        }

        if let dayID {
            return tripFiltered.filter { $0.itineraryDay?.id == dayID }
        }
        return tripFiltered
    }

    static func summarizeByDay(
        expenses: [Expense],
        itineraryDays: [ItineraryDay],
        dayTitlePrefix: String,
        unassignedTitle: String
    ) -> (total: Double, daySummaries: [ExpenseDaySummary]) {
        let sorted = expenses.sorted { $0.date > $1.date }
        let total = sorted.reduce(0) { $0 + $1.amount }

        var summaries = itineraryDays
            .sorted { $0.dayNumber < $1.dayNumber }
            .compactMap { day -> ExpenseDaySummary? in
                let amount = sorted
                    .filter { $0.itineraryDay?.id == day.id }
                    .reduce(0) { $0 + $1.amount }
                guard amount > 0 else { return nil }
                return ExpenseDaySummary(
                    id: day.id.uuidString,
                    title: "\(dayTitlePrefix) \(day.dayNumber)",
                    amount: amount
                )
            }

        let unassignedAmount = sorted
            .filter { $0.itineraryDay == nil }
            .reduce(0) { $0 + $1.amount }
        if unassignedAmount > 0 {
            summaries.append(
                ExpenseDaySummary(
                    id: "unassigned-day-expense",
                    title: unassignedTitle,
                    amount: unassignedAmount
                )
            )
        }

        return (total, summaries)
    }
}
