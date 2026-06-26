import SwiftUI

struct UtilityListView: View {
    @EnvironmentObject private var languageManager: LanguageManager

    let groups: [LineupGroup]

    var body: some View {
        List {
            if groups.isEmpty {
                EmptyStateView(
                    systemImage: "tray",
                    title: L10n.text(.emptyUtilities, for: languageManager),
                    message: L10n.text(.emptyUtilitiesMessage, for: languageManager)
                )
            } else {
                ForEach(LineupCategory.allCases, id: \.self) { category in
                    let categoryGroups = groups.filter { group in
                        group.category == category
                    }

                    if !categoryGroups.isEmpty {
                        Section(category.displayName(for: languageManager)) {
                            ForEach(categoryGroups) { group in
                                NavigationLink {
                                    LineupGroupDetailView(group: group)
                                } label: {
                                    UtilityListRow(group: group)
                                        .environmentObject(languageManager)
                                }
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(L10n.text(.utilityList, for: languageManager))
    }
}

private struct UtilityListRow: View {
    @EnvironmentObject private var languageManager: LanguageManager

    let group: LineupGroup

    var body: some View {
        HStack(spacing: 12) {
            Text(group.type.symbol)
                .font(.headline)
                .foregroundStyle(group.type == .flash ? .black : .white)
                .frame(width: 34, height: 34)
                .background(group.type.color)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(group.targetName.value(for: languageManager))
                    .font(.headline)
                Text(group.type.displayName(for: languageManager))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(L10n.text(.variantCount(group.variants.count), for: languageManager))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    NavigationStack {
        UtilityListView(groups: LineupStore.mirageLineupGroups)
            .environmentObject(LanguageManager())
            .environmentObject(FavoriteStore())
    }
}
