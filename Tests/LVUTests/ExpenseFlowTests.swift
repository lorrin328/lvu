import XCTest
@testable import LVU

final class ExpenseFlowTests: XCTestCase {
    func testExpenseCanLinkToTripAndDay() {
        let day = ItineraryDay(dayNumber: 1, date: .now, summary: "d1", notes: "n1")
        let trip = makeTrip(days: [day])
        let expense = Expense(
            merchantName: "Cafe",
            amount: 88,
            category: .dining,
            location: "Center",
            date: .now,
            receiptDetected: false,
            trip: trip,
            itineraryDay: day
        )

        XCTAssertEqual(expense.trip?.id, trip.id)
        XCTAssertEqual(expense.itineraryDay?.id, day.id)
    }

    func testExpenseDomainFilterByTripAndDay() {
        let day1 = ItineraryDay(dayNumber: 1, date: .now, summary: "d1", notes: "n1")
        let day2 = ItineraryDay(dayNumber: 2, date: .now, summary: "d2", notes: "n2")
        let trip1 = makeTrip(title: "T1", days: [day1, day2])
        let trip2 = makeTrip(title: "T2", days: [])

        let e1 = Expense(merchantName: "A", amount: 10, category: .dining, location: "L", date: .now, receiptDetected: false, trip: trip1, itineraryDay: day1)
        let e2 = Expense(merchantName: "B", amount: 20, category: .transport, location: "L", date: .now, receiptDetected: false, trip: trip1, itineraryDay: day2)
        let e3 = Expense(merchantName: "C", amount: 30, category: .hotel, location: "L", date: .now, receiptDetected: false, trip: trip2, itineraryDay: nil)
        let all = [e1, e2, e3]

        let tripFiltered = ExpenseDomain.filter(expenses: all, tripID: trip1.id, dayID: nil)
        XCTAssertEqual(tripFiltered.count, 2)

        let dayFiltered = ExpenseDomain.filter(expenses: all, tripID: trip1.id, dayID: day2.id)
        XCTAssertEqual(dayFiltered.count, 1)
        XCTAssertEqual(dayFiltered.first?.merchantName, "B")
    }

    func testExpenseDomainSummarizeByDayIncludesUnassigned() {
        let day1 = ItineraryDay(dayNumber: 1, date: .now, summary: "d1", notes: "n1")
        let day2 = ItineraryDay(dayNumber: 2, date: .now, summary: "d2", notes: "n2")
        let trip = makeTrip(days: [day1, day2])

        let e1 = Expense(merchantName: "A", amount: 100, category: .dining, location: "L", date: .now, receiptDetected: false, trip: trip, itineraryDay: day1)
        let e2 = Expense(merchantName: "B", amount: 200, category: .transport, location: "L", date: .now, receiptDetected: false, trip: trip, itineraryDay: day2)
        let e3 = Expense(merchantName: "C", amount: 50, category: .other, location: "L", date: .now, receiptDetected: false, trip: trip, itineraryDay: nil)

        let result = ExpenseDomain.summarizeByDay(
            expenses: [e1, e2, e3],
            itineraryDays: trip.itineraryDays,
            dayTitlePrefix: "Day",
            unassignedTitle: "Unassigned"
        )

        XCTAssertEqual(result.total, 350, accuracy: 0.001)
        XCTAssertEqual(result.daySummaries.count, 3)
        XCTAssertTrue(result.daySummaries.contains(where: { $0.title == "Day 1" && abs($0.amount - 100) < 0.001 }))
        XCTAssertTrue(result.daySummaries.contains(where: { $0.title == "Day 2" && abs($0.amount - 200) < 0.001 }))
        XCTAssertTrue(result.daySummaries.contains(where: { $0.title == "Unassigned" && abs($0.amount - 50) < 0.001 }))
    }

    private func makeTrip(title: String = "Trip", days: [ItineraryDay]) -> Trip {
        Trip(
            title: title,
            origin: "A",
            destination: "B",
            startDate: .now,
            endDate: .now,
            isSelfDrive: false,
            withKids: false,
            kidAgeGroup: .mixed,
            budget: 1000,
            highlights: [],
            routeSummary: "r",
            itineraryDays: days
        )
    }
}
