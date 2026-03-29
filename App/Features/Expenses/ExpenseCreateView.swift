import SwiftUI

struct ExpenseCreateView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var merchantName = ""
    @State private var amount = ""
    @State private var category: ExpenseCategory = .dining
    @State private var location = ""
    @State private var date = Date()
    @State private var receiptDetected = false

    let onSave: (Expense) -> Void

    var body: some View {
        Form {
            Section(L10n.Expenses.title) {
                TextField(L10n.Expenses.merchant, text: $merchantName)
                TextField(L10n.Expenses.amount, text: $amount)
                    .keyboardType(.decimalPad)
                Picker(L10n.Expenses.category, selection: $category) {
                    ForEach(ExpenseCategory.allCases) { item in
                        Text(item.localizedName).tag(item)
                    }
                }
                TextField(L10n.Expenses.location, text: $location)
                DatePicker(L10n.Expenses.date, selection: $date)
                Toggle(L10n.Expenses.receiptDetected, isOn: $receiptDetected)
            }
        }
        .navigationTitle(L10n.Expenses.createTitle)
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
                            receiptDetected: receiptDetected
                        )
                    )
                    dismiss()
                }
                .disabled(merchantName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ExpenseCreateView { _ in }
    }
}
