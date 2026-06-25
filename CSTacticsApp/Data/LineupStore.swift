import Foundation

enum LineupStore {
    static let mirageLineups: [UtilityLineup] = [
        UtilityLineup(
            mapName: "Mirage",
            name: LocalizedText(en: "Window Smoke", zhHans: "中路窗口烟"),
            type: .smoke,
            side: "T",
            startArea: LocalizedText(en: "T Spawn", zhHans: "匪家"),
            targetArea: LocalizedText(en: "Mid Window", zhHans: "中路窗口"),
            throwMethod: LocalizedText(
                en: "Position: T Spawn. Aim: roof reference. Throw: jump throw.",
                zhHans: "站位：匪家。瞄点：屋顶参考点。投掷：跳投。"
            ),
            difficulty: "Medium",
            description: LocalizedText(
                en: "Blocks Mid Window for mid control.",
                zhHans: "封中路窗口，方便拿中路控制。"
            ),
            mapX: 0.46,
            mapY: 0.31
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: LocalizedText(en: "Connector Smoke", zhHans: "拱门烟"),
            type: .smoke,
            side: "T",
            startArea: LocalizedText(en: "T Spawn", zhHans: "匪家"),
            targetArea: LocalizedText(en: "Connector", zhHans: "拱门"),
            throwMethod: LocalizedText(
                en: "Position: T Spawn. Aim: wall reference. Throw: jump throw.",
                zhHans: "站位：匪家。瞄点：墙面参考点。投掷：跳投。"
            ),
            difficulty: "Medium",
            description: LocalizedText(
                en: "Blocks Connector during a mid take.",
                zhHans: "封拱门，减少中路压力。"
            ),
            mapX: 0.52,
            mapY: 0.40
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: LocalizedText(en: "Jungle Smoke", zhHans: "Jungle 烟"),
            type: .smoke,
            side: "T",
            startArea: LocalizedText(en: "A Ramp", zhHans: "A Ramp"),
            targetArea: LocalizedText(en: "Jungle", zhHans: "Jungle"),
            throwMethod: LocalizedText(
                en: "Position: A Ramp. Aim: top reference. Throw: jump throw.",
                zhHans: "站位：A Ramp。瞄点：上方参考点。投掷：跳投。"
            ),
            difficulty: "Medium",
            description: LocalizedText(
                en: "Cuts off Jungle for an A execute.",
                zhHans: "封 Jungle，配合 A 点爆弹。"
            ),
            mapX: 0.58,
            mapY: 0.35
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: LocalizedText(en: "CT Smoke", zhHans: "CT 烟"),
            type: .smoke,
            side: "T",
            startArea: LocalizedText(en: "T Spawn", zhHans: "匪家"),
            targetArea: LocalizedText(en: "CT", zhHans: "CT"),
            throwMethod: LocalizedText(
                en: "Position: T Spawn. Aim: wall reference. Throw: jump throw.",
                zhHans: "站位：匪家。瞄点：墙体参考点。投掷：跳投。"
            ),
            difficulty: "Easy",
            description: LocalizedText(
                en: "Blocks CT for an A execute.",
                zhHans: "封 CT，方便进 A 点。"
            ),
            mapX: 0.63,
            mapY: 0.37
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: LocalizedText(en: "Stairs Smoke", zhHans: "楼梯烟"),
            type: .smoke,
            side: "T",
            startArea: LocalizedText(en: "A Ramp", zhHans: "A Ramp"),
            targetArea: LocalizedText(en: "Stairs", zhHans: "楼梯"),
            throwMethod: LocalizedText(
                en: "Position: A Ramp. Aim: sky reference. Throw: jump throw.",
                zhHans: "站位：A Ramp。瞄点：天空参考点。投掷：跳投。"
            ),
            difficulty: "Medium",
            description: LocalizedText(
                en: "Blocks Stairs for an A execute.",
                zhHans: "封楼梯，压缩 A 点防守。"
            ),
            mapX: 0.57,
            mapY: 0.42
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: LocalizedText(en: "Market Window Smoke", zhHans: "超市窗口烟"),
            type: .smoke,
            side: "T",
            startArea: LocalizedText(en: "B Apps", zhHans: "B 二楼"),
            targetArea: LocalizedText(en: "Market Window", zhHans: "超市窗口"),
            throwMethod: LocalizedText(
                en: "Position: B Apps. Aim: wall reference. Throw: jump throw.",
                zhHans: "站位：B 二楼。瞄点：墙面参考点。投掷：跳投。"
            ),
            difficulty: "Medium",
            description: LocalizedText(
                en: "Blocks Market Window for a B execute.",
                zhHans: "封超市窗口，方便进 B 点。"
            ),
            mapX: 0.27,
            mapY: 0.31
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: LocalizedText(en: "B Short Smoke", zhHans: "B 小烟"),
            type: .smoke,
            side: "T",
            startArea: LocalizedText(en: "B Apps", zhHans: "B 二楼"),
            targetArea: LocalizedText(en: "B Short", zhHans: "B 小"),
            throwMethod: LocalizedText(
                en: "Position: B Apps. Aim: roof line. Throw: left click.",
                zhHans: "站位：B 二楼。瞄点：屋顶线。投掷：左键投。"
            ),
            difficulty: "Easy",
            description: LocalizedText(
                en: "Blocks Short pressure on a B hit.",
                zhHans: "封 B 小，减轻进 B 压力。"
            ),
            mapX: 0.35,
            mapY: 0.37
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: LocalizedText(en: "A Site Flash", zhHans: "A 点闪"),
            type: .flash,
            side: "T",
            startArea: LocalizedText(en: "A Ramp", zhHans: "A Ramp"),
            targetArea: LocalizedText(en: "A Site", zhHans: "A 点"),
            throwMethod: LocalizedText(
                en: "Position: A Ramp. Aim: wall edge. Throw: left click.",
                zhHans: "站位：A Ramp。瞄点：墙边。投掷：左键投。"
            ),
            difficulty: "Easy",
            description: LocalizedText(
                en: "Entry flash for A Site.",
                zhHans: "进 A 点用的突破闪。"
            ),
            mapX: 0.53,
            mapY: 0.46
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: LocalizedText(en: "Ramp Molotov", zhHans: "A Ramp 火"),
            type: .molotov,
            side: "CT",
            startArea: LocalizedText(en: "A Site", zhHans: "A 点"),
            targetArea: LocalizedText(en: "A Ramp", zhHans: "A Ramp"),
            throwMethod: LocalizedText(
                en: "Position: A Site. Aim: Ramp reference. Throw: left click.",
                zhHans: "站位：A 点。瞄点：A Ramp 参考点。投掷：左键投。"
            ),
            difficulty: "Easy",
            description: LocalizedText(
                en: "Slows an A Ramp push.",
                zhHans: "拖住 A Ramp 前压。"
            ),
            mapX: 0.50,
            mapY: 0.52
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: LocalizedText(en: "Default Molotov", zhHans: "默认包点火"),
            type: .molotov,
            side: "T",
            startArea: LocalizedText(en: "A Ramp", zhHans: "A Ramp"),
            targetArea: LocalizedText(en: "Default", zhHans: "默认包点"),
            throwMethod: LocalizedText(
                en: "Position: A Ramp. Aim: default box. Throw: left click.",
                zhHans: "站位：A Ramp。瞄点：默认包位箱子。投掷：左键投。"
            ),
            difficulty: "Easy",
            description: LocalizedText(
                en: "Clears Default on A Site.",
                zhHans: "清 A 点默认包位。"
            ),
            mapX: 0.60,
            mapY: 0.47
        )
    ]
}
