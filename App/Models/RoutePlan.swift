import Foundation
import SwiftData

@Model
final class RoutePlan {
    var id: UUID
    var fromName: String
    var toName: String
    var durationText: String
    var distanceText: String
    var supportNote: String
    var fromPlaceID: UUID?
    var toPlaceID: UUID?
    var durationMinutes: Int?
    var distanceKilometers: Double?

    init(
        id: UUID = UUID(),
        fromName: String,
        toName: String,
        durationText: String,
        distanceText: String,
        supportNote: String,
        fromPlaceID: UUID? = nil,
        toPlaceID: UUID? = nil,
        durationMinutes: Int? = nil,
        distanceKilometers: Double? = nil
    ) {
        self.id = id
        self.fromName = fromName
        self.toName = toName
        self.durationText = durationText
        self.distanceText = distanceText
        self.supportNote = supportNote
        self.fromPlaceID = fromPlaceID
        self.toPlaceID = toPlaceID
        self.durationMinutes = durationMinutes ?? Self.parseDurationMinutes(from: durationText)
        self.distanceKilometers = distanceKilometers ?? Self.parseDistanceKilometers(from: distanceText)
    }

    func refreshStructuredFieldsFromLegacyText() {
        durationMinutes = Self.parseDurationMinutes(from: durationText)
        distanceKilometers = Self.parseDistanceKilometers(from: distanceText)
    }

    private static func parseDistanceKilometers(from text: String) -> Double? {
        let pattern = #"\d+(?:\.\d+)?"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        guard let firstMatch = regex.firstMatch(in: text, range: range),
              let numberRange = Range(firstMatch.range, in: text) else {
            return nil
        }
        return Double(String(text[numberRange]))
    }

    private static func parseDurationMinutes(from text: String) -> Int? {
        let lower = text.lowercased()
        let numbers = lower
            .split(whereSeparator: { !$0.isNumber && $0 != "." })
            .compactMap { Int($0) }
        guard !numbers.isEmpty else { return nil }

        let hasHourHint = lower.contains("h") || lower.contains("hour") || lower.contains("小时")
        let hasMinuteHint = lower.contains("m") || lower.contains("min") || lower.contains("分钟") || lower.contains("分")

        if hasHourHint && numbers.count >= 2 {
            return numbers[0] * 60 + numbers[1]
        }
        if hasHourHint && numbers.count == 1 {
            return numbers[0] * 60
        }
        if hasMinuteHint {
            return numbers[0]
        }
        if numbers.count >= 2 {
            return numbers[0] * 60 + numbers[1]
        }
        return numbers[0]
    }
}
