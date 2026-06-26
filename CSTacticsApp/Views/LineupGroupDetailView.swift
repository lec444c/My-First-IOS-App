import SwiftUI

struct LineupGroupDetailView: View {
    @EnvironmentObject private var languageManager: LanguageManager
    @EnvironmentObject private var favoriteStore: FavoriteStore

    let group: LineupGroup

    private var isFavorite: Bool {
        favoriteStore.isFavoriteGroup(group)
    }

    var body: some View {
        List {
            Section(L10n.text(.overview, for: languageManager)) {
                detailRow(L10n.text(.name, for: languageManager), group.targetName.value(for: languageManager))
                detailRow(L10n.text(.type, for: languageManager), group.type.displayName(for: languageManager))
                detailRow(L10n.text(.side, for: languageManager), group.side)
                detailRow(L10n.text(.category, for: languageManager), group.category.displayName(for: languageManager))
                detailRow(L10n.text(.lineupVariants, for: languageManager), L10n.text(.variantCount(group.variants.count), for: languageManager))
            }

            Section(L10n.text(.lineupVariants, for: languageManager)) {
                ForEach(group.variants) { variant in
                    NavigationLink {
                        LineupDetailView(group: group, variant: variant)
                    } label: {
                        VariantCard(group: group, variant: variant)
                            .environmentObject(languageManager)
                            .environmentObject(favoriteStore)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(group.targetName.value(for: languageManager))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    favoriteStore.toggleGroup(group)
                } label: {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                }
                .accessibilityLabel(
                    L10n.text(isFavorite ? .removeFavorite : .addFavorite, for: languageManager)
                )
            }
        }
    }

    private func detailRow(_ title: String, _ value: String) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .multilineTextAlignment(.trailing)
        }
    }
}

private struct VariantCard: View {
    @EnvironmentObject private var languageManager: LanguageManager
    @EnvironmentObject private var favoriteStore: FavoriteStore

    let group: LineupGroup
    let variant: LineupVariant

    private var isFavorite: Bool {
        favoriteStore.isFavoriteVariant(variant)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Text(group.type.symbol)
                    .font(.headline)
                    .foregroundStyle(group.type == .flash ? .black : .white)
                    .frame(width: 32, height: 32)
                    .background(group.type.color)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 3) {
                    Text(variant.name.value(for: languageManager))
                        .font(.headline)
                    Text(L10n.text(.variantSubtitle, for: languageManager))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(variant.difficultyDisplayName(for: languageManager))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .accessibilityLabel(L10n.text(.favorites, for: languageManager))
                }
            }

            labeledText(
                title: L10n.text(.spawnRequirement, for: languageManager),
                value: variant.spawnRequirement.value(for: languageManager)
            )
            labeledText(
                title: L10n.text(.throwMethod, for: languageManager),
                value: variant.throwMethod.value(for: languageManager)
            )
        }
        .padding(.vertical, 8)
    }

    private func labeledText(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.subheadline)
        }
    }
}

#Preview {
    NavigationStack {
        LineupGroupDetailView(group: LineupStore.mirageMap.lineupGroups[0])
            .environmentObject(LanguageManager())
            .environmentObject(FavoriteStore())
    }
}
