import SwiftUI
import SwiftData

struct RootTabView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var seeded = false

    var body: some View {
        TabView {
            NavigationStack {
                TripListView()
            }
            .tabItem {
                Label(L10n.Tab.trips, systemImage: "airplane.circle")
            }

            NavigationStack {
                ExpenseListView()
            }
            .tabItem {
                Label(L10n.Tab.expenses, systemImage: "wallet.pass")
            }

            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label(L10n.Tab.settings, systemImage: "gearshape")
            }
        }
        .task {
            guard !seeded else { return }
            try? SampleDataSeeder.seedIfNeeded(in: modelContext)
            seeded = true
        }
    }
}

#Preview {
    RootTabView()
        .modelContainer(for: [Trip.self, ItineraryDay.self, Place.self, RoutePlan.self, Expense.self], inMemory: true)
}
