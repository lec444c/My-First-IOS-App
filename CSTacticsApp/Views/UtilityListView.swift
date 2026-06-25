import SwiftUI

struct UtilityListView: View {
    @EnvironmentObject private var languageManager: LanguageManager

    let groups: [LineupGroup]

    var body: some View {
        List {
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
                                .padding(.vertical, 2)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(L10n.text(.utilityList, for: languageManager))
    }
}

#Preview {
    NavigationStack {
        UtilityListView(groups: LineupStore.mirageLineupGroups)
            .environmentObject(LanguageManager())
    }
}
