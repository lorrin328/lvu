import SwiftUI

struct TripListView: View {
    @State private var trips = Trip.samples
    @State private var showingCreateSheet = false

    var body: some View {
        List {
            Section {
                ForEach(trips) { trip in
                    NavigationLink {
                        TripDetailView(trip: trip)
                    } label: {
                        TripCardView(trip: trip)
                    }
                }
            } header: {
                Text(L10n.Common.upcoming)
            }

            if trips.isEmpty {
                ContentUnavailableView(
                    L10n.Trips.emptyTitle,
                    systemImage: "map",
                    description: Text(L10n.Trips.emptySubtitle)
                )
            }
        }
        .navigationTitle(L10n.Trips.title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(L10n.Trips.create) {
                    showingCreateSheet = true
                }
            }
        }
        .sheet(isPresented: $showingCreateSheet) {
            NavigationStack {
                TripCreateView { trip in
                    trips.insert(trip, at: 0)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TripListView()
    }
}
