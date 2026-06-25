import Foundation

enum L10n {
    enum Key {
        case maps
        case mirage
        case lineupCount(Int)
        case variantCount(Int)
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
        case category
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
        case developerMode
        case developerMapHint
        case liveCoordinates
        case lastEditedCoordinate
        case noEditedCoordinate
        case copyCoordinates
        case copyJSON
        case coordinatesCopied
        case jsonCopied
        case startPoint
        case targetPoint
        case about
        case appDisplayName
        case appName
        case appIntro
        case creator
        case creatorName
        case version
        case unofficialNotice
        case unofficialNoticeText
        case acknowledgements
        case acknowledgementsText
        case mapFilterArea
        case mapFilterUtilityType
        case mapFilterFeatured
        case mapFilterAll
        case clusteredUtilities
        case lineupVariants
        case spawnRequirement
        case targetPoints
        case variantStartPoints
        case lineConnections
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
        case .variantCount(let count):
            return "\(count) variants"
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
        case .category:
            return "Category"
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
        case .developerMode:
            return "Developer Mode"
        case .developerMapHint:
            return "Drag utility points to adjust map coordinates."
        case .liveCoordinates:
            return "Live Coordinates"
        case .lastEditedCoordinate:
            return "Last Edited"
        case .noEditedCoordinate:
            return "No edited coordinate yet."
        case .copyCoordinates:
            return "Copy Coordinates"
        case .copyJSON:
            return "Copy JSON"
        case .coordinatesCopied:
            return "Coordinates copied."
        case .jsonCopied:
            return "JSON copied."
        case .startPoint:
            return "Start"
        case .targetPoint:
            return "Target"
        case .about:
            return "About"
        case .appDisplayName:
            return "AimNade"
        case .appName:
            return "App Name"
        case .appIntro:
            return "AimNade is a 2D tactical utility tool for Counter-Strike players. It helps players learn common lineups through map markers, categorized lists, start position images, aim point images, and result references."
        case .creator:
            return "Creator"
        case .creatorName:
            return "b1skelA"
        case .version:
            return "Version"
        case .unofficialNotice:
            return "Unofficial Notice"
        case .unofficialNoticeText:
            return "This is an unofficial fan-made tactical tool. It is not affiliated with Valve or Counter-Strike."
        case .acknowledgements:
            return "Acknowledgements"
        case .acknowledgementsText:
            return "Thanks to the Counter-Strike community for lineup tutorials and tactical knowledge sharing."
        case .mapFilterArea:
            return "Area"
        case .mapFilterUtilityType:
            return "Utility Type"
        case .mapFilterFeatured:
            return "Featured"
        case .mapFilterAll:
            return "All"
        case .clusteredUtilities:
            return "Utilities"
        case .lineupVariants:
            return "Lineup Variants"
        case .spawnRequirement:
            return "Spawn / Body Position"
        case .targetPoints:
            return "Target Points"
        case .variantStartPoints:
            return "Variant Start Points"
        case .lineConnections:
            return "Line Connections"
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
        case .variantCount(let count):
            return "\(count) 个丢法"
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
        case .category:
            return "分类"
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
        case .developerMode:
            return "开发者模式"
        case .developerMapHint:
            return "拖动道具点调整地图坐标。"
        case .liveCoordinates:
            return "实时坐标"
        case .lastEditedCoordinate:
            return "最近调整"
        case .noEditedCoordinate:
            return "还没有调整点位。"
        case .copyCoordinates:
            return "复制坐标"
        case .copyJSON:
            return "复制 JSON"
        case .coordinatesCopied:
            return "坐标已复制。"
        case .jsonCopied:
            return "JSON 已复制。"
        case .startPoint:
            return "站位"
        case .targetPoint:
            return "目标"
        case .about:
            return "关于"
        case .appDisplayName:
            return "AimNade"
        case .appName:
            return "App 名称"
        case .appIntro:
            return "AimNade 是一个面向 CS 玩家制作的 2D 战术道具工具。你可以通过地图点位、分类列表、站位图、瞄点图和落点效果快速学习常用道具。"
        case .creator:
            return "制作者"
        case .creatorName:
            return "乐扣"
        case .version:
            return "版本号"
        case .unofficialNotice:
            return "非官方声明"
        case .unofficialNoticeText:
            return "本 App 是玩家自制的非官方战术工具，与 Valve 或 Counter-Strike 官方无关。"
        case .acknowledgements:
            return "鸣谢"
        case .acknowledgementsText:
            return "感谢所有 CS 玩家社区的道具教学与战术分享。"
        case .mapFilterArea:
            return "区域"
        case .mapFilterUtilityType:
            return "道具类型"
        case .mapFilterFeatured:
            return "推荐"
        case .mapFilterAll:
            return "全部"
        case .clusteredUtilities:
            return "道具"
        case .lineupVariants:
            return "道具丢法"
        case .spawnRequirement:
            return "适用出生点 / 身位"
        case .targetPoints:
            return "目标点"
        case .variantStartPoints:
            return "变体站位点"
        case .lineConnections:
            return "站位到目标连线"
        }
    }
}
