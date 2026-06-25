import SwiftUI

struct UtilityListView: View {
    @EnvironmentObject private var languageManager: LanguageManager

    let lineups: [UtilityLineup]

    var body: some View {
        List {
            ForEach(LineupCategory.allCases, id: \.self) { category in
                let categoryLineups = lineups.filter { lineup in
                    lineup.category == category
                }

                if !categoryLineups.isEmpty {
                    Section(category.displayName(for: languageManager)) {
                        ForEach(categoryLineups) { lineup in
                            NavigationLink {
                                LineupDetailView(lineup: lineup)
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(lineup.name.value(for: languageManager))
                                        .font(.headline)
                                    Text(lineup.type.displayName(for: languageManager))
                                        .font(.subheadline)
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
        UtilityListView(lineups: LineupStore.mirageLineups)
            .environmentObject(LanguageManager())
    }
}
