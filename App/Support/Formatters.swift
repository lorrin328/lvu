import Foundation

enum LVUFormatters {
    static let tripDateRange: DateIntervalFormatter = {
        let formatter = DateIntervalFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    static let expenseDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .autoupdatingCurrent
        return formatter
    }()
}

func localizedCurrency(_ amount: Double) -> String {
    LVUFormatters.currency.string(from: NSNumber(value: amount)) ?? "\(amount)"
}
