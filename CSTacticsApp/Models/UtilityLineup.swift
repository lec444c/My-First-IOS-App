import Foundation
import SwiftUI

struct UtilityLineup: Identifiable, Hashable {
    let id = UUID()
    let mapName: String
    let name: LocalizedText
    let type: UtilityType
    let side: String
    let category: LineupCategory
    let startArea: LocalizedText
    let targetArea: LocalizedText
    let throwMethod: LocalizedText
    let difficulty: String
    let description: LocalizedText
    let positionImageName: String
    let aimImageName: String
    let resultImageName: String
    let mapX: Double
    let mapY: Double

    func difficultyDisplayName(for languageManager: LanguageManager) -> String {
        switch difficulty {
        case "Easy":
            return L10n.text(.difficultyEasy, for: languageManager)
        case "Medium":
            return L10n.text(.difficultyMedium, for: languageManager)
        default:
            return difficulty
        }
    }
}

enum LineupCategory: String, CaseIterable, Hashable {
    case aSite
    case bSite
    case mid
    case tSide
    case ctSide

    func displayName(for languageManager: LanguageManager) -> String {
        L10n.text(localizationKey, for: languageManager)
    }

    private var localizationKey: L10n.Key {
        switch self {
        case .aSite:
            return .categoryASite
        case .bSite:
            return .categoryBSite
        case .mid:
            return .categoryMid
        case .tSide:
            return .categoryTSide
        case .ctSide:
            return .categoryCTSide
        }
    }
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

    func displayName(for languageManager: LanguageManager) -> String {
        L10n.text(localizationKey, for: languageManager)
    }

    private var localizationKey: L10n.Key {
        switch self {
        case .smoke:
            return .smoke
        case .flash:
            return .flash
        case .molotov:
            return .molotov
        case .he:
            return .he
        }
    }
}
