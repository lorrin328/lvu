import SwiftUI

struct TripListView: View {
    private let trips = Trip.samples

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
