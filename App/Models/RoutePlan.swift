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

    init(
        id: UUID = UUID(),
        fromName: String,
        toName: String,
        durationText: String,
        distanceText: String,
        supportNote: String
    ) {
        self.id = id
        self.fromName = fromName
        self.toName = toName
        self.durationText = durationText
        self.distanceText = distanceText
        self.supportNote = supportNote
    }
}
