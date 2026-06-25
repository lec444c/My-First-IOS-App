import SwiftUI

struct MapListView: View {
    @EnvironmentObject private var languageManager: LanguageManager

    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    MirageDetailView()
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(L10n.text(.mirage, for: languageManager))
                            .font(.headline)
                        Text(L10n.text(.lineupCount(LineupStore.mirageLineups.count), for: languageManager))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle(L10n.text(.maps, for: languageManager))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gearshape")
                    }
                    .accessibilityLabel(L10n.text(.settings, for: languageManager))
                }
            }
        }
    }
}

#Preview {
    MapListView()
        .environmentObject(LanguageManager())
}
