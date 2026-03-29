import SwiftUI

struct PlaceCreateView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var kind: PlaceKind = .attraction
    @State private var address = ""
    @State private var kidFriendly = true
    @State private var notes = ""

    let onSave: (Place) -> Void

    var body: some View {
        Form {
            Section(L10n.Trips.basicInfo) {
                TextField(L10n.Trips.placeNameField, text: $name)
                Picker(L10n.Trips.placeTypeField, selection: $kind) {
                    ForEach(PlaceKind.allCases) { item in
                        Text(item.localizedName).tag(item)
                    }
                }
                TextField(L10n.Trips.placeAddressField, text: $address)
            }

            Section(L10n.Trips.planning) {
                Toggle(L10n.Trips.kidFriendlyToggle, isOn: $kidFriendly)
                TextField(L10n.Trips.placeNotesField, text: $notes, axis: .vertical)
                    .lineLimit(3...5)
            }
        }
        .navigationTitle(L10n.Trips.addPlace)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(L10n.Common.cancel) {
                    dismiss()
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(L10n.Trips.save) {
                    onSave(
                        Place(
                            name: name,
                            kind: kind,
                            address: address.isEmpty ? L10n.Trips.noData : address,
                            kidFriendly: kidFriendly,
                            notes: notes.isEmpty ? L10n.Trips.noData : notes
                        )
                    )
                    dismiss()
                }
                .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
}

#Preview {
    NavigationStack {
        PlaceCreateView { _ in }
    }
}
