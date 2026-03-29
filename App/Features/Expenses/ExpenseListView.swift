import SwiftUI
import SwiftData

struct ExpenseListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Expense.date, order: .reverse) private var expenses: [Expense]
    @State private var showingCreateSheet = false

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
                    showingCreateSheet = true
                }
            }
        }
        .sheet(isPresented: $showingCreateSheet) {
            NavigationStack {
                ExpenseCreateView { expense in
                    modelContext.insert(expense)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ExpenseListView()
    }
    .modelContainer(for: [Trip.self, ItineraryDay.self, Place.self, RoutePlan.self, Expense.self], inMemory: true)
}
