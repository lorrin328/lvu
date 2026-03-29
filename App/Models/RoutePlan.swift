import Foundation

struct RoutePlan: Identifiable, Hashable {
    let id: UUID
    let fromName: String
    let toName: String
    let durationText: String
    let distanceText: String
    let supportNote: String
}

extension RoutePlan {
    static let tripOneSamples: [RoutePlan] = [
        RoutePlan(
            id: UUID(),
            fromName: L10n.Sample.tripOneOrigin,
            toName: L10n.Sample.placeDisney,
            durationText: L10n.Sample.routeOneDuration,
            distanceText: L10n.Sample.routeOneDistance,
            supportNote: L10n.Sample.routeOneSupport
        )
    ]

    static let tripTwoSamples: [RoutePlan] = [
        RoutePlan(
            id: UUID(),
            fromName: L10n.Sample.tripTwoOrigin,
            toName: L10n.Sample.tripTwoHighlightTwo,
            durationText: L10n.Sample.routeTwoDuration,
            distanceText: L10n.Sample.routeTwoDistance,
            supportNote: L10n.Sample.routeTwoSupport
        )
    ]
}
