import Foundation

struct Trip: Identifiable, Hashable {
    let id: UUID
    let title: String
    let origin: String
    let destination: String
    let startDate: Date
    let endDate: Date
    let isSelfDrive: Bool
    let withKids: Bool
    let kidAgeGroup: KidAgeGroup
    let budget: Decimal
    let highlights: [String]
    let routeSummary: String
    let itineraryDays: [ItineraryDay]
    let places: [Place]
    let routes: [RoutePlan]
}

enum KidAgeGroup: String, CaseIterable, Identifiable, Hashable {
    case infant
    case toddler
    case preschool
    case schoolAge
    case teen
    case mixed

    var id: String { rawValue }

    var localizedName: String {
        String(localized: "trip.kid_age.\(rawValue)")
    }
}

extension Trip {
    init(
        id: UUID = UUID(),
        title: String,
        origin: String,
        destination: String,
        startDate: Date,
        endDate: Date,
        isSelfDrive: Bool,
        withKids: Bool,
        kidAgeGroup: KidAgeGroup,
        budget: Decimal,
        highlights: [String],
        routeSummary: String,
        itineraryDays: [ItineraryDay] = [],
        places: [Place] = [],
        routes: [RoutePlan] = []
    ) {
        self.id = id
        self.title = title
        self.origin = origin
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
        self.isSelfDrive = isSelfDrive
        self.withKids = withKids
        self.kidAgeGroup = kidAgeGroup
        self.budget = budget
        self.highlights = highlights
        self.routeSummary = routeSummary
        self.itineraryDays = itineraryDays
        self.places = places
        self.routes = routes
    }
}

extension Trip {
    static let samples: [Trip] = [
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
            itineraryDays: ItineraryDay.tripOneSamples,
            places: Place.tripOneSamples,
            routes: RoutePlan.tripOneSamples
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
            itineraryDays: ItineraryDay.tripTwoSamples,
            places: Place.tripTwoSamples,
            routes: RoutePlan.tripTwoSamples
        )
    ]
}
