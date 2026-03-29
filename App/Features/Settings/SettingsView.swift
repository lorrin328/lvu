import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section(L10n.Settings.language) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(L10n.Settings.localizationReady)
                        .font(.headline)
                    Text(L10n.Settings.languageHint)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            Section(L10n.Settings.roadmap) {
                Label(L10n.Settings.stringResource, systemImage: "textformat")
                Label(L10n.Settings.languagePair, systemImage: "globe")
                Label(L10n.Settings.systemLanguage, systemImage: "iphone")
            }
        }
        .navigationTitle(L10n.Settings.title)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
