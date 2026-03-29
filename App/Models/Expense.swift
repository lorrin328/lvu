import Foundation
import SwiftData

enum ExpenseCategory: String, Codable, CaseIterable, Identifiable {
    case dining
    case tickets
    case transport
    case hotel
    case shopping
    case other

    var id: String { rawValue }

    var localizedName: String {
        String(localized: "expense.category.\(rawValue)")
    }
}

@Model
final class Expense {
    var id: UUID
    var merchantName: String
    var amount: Double
    var category: ExpenseCategory
    var location: String
    var date: Date
    var receiptDetected: Bool

    init(
        id: UUID = UUID(),
        merchantName: String,
        amount: Double,
        category: ExpenseCategory,
        location: String,
        date: Date,
        receiptDetected: Bool
    ) {
        self.id = id
        self.merchantName = merchantName
        self.amount = amount
        self.category = category
        self.location = location
        self.date = date
        self.receiptDetected = receiptDetected
    }
}
