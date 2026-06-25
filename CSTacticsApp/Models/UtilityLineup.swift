import Foundation
import SwiftUI

struct UtilityLineup: Identifiable, Hashable {
    let id = UUID()
    let mapName: String
    let name: String
    let type: UtilityType
    let side: String
    let startArea: String
    let targetArea: String
    let throwMethod: String
    let difficulty: String
    let description: String
    let mapX: Double
    let mapY: Double
}

enum UtilityType: String, CaseIterable, Hashable {
    case smoke = "Smoke"
    case flash = "Flash"
    case molotov = "Molotov"
    case he = "HE"

    var symbol: String {
        switch self {
        case .smoke:
            return "S"
        case .flash:
            return "F"
        case .molotov:
            return "M"
        case .he:
            return "H"
        }
    }

    var color: Color {
        switch self {
        case .smoke:
            return .gray
        case .flash:
            return .yellow
        case .molotov:
            return .orange
        case .he:
            return .red
        }
    }
}
