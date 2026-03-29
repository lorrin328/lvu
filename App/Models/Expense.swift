import Foundation

struct Expense: Identifiable, Hashable {
    enum Category: String, CaseIterable, Identifiable {
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

    let id: UUID
    let merchantName: String
    let amount: Decimal
    let category: Category
    let location: String
    let date: Date
    let receiptDetected: Bool
}

extension Expense {
    static let samples: [Expense] = [
        Expense(
            id: UUID(),
            merchantName: L10n.Sample.expenseOneMerchant,
            amount: 168,
            category: .dining,
            location: L10n.Sample.expenseOneLocation,
            date: .now,
            receiptDetected: true
        ),
        Expense(
            id: UUID(),
            merchantName: L10n.Sample.expenseTwoMerchant,
            amount: 380,
            category: .transport,
            location: L10n.Sample.expenseTwoLocation,
            date: Calendar.current.date(byAdding: .day, value: -1, to: .now) ?? .now,
            receiptDetected: false
        )
    ]
}
