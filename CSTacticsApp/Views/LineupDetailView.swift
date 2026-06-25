import SwiftUI

struct LineupDetailView: View {
    let lineup: UtilityLineup

    var body: some View {
        List {
            Section("Overview") {
                detailRow("Name", lineup.name)
                detailRow("Type", lineup.type.rawValue)
                detailRow("Side", lineup.side)
                detailRow("Difficulty", lineup.difficulty)
            }

            Section("Position") {
                detailRow("Start Area", lineup.startArea)
                detailRow("Target Area", lineup.targetArea)
            }

            Section("Throw Method") {
                Text(lineup.throwMethod)
            }

            Section("Description") {
                Text(lineup.description)
            }
        }
        .navigationTitle(lineup.name)
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

#Preview {
    NavigationStack {
        LineupDetailView(lineup: LineupStore.mirageLineups[0])
    }
}
