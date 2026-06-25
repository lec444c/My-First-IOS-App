import SwiftUI

struct MapListView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    TacticalMapView(
                        mapName: "Mirage",
                        lineups: LineupStore.mirageLineups
                    )
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Mirage")
                            .font(.headline)
                        Text("\(LineupStore.mirageLineups.count) utility lineups")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Maps")
        }
    }
}

#Preview {
    MapListView()
}
