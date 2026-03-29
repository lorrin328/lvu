import Foundation
import SwiftData

enum KidAgeGroup: String, Codable, CaseIterable, Identifiable {
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

@Model
final class Trip {
    var id: UUID
    var title: String
    var origin: String
    var destination: String
    var startDate: Date
    var endDate: Date
    var isSelfDrive: Bool
    var withKids: Bool
    var kidAgeGroup: KidAgeGroup
    var budget: Double
    var highlights: [String]
    var routeSummary: String
    @Relationship(deleteRule: .cascade) var itineraryDays: [ItineraryDay]
    @Relationship(deleteRule: .cascade) var places: [Place]
    @Relationship(deleteRule: .cascade) var routes: [RoutePlan]

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
        budget: Double,
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
