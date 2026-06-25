import SwiftUI

struct MirageDetailView: View {
    @EnvironmentObject private var languageManager: LanguageManager

    var body: some View {
        List {
            Section {
                NavigationLink {
                    TacticalMapView(
                        mapName: "Mirage",
                        lineups: LineupStore.mirageLineups
                    )
                } label: {
                    Label(
                        L10n.text(.tacticalMap, for: languageManager),
                        systemImage: "map"
                    )
                }

                NavigationLink {
                    UtilityListView(lineups: LineupStore.mirageLineups)
                } label: {
                    Label(
                        L10n.text(.utilityList, for: languageManager),
                        systemImage: "list.bullet"
                    )
                }
            } header: {
                Text("Mirage")
            } footer: {
                Text(L10n.text(.chooseMirageTool, for: languageManager))
            }
        }
        .navigationTitle("Mirage")
    }
}

#Preview {
    NavigationStack {
        MirageDetailView()
            .environmentObject(LanguageManager())
    }
}
