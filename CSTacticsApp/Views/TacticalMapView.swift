import SwiftUI

struct TacticalMapView: View {
    @EnvironmentObject private var languageManager: LanguageManager

    let mapName: String
    let lineups: [UtilityLineup]

    var body: some View {
        GeometryReader { geometry in
            let availableWidth = max(geometry.size.width - 32, 1)
            let availableHeight = max(geometry.size.height - 32, 1)
            let mapSide = min(availableWidth, availableHeight)

            ScrollView {
                VStack(spacing: 16) {
                    ZStack {
                        Image("mirage_map")
                            .resizable()
                            .scaledToFit()
                            .frame(width: mapSide, height: mapSide)

                        ForEach(lineups) { lineup in
                            NavigationLink {
                                LineupDetailView(lineup: lineup)
                            } label: {
                                UtilityPoint(lineup: lineup)
                            }
                            .buttonStyle(.plain)
                            .position(
                                x: mapSide * lineup.mapX,
                                y: mapSide * lineup.mapY
                            )
                        }
                    }
                    .frame(width: mapSide, height: mapSide)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .overlay {
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(.secondary.opacity(0.35), lineWidth: 1)
                    }

                    Text(L10n.text(.tapUtilityHint, for: languageManager))
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
        .navigationTitle(mapName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct UtilityPoint: View {
    @EnvironmentObject private var languageManager: LanguageManager

    let lineup: UtilityLineup

    var body: some View {
        Text(lineup.type.symbol)
            .font(.headline)
            .foregroundStyle(lineup.type == .flash ? .black : .white)
            .frame(width: 34, height: 34)
            .background(lineup.type.color)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.white, lineWidth: 2)
            }
            .shadow(radius: 3)
            .accessibilityLabel("\(lineup.name.value(for: languageManager)), \(lineup.type.displayName(for: languageManager))")
    }
}

#Preview {
    NavigationStack {
        TacticalMapView(
            mapName: "Mirage",
            lineups: LineupStore.mirageLineups
        )
        .environmentObject(LanguageManager())
    }
}
