import SwiftUI
import SwiftData

struct TripDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var trip: Trip
    @State private var showingDaySheet = false
    @State private var showingPlaceSheet = false
    @State private var showingRouteSheet = false
    @State private var editingRoute: RoutePlan?
    @State private var routePendingDeletion: RoutePlan?
    
    private var sortedTripExpenses: [Expense] {
        trip.expenses.sorted { $0.date > $1.date }
    }
    
    private var totalExpenseAmount: Double {
        ExpenseDomain.summarizeByDay(
            expenses: sortedTripExpenses,
            itineraryDays: trip.itineraryDays,
            dayTitlePrefix: L10n.Trips.dayTitle,
            unassignedTitle: L10n.Expenses.unassignedDay
        ).total
    }
    
    private var expenseByDay: [ExpenseDaySummary] {
        ExpenseDomain.summarizeByDay(
            expenses: sortedTripExpenses,
            itineraryDays: trip.itineraryDays,
            dayTitlePrefix: L10n.Trips.dayTitle,
            unassignedTitle: L10n.Expenses.unassignedDay
        ).daySummaries
    }

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
                    .swipeActions {
                        Button(L10n.Trips.editRoute) {
                            editingRoute = route
                        }
                        
                        Button(L10n.Trips.deleteRoute, role: .destructive) {
                            routePendingDeletion = route
                        }
                    }
                }
            }

            Section(L10n.Trips.expenses) {
                if trip.expenses.isEmpty {
                    Text(L10n.Expenses.emptySubtitle)
                        .foregroundStyle(.secondary)
                } else {
                    LabeledContent(L10n.Expenses.totalAmount, value: localizedCurrency(totalExpenseAmount))
                    
                    ForEach(expenseByDay) { item in
                        LabeledContent(item.title, value: localizedCurrency(item.amount))
                    }
                    
                    ForEach(sortedTripExpenses) { expense in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(expense.merchantName)
                                    .font(.headline)
                                Spacer()
                                Text(localizedCurrency(expense.amount))
                                    .font(.subheadline.weight(.semibold))
                            }
                            Text("\(expense.category.localizedName) · \(expense.location)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text(LVUFormatters.expenseDate.string(from: expense.date))
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
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
        .sheet(item: $editingRoute) { route in
            NavigationStack {
                RouteEditView(route: route)
            }
        }
        .alert(
            L10n.Trips.deleteRouteTitle,
            isPresented: Binding(
                get: { routePendingDeletion != nil },
                set: { newValue in
                    if !newValue {
                        routePendingDeletion = nil
                    }
                }
            )
        ) {
            Button(L10n.Common.cancel, role: .cancel) {
                routePendingDeletion = nil
            }
            Button(L10n.Trips.delete, role: .destructive) {
                guard let routePendingDeletion else { return }
                trip.routes.removeAll(where: { $0.id == routePendingDeletion.id })
                modelContext.delete(routePendingDeletion)
                self.routePendingDeletion = nil
            }
        } message: {
            Text(L10n.Trips.deleteRouteMessage)
        }
    }
}

#Preview {
    NavigationStack {
        TripDetailView(trip: SampleDataSeeder.sampleTrips()[0])
    }
    .modelContainer(for: [Trip.self, ItineraryDay.self, Place.self, RoutePlan.self, Expense.self], inMemory: true)
}
