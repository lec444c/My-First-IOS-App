import SwiftUI
import UIKit

struct LineupDetailView: View {
    @EnvironmentObject private var languageManager: LanguageManager

    let group: LineupGroup
    let variant: LineupVariant

    var body: some View {
        List {
            Section(L10n.text(.overview, for: languageManager)) {
                detailRow(L10n.text(.name, for: languageManager), variant.name.value(for: languageManager))
                detailRow(L10n.text(.targetArea, for: languageManager), group.targetName.value(for: languageManager))
                detailRow(L10n.text(.type, for: languageManager), group.type.displayName(for: languageManager))
                detailRow(L10n.text(.side, for: languageManager), group.side)
                detailRow(L10n.text(.difficulty, for: languageManager), variant.difficultyDisplayName(for: languageManager))
                detailRow(L10n.text(.spawnRequirement, for: languageManager), variant.spawnRequirement.value(for: languageManager))
            }

            Section(L10n.text(.teachingImages, for: languageManager)) {
                VStack(spacing: 12) {
                    TeachingImageCard(
                        title: L10n.text(.startPosition, for: languageManager),
                        imageName: variant.positionImageName,
                        placeholderText: L10n.text(.placeholder, for: languageManager)
                    )
                    TeachingImageCard(
                        title: L10n.text(.aimPoint, for: languageManager),
                        imageName: variant.aimImageName,
                        placeholderText: L10n.text(.placeholder, for: languageManager)
                    )
                    TeachingImageCard(
                        title: L10n.text(.result, for: languageManager),
                        imageName: variant.resultImageName,
                        placeholderText: L10n.text(.placeholder, for: languageManager)
                    )
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            }

            Section(L10n.text(.position, for: languageManager)) {
                detailRow(L10n.text(.startArea, for: languageManager), variant.startArea.value(for: languageManager))
                detailRow(L10n.text(.targetArea, for: languageManager), group.targetName.value(for: languageManager))
            }

            Section(L10n.text(.throwMethod, for: languageManager)) {
                Text(variant.throwMethod.value(for: languageManager))
            }

            Section(L10n.text(.description, for: languageManager)) {
                Text(variant.description.value(for: languageManager))
            }
        }
        .navigationTitle(variant.name.value(for: languageManager))
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

private struct TeachingImageCard: View {
    let title: String
    let imageName: String
    let placeholderText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            Group {
                if let image = UIImage(named: imageName) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemGray5))
                        .frame(height: 150)
                        .overlay {
                            Text(placeholderText)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                }
            }
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(12)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    let group = LineupStore.mirageLineupGroups[0]

    NavigationStack {
        LineupDetailView(group: group, variant: group.variants[0])
            .environmentObject(LanguageManager())
    }
}
