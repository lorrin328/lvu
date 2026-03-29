import Foundation
import SwiftData

enum SampleDataSeeder {
    @MainActor
    static func seedIfNeeded(in context: ModelContext) throws {
        let tripDescriptor = FetchDescriptor<Trip>()
        let tripCount = try context.fetchCount(tripDescriptor)

        if tripCount == 0 {
            for trip in sampleTrips() {
                context.insert(trip)
            }
        }

        let expenseDescriptor = FetchDescriptor<Expense>()
        let expenseCount = try context.fetchCount(expenseDescriptor)

        if expenseCount == 0 {
            for expense in sampleExpenses() {
                context.insert(expense)
            }
        }
    }

    static func sampleTrips() -> [Trip] {
        [
            Trip(
                title: L10n.Sample.tripOneTitle,
                origin: L10n.Sample.tripOneOrigin,
                destination: L10n.Sample.tripOneDestination,
                startDate: .now,
                endDate: Calendar.current.date(byAdding: .day, value: 2, to: .now) ?? .now,
                isSelfDrive: false,
                withKids: true,
                kidAgeGroup: .preschool,
                budget: 3200,
                highlights: [
                    L10n.Sample.tripOneHighlightOne,
                    L10n.Sample.tripOneHighlightTwo,
                    L10n.Sample.tripOneHighlightThree
                ],
                routeSummary: L10n.Sample.tripOneRoute,
                itineraryDays: [
                    ItineraryDay(
                        dayNumber: 1,
                        date: .now,
                        summary: L10n.Sample.itineraryOneDayOneSummary,
                        notes: L10n.Sample.itineraryOneDayOneNotes
                    ),
                    ItineraryDay(
                        dayNumber: 2,
                        date: Calendar.current.date(byAdding: .day, value: 1, to: .now) ?? .now,
                        summary: L10n.Sample.itineraryOneDayTwoSummary,
                        notes: L10n.Sample.itineraryOneDayTwoNotes
                    )
                ],
                places: [
                    Place(
                        name: L10n.Sample.placeDisney,
                        kind: .attraction,
                        address: L10n.Sample.placeDisneyAddress,
                        kidFriendly: true,
                        notes: L10n.Sample.placeDisneyNotes
                    ),
                    Place(
                        name: L10n.Sample.placeRestaurant,
                        kind: .restaurant,
                        address: L10n.Sample.placeRestaurantAddress,
                        kidFriendly: true,
                        notes: L10n.Sample.placeRestaurantNotes
                    )
                ],
                routes: [
                    RoutePlan(
                        fromName: L10n.Sample.tripOneOrigin,
                        toName: L10n.Sample.placeDisney,
                        durationText: L10n.Sample.routeOneDuration,
                        distanceText: L10n.Sample.routeOneDistance,
                        supportNote: L10n.Sample.routeOneSupport
                    )
                ]
            ),
            Trip(
                title: L10n.Sample.tripTwoTitle,
                origin: L10n.Sample.tripTwoOrigin,
                destination: L10n.Sample.tripTwoDestination,
                startDate: Calendar.current.date(byAdding: .day, value: 7, to: .now) ?? .now,
                endDate: Calendar.current.date(byAdding: .day, value: 9, to: .now) ?? .now,
                isSelfDrive: true,
                withKids: true,
                kidAgeGroup: .schoolAge,
                budget: 4500,
                highlights: [
                    L10n.Sample.tripTwoHighlightOne,
                    L10n.Sample.tripTwoHighlightTwo,
                    L10n.Sample.tripTwoHighlightThree
                ],
                routeSummary: L10n.Sample.tripTwoRoute,
                itineraryDays: [
                    ItineraryDay(
                        dayNumber: 1,
                        date: Calendar.current.date(byAdding: .day, value: 7, to: .now) ?? .now,
                        summary: L10n.Sample.itineraryTwoDayOneSummary,
                        notes: L10n.Sample.itineraryTwoDayOneNotes
                    ),
                    ItineraryDay(
                        dayNumber: 2,
                        date: Calendar.current.date(byAdding: .day, value: 8, to: .now) ?? .now,
                        summary: L10n.Sample.itineraryTwoDayTwoSummary,
                        notes: L10n.Sample.itineraryTwoDayTwoNotes
                    )
                ],
                places: [
                    Place(
                        name: L10n.Sample.tripTwoHighlightTwo,
                        kind: .attraction,
                        address: L10n.Sample.placeOceanAddress,
                        kidFriendly: true,
                        notes: L10n.Sample.placeOceanNotes
                    ),
                    Place(
                        name: L10n.Sample.placeParking,
                        kind: .parking,
                        address: L10n.Sample.placeParkingAddress,
                        kidFriendly: false,
                        notes: L10n.Sample.placeParkingNotes
                    )
                ],
                routes: [
                    RoutePlan(
                        fromName: L10n.Sample.tripTwoOrigin,
                        toName: L10n.Sample.tripTwoHighlightTwo,
                        durationText: L10n.Sample.routeTwoDuration,
                        distanceText: L10n.Sample.routeTwoDistance,
                        supportNote: L10n.Sample.routeTwoSupport
                    )
                ]
            )
        ]
    }

    static func sampleExpenses() -> [Expense] {
        [
            Expense(
                merchantName: L10n.Sample.expenseOneMerchant,
                amount: 168,
                category: .dining,
                location: L10n.Sample.expenseOneLocation,
                date: .now,
                receiptDetected: true
            ),
            Expense(
                merchantName: L10n.Sample.expenseTwoMerchant,
                amount: 380,
                category: .transport,
                location: L10n.Sample.expenseTwoLocation,
                date: Calendar.current.date(byAdding: .day, value: -1, to: .now) ?? .now,
                receiptDetected: false
            )
        ]
    }
}
