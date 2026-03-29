import SwiftUI

struct TripDetailView: View {
    let trip: Trip

    var body: some View {
        List {
            Section(L10n.Trips.overview) {
                LabeledContent(L10n.Common.budget, value: localizedCurrency(trip.budget))
                LabeledContent(L10n.Trips.routePlanning, value: trip.routeSummary)
                LabeledContent(L10n.Common.withKids, value: trip.withKids ? L10n.Trips.kidFriendly : L10n.Common.no)
            }

            Section(L10n.Trips.itinerary) {
                ForEach(trip.highlights, id: \.self) { item in
                    Label(item, systemImage: "checkmark.circle")
                }
            }

            Section(L10n.Trips.places) {
                Label(L10n.Sample.placeDisney, systemImage: "sparkles")
                Label(L10n.Sample.placeRestaurant, systemImage: "fork.knife")
                Label(L10n.Sample.placeParking, systemImage: "parkingsign.circle")
            }

            Section(L10n.Trips.routes) {
                Label(trip.routeSummary, systemImage: "point.topleft.down.curvedto.point.bottomright.up")
            }

            Section(L10n.Trips.expenses) {
                Label(L10n.Sample.receiptDetected, systemImage: "text.viewfinder")
            }
        }
        .navigationTitle(trip.title)
    }
}

#Preview {
    NavigationStack {
        TripDetailView(trip: Trip.samples[0])
    }
}
