import SwiftUI

struct MirageDetailView: View {
    @EnvironmentObject private var languageManager: LanguageManager

    var body: some View {
        List {
            Section {
                NavigationLink {
                    TacticalMapView(
                        mapName: L10n.text(.mirage, for: languageManager),
                        groups: LineupStore.mirageLineupGroups
                    )
                } label: {
                    Label(
                        L10n.text(.tacticalMap2D, for: languageManager),
                        systemImage: "map"
                    )
                }

                NavigationLink {
                    UtilityListView(groups: LineupStore.mirageLineupGroups)
                } label: {
                    Label(
                        L10n.text(.utilityList, for: languageManager),
                        systemImage: "list.bullet"
                    )
                }

                NavigationLink {
                    LineupSearchView(groups: LineupStore.mirageLineupGroups)
                } label: {
                    Label(
                        L10n.text(.search, for: languageManager),
                        systemImage: "magnifyingglass"
                    )
                }

                NavigationLink {
                    FavoritesView(groups: LineupStore.mirageLineupGroups)
                } label: {
                    Label(
                        L10n.text(.favorites, for: languageManager),
                        systemImage: "star"
                    )
                }
            } header: {
                Text(L10n.text(.mirage, for: languageManager))
            } footer: {
                Text(L10n.text(.chooseMirageTool, for: languageManager))
            }
        }
        .navigationTitle(L10n.text(.mirage, for: languageManager))
    }
}

#Preview {
    NavigationStack {
        MirageDetailView()
            .environmentObject(LanguageManager())
            .environmentObject(FavoriteStore())
    }
}
