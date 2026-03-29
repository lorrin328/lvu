import Foundation

struct ItineraryDay: Identifiable, Hashable {
    let id: UUID
    let dayNumber: Int
    let date: Date
    let summary: String
    let notes: String
}

extension ItineraryDay {
    static let tripOneSamples: [ItineraryDay] = [
        ItineraryDay(
            id: UUID(),
            dayNumber: 1,
            date: .now,
            summary: L10n.Sample.itineraryOneDayOneSummary,
            notes: L10n.Sample.itineraryOneDayOneNotes
        ),
        ItineraryDay(
            id: UUID(),
            dayNumber: 2,
            date: Calendar.current.date(byAdding: .day, value: 1, to: .now) ?? .now,
            summary: L10n.Sample.itineraryOneDayTwoSummary,
            notes: L10n.Sample.itineraryOneDayTwoNotes
        )
    ]

    static let tripTwoSamples: [ItineraryDay] = [
        ItineraryDay(
            id: UUID(),
            dayNumber: 1,
            date: Calendar.current.date(byAdding: .day, value: 7, to: .now) ?? .now,
            summary: L10n.Sample.itineraryTwoDayOneSummary,
            notes: L10n.Sample.itineraryTwoDayOneNotes
        ),
        ItineraryDay(
            id: UUID(),
            dayNumber: 2,
            date: Calendar.current.date(byAdding: .day, value: 8, to: .now) ?? .now,
            summary: L10n.Sample.itineraryTwoDayTwoSummary,
            notes: L10n.Sample.itineraryTwoDayTwoNotes
        )
    ]
}
