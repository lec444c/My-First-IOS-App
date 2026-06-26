import SwiftUI

struct MirageDetailView: View {
    @EnvironmentObject private var languageManager: LanguageManager

    let map: Map

    var body: some View {
        List {
            Section {
                featureLink(
                    title: L10n.text(.tacticalMap2D, for: languageManager),
                    subtitle: L10n.text(.mapFeatureSubtitle, for: languageManager),
                    systemImage: "map",
                    color: .blue
                ) {
                    TacticalMapView(map: map)
                }

                featureLink(
                    title: L10n.text(.utilityList, for: languageManager),
                    subtitle: L10n.text(.listFeatureSubtitle, for: languageManager),
                    systemImage: "list.bullet",
                    color: .green
                ) {
                    UtilityListView(map: map)
                }

                featureLink(
                    title: L10n.text(.search, for: languageManager),
                    subtitle: L10n.text(.searchFeatureSubtitle, for: languageManager),
                    systemImage: "magnifyingglass",
                    color: .orange
                ) {
                    LineupSearchView(map: map)
                }

                featureLink(
                    title: L10n.text(.favorites, for: languageManager),
                    subtitle: L10n.text(.favoritesFeatureSubtitle, for: languageManager),
                    systemImage: "star",
                    color: .yellow
                ) {
                    FavoritesView(map: map)
                }
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(AppTheme.background)
        .navigationTitle(map.name.value(for: languageManager))
    }

    private func featureLink<Destination: View>(
        title: String,
        subtitle: String,
        systemImage: String,
        color: Color,
        @ViewBuilder destination: () -> Destination
    ) -> some View {
        NavigationLink {
            destination()
        } label: {
            FeatureCard(
                systemImage: systemImage,
                title: title,
                subtitle: subtitle,
                color: color
            )
        }
        .listRowInsets(
            EdgeInsets(
                top: 6,
                leading: AppTheme.pagePadding,
                bottom: 6,
                trailing: AppTheme.pagePadding
            )
        )
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}

#Preview {
    NavigationStack {
        MirageDetailView(map: LineupStore.mirageMap)
            .environmentObject(LanguageManager())
            .environmentObject(FavoriteStore())
    }
}
