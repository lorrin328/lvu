import XCTest
@testable import LVU

final class ModelAndParserTests: XCTestCase {
    func testPlaceholderReceiptParserExtractsMerchantAndAmount() {
        let parser = PlaceholderReceiptParser()
        let rawText = """
        Little Panda Cafe
        Shanghai Disneyland
        Total: 168.50
        """

        let draft = parser.parse(rawText: rawText, occurredAt: Date(timeIntervalSince1970: 0))

        XCTAssertEqual(draft.merchantName, "Little Panda Cafe")
        XCTAssertNotNil(draft.amount)
        XCTAssertEqual(draft.amount ?? 0, 168.50, accuracy: 0.001)
        XCTAssertGreaterThan(draft.confidence, 0.5)
    }

    func testRoutePlanRefreshStructuredFieldsFromLegacyText() {
        let route = RoutePlan(
            fromName: "A",
            toName: "B",
            durationText: "2h 10m",
            distanceText: "140 km",
            supportNote: "test"
        )

        route.refreshStructuredFieldsFromLegacyText()

        XCTAssertEqual(route.durationMinutes, 130)
        XCTAssertNotNil(route.distanceKilometers)
        XCTAssertEqual(route.distanceKilometers ?? 0, 140, accuracy: 0.001)
    }
}
