import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var languageManager: LanguageManager
    @EnvironmentObject private var favoriteStore: FavoriteStore

    let map: Map

    private var favoriteGroups: [LineupGroup] {
        favoriteStore.favoriteGroups(in: map)
    }

    private var favoriteVariants: [FavoriteVariant] {
        favoriteStore.favoriteVariants(in: map)
    }

    private var hasFavorites: Bool {
        !favoriteGroups.isEmpty || !favoriteVariants.isEmpty
    }

    var body: some View {
        List {
            if hasFavorites {
                if !favoriteGroups.isEmpty {
                    Section(L10n.text(.favoriteGroups, for: languageManager)) {
                        ForEach(favoriteGroups) { group in
                            NavigationLink {
                                LineupGroupDetailView(group: group)
                            } label: {
                                FavoriteGroupRow(group: group)
                                    .environmentObject(languageManager)
                            }
                        }
                    }
                }

                if !favoriteVariants.isEmpty {
                    Section(L10n.text(.favoriteVariants, for: languageManager)) {
                        ForEach(favoriteVariants) { item in
                            NavigationLink {
                                LineupDetailView(group: item.group, variant: item.variant)
                            } label: {
                                FavoriteVariantRow(item: item)
                                    .environmentObject(languageManager)
                            }
                        }
                    }
                }
            } else {
                EmptyStateView(
                    systemImage: "star",
                    title: L10n.text(.emptyFavorites, for: languageManager),
                    message: L10n.text(.emptyFavoritesMessage, for: languageManager)
                )
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(AppTheme.background)
        .navigationTitle(L10n.text(.favorites, for: languageManager))
    }
}

private struct FavoriteGroupRow: View {
    @EnvironmentObject private var languageManager: LanguageManager

    let group: LineupGroup

    var body: some View {
        HStack(spacing: 12) {
            MapMarkerView(type: group.type, markerSize: 32)

            VStack(alignment: .leading, spacing: 4) {
                Text(group.targetName.value(for: languageManager))
                    .font(.headline)
                Text(L10n.text(.groupSubtitle, for: languageManager))
                    .font(.subheadline)
                    .foregroundStyle(AppTheme.secondaryText)
                Text(L10n.text(.variantCount(group.variants.count), for: languageManager))
                    .font(.caption)
                    .foregroundStyle(AppTheme.secondaryText)
            }
        }
        .padding(.vertical, AppTheme.smallCornerRadius - 6)
    }
}

private struct FavoriteVariantRow: View {
    @EnvironmentObject private var languageManager: LanguageManager

    let item: FavoriteVariant

    var body: some View {
        HStack(spacing: 12) {
            MapMarkerView(type: item.group.type, markerSize: 32)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.variant.name.value(for: languageManager))
                    .font(.headline)
                Text(item.group.targetName.value(for: languageManager))
                    .font(.subheadline)
                    .foregroundStyle(AppTheme.secondaryText)
                Text(item.variant.startArea.value(for: languageManager))
                    .font(.caption)
                    .foregroundStyle(AppTheme.secondaryText)
            }
        }
        .padding(.vertical, AppTheme.smallCornerRadius - 6)
    }
}

#Preview {
    NavigationStack {
        FavoritesView(map: LineupStore.mirageMap)
            .environmentObject(LanguageManager())
            .environmentObject(FavoriteStore())
    }
}
