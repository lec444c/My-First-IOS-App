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
            footer: {
                Text(L10n.text(.chooseMirageTool, for: languageManager))
            }
        }
        .listStyle(.insetGrouped)
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
            FeatureEntryRow(
                title: title,
                subtitle: subtitle,
                systemImage: systemImage,
                color: color
            )
        }
    }
}

private struct FeatureEntryRow: View {
    let title: String
    let subtitle: String
    let systemImage: String
    let color: Color

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: systemImage)
                .font(.headline)
                .foregroundStyle(.white)
                .frame(width: 40, height: 40)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    NavigationStack {
        MirageDetailView(map: LineupStore.mirageMap)
            .environmentObject(LanguageManager())
            .environmentObject(FavoriteStore())
    }
}
