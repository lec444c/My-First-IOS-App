import SwiftUI

struct TacticalMapView: View {
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
                        PlaceholderMirageMap()

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

                    Text("Tap a utility point to view details.")
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
            .accessibilityLabel("\(lineup.name), \(lineup.type.rawValue)")
    }
}

private struct PlaceholderMirageMap: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height

            ZStack {
                Color(.secondarySystemBackground)

                RoundedRectangle(cornerRadius: 24)
                    .fill(.orange.opacity(0.18))
                    .frame(width: width * 0.46, height: height * 0.32)
                    .position(x: width * 0.67, y: height * 0.70)

                RoundedRectangle(cornerRadius: 24)
                    .fill(.blue.opacity(0.18))
                    .frame(width: width * 0.42, height: height * 0.32)
                    .position(x: width * 0.33, y: height * 0.34)

                Capsule()
                    .fill(.green.opacity(0.18))
                    .frame(width: width * 0.22, height: height * 0.64)
                    .rotationEffect(.degrees(30))
                    .position(x: width * 0.52, y: height * 0.50)

                mapLabel("A", x: width * 0.68, y: height * 0.70)
                mapLabel("B", x: width * 0.32, y: height * 0.34)
                mapLabel("MID", x: width * 0.52, y: height * 0.50)
            }
        }
    }

    private func mapLabel(_ text: String, x: CGFloat, y: CGFloat) -> some View {
        Text(text)
            .font(.caption.bold())
            .foregroundStyle(.secondary)
            .position(x: x, y: y)
    }
}

#Preview {
    NavigationStack {
        TacticalMapView(
            mapName: "Mirage",
            lineups: LineupStore.mirageLineups
        )
    }
}
