import SwiftUI

struct RouteCreateView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var fromName = ""
    @State private var toName = ""
    @State private var distanceText = ""
    @State private var durationText = ""
    @State private var supportNote = ""

    let onSave: (RoutePlan) -> Void

    var body: some View {
        Form {
            Section(L10n.Trips.basicInfo) {
                TextField(L10n.Trips.routeFromField, text: $fromName)
                TextField(L10n.Trips.routeToField, text: $toName)
                TextField(L10n.Trips.routeDistanceField, text: $distanceText)
                TextField(L10n.Trips.routeDurationField, text: $durationText)
            }

            Section(L10n.Trips.planning) {
                TextField(L10n.Trips.routeSupportField, text: $supportNote, axis: .vertical)
                    .lineLimit(3...5)
            }
        }
        .navigationTitle(L10n.Trips.addRoute)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(L10n.Common.cancel) {
                    dismiss()
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(L10n.Trips.save) {
                    let route = RoutePlan(
                        fromName: fromName,
                        toName: toName,
                        durationText: durationText.isEmpty ? L10n.Trips.noData : durationText,
                        distanceText: distanceText.isEmpty ? L10n.Trips.noData : distanceText,
                        supportNote: supportNote.isEmpty ? L10n.Trips.noData : supportNote
                    )
                    route.refreshStructuredFieldsFromLegacyText()
                    onSave(route)
                    dismiss()
                }
                .disabled(fromName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || toName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
}

#Preview {
    NavigationStack {
        RouteCreateView { _ in }
    }
}
