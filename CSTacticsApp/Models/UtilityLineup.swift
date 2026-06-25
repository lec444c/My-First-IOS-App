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
}

enum LineupCategory: String, CaseIterable, Hashable {
    case aSite
    case bSite
    case mid
    case tSide
    case ctSide

    func displayName(for languageManager: LanguageManager) -> String {
        switch languageManager.contentLanguage {
        case .system, .en:
            switch self {
            case .aSite:
                return "A Site"
            case .bSite:
                return "B Site"
            case .mid:
                return "Mid"
            case .tSide:
                return "T Side"
            case .ctSide:
                return "CT Side"
            }
        case .zhHans:
            switch self {
            case .aSite:
                return "A 包点"
            case .bSite:
                return "B 包点"
            case .mid:
                return "中路"
            case .tSide:
                return "T 方"
            case .ctSide:
                return "CT 方"
            }
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
        switch languageManager.contentLanguage {
        case .system, .en:
            return rawValue
        case .zhHans:
            switch self {
            case .smoke:
                return "烟"
            case .flash:
                return "闪"
            case .molotov:
                return "火"
            case .he:
                return "雷"
            }
        }
    }
}
