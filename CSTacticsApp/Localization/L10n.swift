import Foundation

enum L10n {
    enum Key {
        case maps
        case mirage
        case lineupCount(Int)
        case settings
        case language
        case followSystem
        case simplifiedChinese
        case english
        case tacticalMap2D
        case utilityList
        case chooseMirageTool
        case categoryASite
        case categoryBSite
        case categoryMid
        case categoryTSide
        case categoryCTSide
        case smoke
        case flash
        case molotov
        case he
        case difficultyEasy
        case difficultyMedium
        case overview
        case name
        case type
        case side
        case difficulty
        case teachingImages
        case startPosition
        case aimPoint
        case result
        case placeholder
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
        case .maps:
            return "Maps"
        case .mirage:
            return "Mirage"
        case .lineupCount(let count):
            return "\(count) utility lineups"
        case .settings:
            return "Settings"
        case .language:
            return "Language"
        case .followSystem:
            return "Follow System"
        case .simplifiedChinese:
            return "简体中文"
        case .english:
            return "English"
        case .tacticalMap2D:
            return "2D Tactical Map"
        case .utilityList:
            return "Utility List"
        case .chooseMirageTool:
            return "Choose how to study Mirage utility."
        case .categoryASite:
            return "A Site"
        case .categoryBSite:
            return "B Site"
        case .categoryMid:
            return "Mid"
        case .categoryTSide:
            return "T Side"
        case .categoryCTSide:
            return "CT Side"
        case .smoke:
            return "Smoke"
        case .flash:
            return "Flash"
        case .molotov:
            return "Molotov"
        case .he:
            return "HE"
        case .difficultyEasy:
            return "Easy"
        case .difficultyMedium:
            return "Medium"
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
        case .teachingImages:
            return "Teaching Images"
        case .startPosition:
            return "Start Position"
        case .aimPoint:
            return "Aim Point"
        case .result:
            return "Result"
        case .placeholder:
            return "Placeholder"
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
        case .maps:
            return "地图"
        case .mirage:
            return "Mirage"
        case .lineupCount(let count):
            return "\(count) 个道具点位"
        case .settings:
            return "设置"
        case .language:
            return "语言"
        case .followSystem:
            return "Follow System"
        case .simplifiedChinese:
            return "简体中文"
        case .english:
            return "English"
        case .tacticalMap2D:
            return "2D 战术地图"
        case .utilityList:
            return "道具列表"
        case .chooseMirageTool:
            return "选择学习 Mirage 道具的方式。"
        case .categoryASite:
            return "A 包点"
        case .categoryBSite:
            return "B 包点"
        case .categoryMid:
            return "中路"
        case .categoryTSide:
            return "T 方"
        case .categoryCTSide:
            return "CT 方"
        case .smoke:
            return "烟"
        case .flash:
            return "闪"
        case .molotov:
            return "火"
        case .he:
            return "雷"
        case .difficultyEasy:
            return "简单"
        case .difficultyMedium:
            return "中等"
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
        case .teachingImages:
            return "教学图片"
        case .startPosition:
            return "站位图"
        case .aimPoint:
            return "瞄点图"
        case .result:
            return "落点效果"
        case .placeholder:
            return "暂无图片"
        case .position:
            return "位置"
        case .startArea:
            return "起始位置"
        case .targetArea:
            return "目标位置"
        case .throwMethod:
            return "投掷方式"
        case .description:
            return "说明"
        case .tapUtilityHint:
            return "点击道具点查看详情。"
        }
    }
}
