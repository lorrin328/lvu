import SwiftUI

struct ExpenseListView: View {
    private let expenses = Expense.samples

    var body: some View {
        List {
            Section {
                ForEach(expenses) { expense in
                    ExpenseRowView(expense: expense)
                }
            } header: {
                Text(L10n.Common.today)
            } footer: {
                Text(L10n.Expenses.receiptHint)
            }

            if expenses.isEmpty {
                ContentUnavailableView(
                    L10n.Expenses.emptyTitle,
                    systemImage: "wallet.pass",
                    description: Text(L10n.Expenses.emptySubtitle)
                )
            }
        }
        .navigationTitle(L10n.Expenses.title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(L10n.Expenses.capture) {
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ExpenseListView()
    }
}
