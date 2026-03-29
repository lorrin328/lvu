import Foundation

struct Trip: Identifiable, Hashable {
    let id: UUID
    let title: String
    let destination: String
    let startDate: Date
    let endDate: Date
    let isSelfDrive: Bool
    let withKids: Bool
    let budget: Decimal
    let highlights: [String]
    let routeSummary: String
}

extension Trip {
    static let samples: [Trip] = [
        Trip(
            id: UUID(),
            title: L10n.Sample.tripOneTitle,
            destination: L10n.Sample.tripOneDestination,
            startDate: .now,
            endDate: Calendar.current.date(byAdding: .day, value: 2, to: .now) ?? .now,
            isSelfDrive: false,
            withKids: true,
            budget: 3200,
            highlights: [
                L10n.Sample.tripOneHighlightOne,
                L10n.Sample.tripOneHighlightTwo,
                L10n.Sample.tripOneHighlightThree
            ],
            routeSummary: L10n.Sample.tripOneRoute
        ),
        Trip(
            id: UUID(),
            title: L10n.Sample.tripTwoTitle,
            destination: L10n.Sample.tripTwoDestination,
            startDate: Calendar.current.date(byAdding: .day, value: 7, to: .now) ?? .now,
            endDate: Calendar.current.date(byAdding: .day, value: 9, to: .now) ?? .now,
            isSelfDrive: true,
            withKids: true,
            budget: 4500,
            highlights: [
                L10n.Sample.tripTwoHighlightOne,
                L10n.Sample.tripTwoHighlightTwo,
                L10n.Sample.tripTwoHighlightThree
            ],
            routeSummary: L10n.Sample.tripTwoRoute
        )
    ]
}
