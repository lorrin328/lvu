import SwiftUI

struct RootTabView: View {
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
    }
}

#Preview {
    RootTabView()
}
