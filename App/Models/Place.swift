import Foundation

struct Place: Identifiable, Hashable {
    enum Kind: String, CaseIterable, Identifiable, Hashable {
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

    let id: UUID
    let name: String
    let kind: Kind
    let address: String
    let kidFriendly: Bool
    let notes: String
}

extension Place {
    static let tripOneSamples: [Place] = [
        Place(
            id: UUID(),
            name: L10n.Sample.placeDisney,
            kind: .attraction,
            address: L10n.Sample.placeDisneyAddress,
            kidFriendly: true,
            notes: L10n.Sample.placeDisneyNotes
        ),
        Place(
            id: UUID(),
            name: L10n.Sample.placeRestaurant,
            kind: .restaurant,
            address: L10n.Sample.placeRestaurantAddress,
            kidFriendly: true,
            notes: L10n.Sample.placeRestaurantNotes
        )
    ]

    static let tripTwoSamples: [Place] = [
        Place(
            id: UUID(),
            name: L10n.Sample.tripTwoHighlightTwo,
            kind: .attraction,
            address: L10n.Sample.placeOceanAddress,
            kidFriendly: true,
            notes: L10n.Sample.placeOceanNotes
        ),
        Place(
            id: UUID(),
            name: L10n.Sample.placeParking,
            kind: .parking,
            address: L10n.Sample.placeParkingAddress,
            kidFriendly: false,
            notes: L10n.Sample.placeParkingNotes
        )
    ]
}
