import Foundation

enum L10n {
    enum Key {
        case mapsTitle
        case lineupCount(Int)
        case settingsTitle
        case language
        case followSystem
        case simplifiedChinese
        case english
        case overview
        case name
        case type
        case side
        case difficulty
        case position
        case startArea
        case targetArea
        case throwMethod
        case description
        case tapUtilityHint
    }

    static func text(_ key: Key, for languageManager: LanguageManager) -> String {
        switch languageManager.contentLanguage {
        case .system, .en:
            return englishText(key)
        case .zhHans:
            return chineseText(key)
        }
    }

    private static func englishText(_ key: Key) -> String {
        switch key {
        case .mapsTitle:
            return "Maps"
        case .lineupCount(let count):
            return "\(count) utility lineups"
        case .settingsTitle:
            return "Settings"
        case .language:
            return "Language"
        case .followSystem:
            return "Follow System"
        case .simplifiedChinese:
            return "简体中文"
        case .english:
            return "English"
        case .overview:
            return "Overview"
        case .name:
            return "Name"
        case .type:
            return "Type"
        case .side:
            return "Side"
        case .difficulty:
            return "Difficulty"
        case .position:
            return "Position"
        case .startArea:
            return "Start Area"
        case .targetArea:
            return "Target Area"
        case .throwMethod:
            return "Throw Method"
        case .description:
            return "Description"
        case .tapUtilityHint:
            return "Tap a utility point to view details."
        }
    }

    private static func chineseText(_ key: Key) -> String {
        switch key {
        case .mapsTitle:
            return "地图"
        case .lineupCount(let count):
            return "\(count) 个道具点位"
        case .settingsTitle:
            return "设置"
        case .language:
            return "语言"
        case .followSystem:
            return "Follow System"
        case .simplifiedChinese:
            return "简体中文"
        case .english:
            return "English"
        case .overview:
            return "概览"
        case .name:
            return "名称"
        case .type:
            return "类型"
        case .side:
            return "阵营"
        case .difficulty:
            return "难度"
        case .position:
            return "位置"
        case .startArea:
            return "站位"
        case .targetArea:
            return "目标点"
        case .throwMethod:
            return "投掷方式"
        case .description:
            return "说明"
        case .tapUtilityHint:
            return "点击道具点查看详情。"
        }
    }
}
