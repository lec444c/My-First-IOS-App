import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var languageManager: LanguageManager
    @EnvironmentObject private var favoriteStore: FavoriteStore

    let groups: [LineupGroup]

    private var favoriteGroups: [LineupGroup] {
        favoriteStore.favoriteGroups(in: groups)
    }

    private var favoriteVariants: [FavoriteVariant] {
        favoriteStore.favoriteVariants(in: groups)
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
        .navigationTitle(L10n.text(.favorites, for: languageManager))
    }
}

private struct FavoriteGroupRow: View {
    @EnvironmentObject private var languageManager: LanguageManager

    let group: LineupGroup

    var body: some View {
        HStack(spacing: 12) {
            UtilityBadge(type: group.type)

            VStack(alignment: .leading, spacing: 4) {
                Text(group.targetName.value(for: languageManager))
                    .font(.headline)
                Text(L10n.text(.groupSubtitle, for: languageManager))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(L10n.text(.variantCount(group.variants.count), for: languageManager))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

private struct FavoriteVariantRow: View {
    @EnvironmentObject private var languageManager: LanguageManager

    let item: FavoriteVariant

    var body: some View {
        HStack(spacing: 12) {
            UtilityBadge(type: item.group.type)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.variant.name.value(for: languageManager))
                    .font(.headline)
                Text(item.group.targetName.value(for: languageManager))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(item.variant.startArea.value(for: languageManager))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

private struct UtilityBadge: View {
    let type: UtilityType

    var body: some View {
        Text(type.symbol)
            .font(.headline)
            .foregroundStyle(type == .flash ? .black : .white)
            .frame(width: 34, height: 34)
            .background(type.color)
            .clipShape(Circle())
    }
}

#Preview {
    NavigationStack {
        FavoritesView(groups: LineupStore.mirageLineupGroups)
            .environmentObject(LanguageManager())
            .environmentObject(FavoriteStore())
    }
}
