import SwiftUI
import SwiftData

@main
struct LVUApp: App {
    var body: some Scene {
        WindowGroup {
            RootTabView()
        }
        .modelContainer(for: [
            Trip.self,
            ItineraryDay.self,
            Place.self,
            RoutePlan.self,
            Expense.self
        ])
    }
}
