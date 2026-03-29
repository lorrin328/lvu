import SwiftUI
import SwiftData

struct RouteEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var route: RoutePlan

    var body: some View {
        Form {
            Section(L10n.Trips.basicInfo) {
                TextField(L10n.Trips.routeFromField, text: $route.fromName)
                TextField(L10n.Trips.routeToField, text: $route.toName)
                TextField(L10n.Trips.routeDistanceField, text: $route.distanceText)
                TextField(L10n.Trips.routeDurationField, text: $route.durationText)
            }

            Section(L10n.Trips.planning) {
                TextField(L10n.Trips.routeSupportField, text: $route.supportNote, axis: .vertical)
                    .lineLimit(3...5)
            }
        }
        .navigationTitle(L10n.Trips.editRoute)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(L10n.Common.cancel) {
                    dismiss()
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(L10n.Trips.save) {
                    route.durationText = route.durationText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? L10n.Trips.noData : route.durationText
                    route.distanceText = route.distanceText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? L10n.Trips.noData : route.distanceText
                    route.supportNote = route.supportNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? L10n.Trips.noData : route.supportNote
                    route.refreshStructuredFieldsFromLegacyText()
                    dismiss()
                }
                .disabled(
                    route.fromName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                    route.toName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                )
            }
        }
    }
}

#Preview {
    NavigationStack {
        RouteEditView(
            route: RoutePlan(
                fromName: "A",
                toName: "B",
                durationText: "2h",
                distanceText: "120 km",
                supportNote: "Sample note"
            )
        )
    }
}
