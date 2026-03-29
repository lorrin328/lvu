import Foundation
import SwiftData

@Model
final class ItineraryDay {
    var id: UUID
    var dayNumber: Int
    var date: Date
    var summary: String
    var notes: String
    @Relationship(deleteRule: .nullify, inverse: \Expense.itineraryDay) var expenses: [Expense]

    init(
        id: UUID = UUID(),
        dayNumber: Int,
        date: Date,
        summary: String,
        notes: String,
        expenses: [Expense] = []
    ) {
        self.id = id
        self.dayNumber = dayNumber
        self.date = date
        self.summary = summary
        self.notes = notes
        self.expenses = expenses
    }
}
