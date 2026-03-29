import Foundation

enum L10n {
    enum Tab {
        static let trips = String(localized: "tab.trips")
        static let expenses = String(localized: "tab.expenses")
        static let settings = String(localized: "tab.settings")
    }

    enum Common {
        static let appName = String(localized: "common.app_name")
        static let budget = String(localized: "common.budget")
        static let notes = String(localized: "common.notes")
        static let withKids = String(localized: "common.with_kids")
        static let selfDrive = String(localized: "common.self_drive")
        static let transit = String(localized: "common.transit")
        static let yes = String(localized: "common.yes")
        static let no = String(localized: "common.no")
        static let upcoming = String(localized: "common.upcoming")
        static let today = String(localized: "common.today")
        static let sample = String(localized: "common.sample")
    }

    enum Trips {
        static let title = String(localized: "trips.title")
        static let create = String(localized: "trips.create")
        static let emptyTitle = String(localized: "trips.empty_title")
        static let emptySubtitle = String(localized: "trips.empty_subtitle")
        static let overview = String(localized: "trips.overview")
        static let itinerary = String(localized: "trips.itinerary")
        static let places = String(localized: "trips.places")
        static let routes = String(localized: "trips.routes")
        static let expenses = String(localized: "trips.expenses")
        static let kidFriendly = String(localized: "trips.kid_friendly")
        static let routePlanning = String(localized: "trips.route_planning")
    }

    enum Expenses {
        static let title = String(localized: "expenses.title")
        static let capture = String(localized: "expenses.capture")
        static let emptyTitle = String(localized: "expenses.empty_title")
        static let emptySubtitle = String(localized: "expenses.empty_subtitle")
        static let merchant = String(localized: "expenses.merchant")
        static let amount = String(localized: "expenses.amount")
        static let category = String(localized: "expenses.category")
        static let location = String(localized: "expenses.location")
        static let receiptHint = String(localized: "expenses.receipt_hint")
    }

    enum Settings {
        static let title = String(localized: "settings.title")
        static let language = String(localized: "settings.language")
        static let languageHint = String(localized: "settings.language_hint")
        static let localizationReady = String(localized: "settings.localization_ready")
        static let roadmap = String(localized: "settings.roadmap")
        static let stringResource = String(localized: "settings.string_resource")
        static let languagePair = String(localized: "settings.language_pair")
        static let systemLanguage = String(localized: "settings.system_language")
    }

    enum Sample {
        static let tripOneTitle = String(localized: "sample.trip_one_title")
        static let tripOneDestination = String(localized: "sample.trip_one_destination")
        static let tripOneHighlightOne = String(localized: "sample.trip_one_highlight_one")
        static let tripOneHighlightTwo = String(localized: "sample.trip_one_highlight_two")
        static let tripOneHighlightThree = String(localized: "sample.trip_one_highlight_three")
        static let tripOneRoute = String(localized: "sample.trip_one_route")
        static let tripTwoTitle = String(localized: "sample.trip_two_title")
        static let tripTwoDestination = String(localized: "sample.trip_two_destination")
        static let tripTwoHighlightOne = String(localized: "sample.trip_two_highlight_one")
        static let tripTwoHighlightTwo = String(localized: "sample.trip_two_highlight_two")
        static let tripTwoHighlightThree = String(localized: "sample.trip_two_highlight_three")
        static let tripTwoRoute = String(localized: "sample.trip_two_route")
        static let expenseOneMerchant = String(localized: "sample.expense_one_merchant")
        static let expenseOneLocation = String(localized: "sample.expense_one_location")
        static let expenseTwoMerchant = String(localized: "sample.expense_two_merchant")
        static let expenseTwoLocation = String(localized: "sample.expense_two_location")
        static let placeDisney = String(localized: "sample.place_disney")
        static let placeRestaurant = String(localized: "sample.place_restaurant")
        static let placeParking = String(localized: "sample.place_parking")
        static let receiptDetected = String(localized: "sample.receipt_detected")
    }
}
