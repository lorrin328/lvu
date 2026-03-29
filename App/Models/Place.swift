import Foundation
import SwiftData

enum PlaceKind: String, Codable, CaseIterable, Identifiable {
    case attraction
    case restaurant
    case hotel
    case gasStation
    case parking
    case restArea
    case other

    var id: String { rawValue }

    var localizedName: String {
        String(localized: "place.kind.\(rawValue)")
    }
}

@Model
final class Place {
    var id: UUID
    var name: String
    var kind: PlaceKind
    var address: String
    var kidFriendly: Bool
    var notes: String

    init(
        id: UUID = UUID(),
        name: String,
        kind: PlaceKind,
        address: String,
        kidFriendly: Bool,
        notes: String
    ) {
        self.id = id
        self.name = name
        self.kind = kind
        self.address = address
        self.kidFriendly = kidFriendly
        self.notes = notes
    }
}
