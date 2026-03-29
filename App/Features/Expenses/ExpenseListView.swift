import SwiftUI
import SwiftData

struct ExpenseListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Expense.date, order: .reverse) private var expenses: [Expense]
    @Query(sort: \Trip.startDate, order: .reverse) private var trips: [Trip]
    @State private var showingCreateSheet = false
    @State private var showingOCRSheet = false
    @State private var showingAddMenu = false
    @State private var selectedTripID: UUID?
    @State private var selectedDayID: UUID?
    
    private var availableDays: [ItineraryDay] {
        guard let selectedTripID,
              let trip = trips.first(where: { $0.id == selectedTripID }) else {
            return []
        }
        return trip.itineraryDays.sorted { $0.dayNumber < $1.dayNumber }
    }
    
    private var filteredExpenses: [Expense] {
        let tripFiltered: [Expense]
        if let selectedTripID {
            tripFiltered = expenses.filter { $0.trip?.id == selectedTripID }
        } else {
            tripFiltered = expenses
        }
        
        if let selectedDayID {
            return tripFiltered.filter { $0.itineraryDay?.id == selectedDayID }
        }
        return tripFiltered
    }

    var body: some View {
        List {
            Section(L10n.Expenses.filters) {
                Picker(L10n.Expenses.trip, selection: $selectedTripID) {
                    Text(L10n.Expenses.allTrips).tag(Optional<UUID>.none)
                    ForEach(trips) { trip in
                        Text(trip.title).tag(Optional(trip.id))
                    }
                }
                
                Picker(L10n.Expenses.itineraryDay, selection: $selectedDayID) {
                    Text(L10n.Expenses.allDays).tag(Optional<UUID>.none)
                    ForEach(availableDays) { day in
                        Text("\(L10n.Trips.dayTitle) \(day.dayNumber)")
                            .tag(Optional(day.id))
                    }
                }
                .disabled(selectedTripID == nil)
            }

            Section {
                ForEach(filteredExpenses) { expense in
                    ExpenseRowView(expense: expense)
                }
            } header: {
                Text(L10n.Common.today)
            } footer: {
                Text(L10n.Expenses.receiptHint)
            }

            if filteredExpenses.isEmpty {
                ContentUnavailableView(
                    L10n.Expenses.emptyTitle,
                    systemImage: "wallet.pass",
                    description: Text(L10n.Expenses.emptySubtitle)
                )
            }
        }
        .onChange(of: selectedTripID) { _, _ in
            let dayStillValid = availableDays.contains(where: { $0.id == selectedDayID })
            if !dayStillValid {
                selectedDayID = nil
            }
        }
        .navigationTitle(L10n.Expenses.title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(L10n.Expenses.capture) {
                    showingAddMenu = true
                }
            }
        }
        .confirmationDialog(L10n.Expenses.capture, isPresented: $showingAddMenu, titleVisibility: .visible) {
            Button(L10n.Expenses.addManual) {
                showingCreateSheet = true
            }
            Button(L10n.Expenses.addFromOCR) {
                showingOCRSheet = true
            }
            Button(L10n.Common.cancel, role: .cancel) {}
        }
        .sheet(isPresented: $showingCreateSheet) {
            NavigationStack {
                ExpenseCreateView { expense in
                    modelContext.insert(expense)
                }
            }
        }
        .sheet(isPresented: $showingOCRSheet) {
            NavigationStack {
                ExpenseOCRPlaceholderView { expense in
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
