import SwiftUI

struct LineupGroupDetailView: View {
    @EnvironmentObject private var languageManager: LanguageManager

    let group: LineupGroup

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
                    }
                }
            }
        }
        .navigationTitle(group.targetName.value(for: languageManager))
        .navigationBarTitleDisplayMode(.inline)
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

    let group: LineupGroup
    let variant: LineupVariant

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
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
                    Text(variant.difficultyDisplayName(for: languageManager))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
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
        .padding(.vertical, 6)
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
        LineupGroupDetailView(group: LineupStore.mirageLineupGroups[0])
            .environmentObject(LanguageManager())
    }
}
