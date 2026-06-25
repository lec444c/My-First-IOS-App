import SwiftUI
import UIKit

struct LineupDetailView: View {
    @EnvironmentObject private var languageManager: LanguageManager

    let lineup: UtilityLineup

    var body: some View {
        List {
            Section(L10n.text(.overview, for: languageManager)) {
                detailRow(L10n.text(.name, for: languageManager), lineup.name.value(for: languageManager))
                detailRow(L10n.text(.type, for: languageManager), lineup.type.displayName(for: languageManager))
                detailRow(L10n.text(.side, for: languageManager), lineup.side)
                detailRow(L10n.text(.difficulty, for: languageManager), localizedDifficulty)
            }

            Section(L10n.text(.images, for: languageManager)) {
                VStack(spacing: 12) {
                    TeachingImageCard(
                        title: L10n.text(.startPosition, for: languageManager),
                        imageName: lineup.positionImageName,
                        placeholderText: L10n.text(.placeholder, for: languageManager)
                    )
                    TeachingImageCard(
                        title: L10n.text(.aimPoint, for: languageManager),
                        imageName: lineup.aimImageName,
                        placeholderText: L10n.text(.placeholder, for: languageManager)
                    )
                    TeachingImageCard(
                        title: L10n.text(.result, for: languageManager),
                        imageName: lineup.resultImageName,
                        placeholderText: L10n.text(.placeholder, for: languageManager)
                    )
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            }

            Section(L10n.text(.position, for: languageManager)) {
                detailRow(L10n.text(.startArea, for: languageManager), lineup.startArea.value(for: languageManager))
                detailRow(L10n.text(.targetArea, for: languageManager), lineup.targetArea.value(for: languageManager))
            }

            Section(L10n.text(.throwMethod, for: languageManager)) {
                Text(lineup.throwMethod.value(for: languageManager))
            }

            Section(L10n.text(.description, for: languageManager)) {
                Text(lineup.description.value(for: languageManager))
            }
        }
        .navigationTitle(lineup.name.value(for: languageManager))
        .navigationBarTitleDisplayMode(.inline)
    }

    private var localizedDifficulty: String {
        switch languageManager.contentLanguage {
        case .system, .en:
            return lineup.difficulty
        case .zhHans:
            switch lineup.difficulty {
            case "Easy":
                return "简单"
            case "Medium":
                return "中等"
            default:
                return lineup.difficulty
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
    NavigationStack {
        LineupDetailView(lineup: LineupStore.mirageLineups[0])
            .environmentObject(LanguageManager())
    }
}
