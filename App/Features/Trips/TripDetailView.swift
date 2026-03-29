import SwiftUI
import SwiftData

struct TripDetailView: View {
    @Bindable var trip: Trip
    @State private var showingDaySheet = false
    @State private var showingPlaceSheet = false
    @State private var showingRouteSheet = false

    var body: some View {
        List {
            Section(L10n.Trips.overview) {
                LabeledContent(L10n.Trips.fromTo, value: "\(trip.origin) -> \(trip.destination)")
                LabeledContent(L10n.Common.budget, value: localizedCurrency(trip.budget))
                LabeledContent(L10n.Trips.routePlanning, value: trip.routeSummary)
                LabeledContent(L10n.Common.withKids, value: trip.withKids ? L10n.Trips.kidFriendly : L10n.Common.no)
                LabeledContent(L10n.Trips.kidAgeGroup, value: trip.kidAgeGroup.localizedName)
            }

            Section(L10n.Trips.itinerary) {
                ForEach(trip.itineraryDays.sorted { $0.dayNumber < $1.dayNumber }) { day in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(L10n.Trips.dayTitle) \(day.dayNumber)")
                            .font(.headline)
                        Text(day.summary)
                        Text(day.notes)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Section(L10n.Trips.places) {
                ForEach(trip.places) { place in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(place.name)
                            .font(.headline)
                        Text(place.kind.localizedName)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(place.address)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Section(L10n.Trips.routes) {
                ForEach(trip.routes) { route in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(route.fromName) -> \(route.toName)")
                            .font(.headline)
                        Text("\(route.distanceText) · \(route.durationText)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(route.supportNote)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Section(L10n.Trips.expenses) {
                Label(L10n.Sample.receiptDetected, systemImage: "text.viewfinder")
            }
        }
        .navigationTitle(trip.title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button(L10n.Trips.addDay) {
                        showingDaySheet = true
                    }
                    Button(L10n.Trips.addPlace) {
                        showingPlaceSheet = true
                    }
                    Button(L10n.Trips.addRoute) {
                        showingRouteSheet = true
                    }
                } label: {
                    Image(systemName: "plus.circle")
                }
            }
        }
        .sheet(isPresented: $showingDaySheet) {
            NavigationStack {
                ItineraryDayCreateView { day in
                    trip.itineraryDays.append(day)
                }
            }
        }
        .sheet(isPresented: $showingPlaceSheet) {
            NavigationStack {
                PlaceCreateView { place in
                    trip.places.append(place)
                }
            }
        }
        .sheet(isPresented: $showingRouteSheet) {
            NavigationStack {
                RouteCreateView { route in
                    trip.routes.append(route)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TripDetailView(trip: SampleDataSeeder.sampleTrips()[0])
    }
    .modelContainer(for: [Trip.self, ItineraryDay.self, Place.self, RoutePlan.self, Expense.self], inMemory: true)
}
