import Foundation

enum LineupStore {
    static let maps: [Map] = [
        mirageMap
    ]

    static let mirageMap = Map(
        id: "mirage",
        name: LocalizedText(en: "Mirage", zhHans: "Mirage"),
        imageName: "mirage_map",
        lineupGroups: mirageGroups
    )

    private static let mirageGroups: [LineupGroup] = [
        LineupGroup(
            id: "mirage_window_smoke",
            mapId: "mirage",
            targetName: LocalizedText(en: "Window Smoke", zhHans: "VIP 烟"),
            type: .smoke,
            side: "T",
            category: .mid,
            targetMapX: 0.46,
            targetMapY: 0.36,
            isFeatured: true,
            variants: [
                LineupVariant(
                    id: "mirage_window_smoke_standard_t_spawn",
                    name: LocalizedText(en: "Standard T Spawn", zhHans: "匪家稳定丢法"),
                    spawnRequirement: LocalizedText(en: "Any T spawn, stable lineup.", zhHans: "任意 T 出生点，稳定站位。"),
                    startArea: LocalizedText(en: "T Spawn", zhHans: "匪家"),
                    throwMethod: LocalizedText(
                        en: "Position: T Spawn. Aim: roof reference. Throw: jump throw.",
                        zhHans: "站位：匪家。瞄点：屋顶参考点。投掷：跳投。"
                    ),
                    description: LocalizedText(
                        en: "Blocks Mid Window for mid control.",
                        zhHans: "封中路窗口，方便拿中路控制。"
                    ),
                    difficulty: "Medium",
                    startMapX: 0.46,
                    startMapY: 0.31,
                    targetMapX: 0.46,
                    targetMapY: 0.36,
                    positionImageName: "mirage_window_smoke_position",
                    aimImageName: "mirage_window_smoke_aim",
                    resultImageName: "mirage_window_smoke_result"
                ),
                LineupVariant(
                    id: "mirage_window_smoke_left_spawn",
                    name: LocalizedText(en: "Left Spawn Fast Throw", zhHans: "靠左出生快丢"),
                    spawnRequirement: LocalizedText(en: "Best for left T spawns or fast mid control.", zhHans: "适合靠左 T 出生点或快速拿中路。"),
                    startArea: LocalizedText(en: "T Spawn", zhHans: "匪家"),
                    throwMethod: LocalizedText(
                        en: "Position: left T spawn. Aim: roof edge. Throw: jump throw.",
                        zhHans: "站位：匪家左侧。瞄点：屋檐边。投掷：跳投。"
                    ),
                    description: LocalizedText(
                        en: "A faster Window Smoke option for mid pressure.",
                        zhHans: "更快封 VIP，方便中路前压。"
                    ),
                    difficulty: "Medium",
                    startMapX: 0.43,
                    startMapY: 0.30,
                    targetMapX: 0.46,
                    targetMapY: 0.36,
                    positionImageName: "mirage_window_smoke_left_spawn_position",
                    aimImageName: "mirage_window_smoke_left_spawn_aim",
                    resultImageName: "mirage_window_smoke_left_spawn_result"
                ),
                LineupVariant(
                    id: "mirage_window_smoke_safe_position",
                    name: LocalizedText(en: "Safe Position", zhHans: "安全站位丢法"),
                    spawnRequirement: LocalizedText(en: "Use when timing is less urgent.", zhHans: "适合不抢第一时间的回合。"),
                    startArea: LocalizedText(en: "T Spawn", zhHans: "匪家"),
                    throwMethod: LocalizedText(
                        en: "Position: safe T spawn spot. Aim: roof mark. Throw: jump throw.",
                        zhHans: "站位：匪家安全点。瞄点：屋顶标记。投掷：跳投。"
                    ),
                    description: LocalizedText(
                        en: "A forgiving Window Smoke with safer positioning.",
                        zhHans: "容错更高的 VIP 烟站位。"
                    ),
                    difficulty: "Easy",
                    startMapX: 0.48,
                    startMapY: 0.32,
                    targetMapX: 0.46,
                    targetMapY: 0.36,
                    positionImageName: "mirage_window_smoke_safe_position",
                    aimImageName: "mirage_window_smoke_safe_aim",
                    resultImageName: "mirage_window_smoke_safe_result"
                )
            ]
        ),
        LineupGroup(
            id: "mirage_connector_smoke",
            mapId: "mirage",
            targetName: LocalizedText(en: "Connector Smoke", zhHans: "拱门烟"),
            type: .smoke,
            side: "T",
            category: .mid,
            targetMapX: 0.48,
            targetMapY: 0.47,
            isFeatured: true,
            variants: [
                LineupVariant(
                    id: "mirage_connector_smoke_standard",
                    name: LocalizedText(en: "Standard T Spawn", zhHans: "匪家标准丢法"),
                    spawnRequirement: LocalizedText(en: "Any T spawn.", zhHans: "任意 T 出生点。"),
                    startArea: LocalizedText(en: "T Spawn", zhHans: "匪家"),
                    throwMethod: LocalizedText(
                        en: "Position: T Spawn. Aim: wall reference. Throw: jump throw.",
                        zhHans: "站位：匪家。瞄点：墙面参考点。投掷：跳投。"
                    ),
                    description: LocalizedText(
                        en: "Blocks Connector during a mid take.",
                        zhHans: "封拱门，减少中路压力。"
                    ),
                    difficulty: "Medium",
                    startMapX: 0.52,
                    startMapY: 0.40,
                    targetMapX: 0.48,
                    targetMapY: 0.47,
                    positionImageName: "mirage_connector_smoke_position",
                    aimImageName: "mirage_connector_smoke_aim",
                    resultImageName: "mirage_connector_smoke_result"
                )
            ]
        ),
        LineupGroup(
            id: "mirage_jungle_smoke",
            mapId: "mirage",
            targetName: LocalizedText(en: "Jungle Smoke", zhHans: "Jungle 烟"),
            type: .smoke,
            side: "T",
            category: .aSite,
            targetMapX: 0.42,
            targetMapY: 0.62,
            isFeatured: true,
            variants: [
                LineupVariant(
                    id: "mirage_jungle_smoke_a_ramp",
                    name: LocalizedText(en: "A Ramp Lineup", zhHans: "A Ramp 丢法"),
                    spawnRequirement: LocalizedText(en: "Best when grouping A Ramp.", zhHans: "适合 A Ramp 集合爆弹。"),
                    startArea: LocalizedText(en: "A Ramp", zhHans: "A Ramp"),
                    throwMethod: LocalizedText(
                        en: "Position: A Ramp. Aim: top reference. Throw: jump throw.",
                        zhHans: "站位：A Ramp。瞄点：上方参考点。投掷：跳投。"
                    ),
                    description: LocalizedText(
                        en: "Cuts off Jungle for an A execute.",
                        zhHans: "封 Jungle，配合 A 点爆弹。"
                    ),
                    difficulty: "Medium",
                    startMapX: 0.58,
                    startMapY: 0.35,
                    targetMapX: 0.42,
                    targetMapY: 0.62,
                    positionImageName: "mirage_jungle_smoke_position",
                    aimImageName: "mirage_jungle_smoke_aim",
                    resultImageName: "mirage_jungle_smoke_result"
                )
            ]
        ),
        LineupGroup(
            id: "mirage_ct_smoke",
            mapId: "mirage",
            targetName: LocalizedText(en: "CT Smoke", zhHans: "CT 烟"),
            type: .smoke,
            side: "T",
            category: .aSite,
            targetMapX: 0.69,
            targetMapY: 0.50,
            isFeatured: true,
            variants: [
                LineupVariant(
                    id: "mirage_ct_smoke_t_spawn",
                    name: LocalizedText(en: "T Spawn Lineup", zhHans: "匪家丢法"),
                    spawnRequirement: LocalizedText(en: "Any T spawn.", zhHans: "任意 T 出生点。"),
                    startArea: LocalizedText(en: "T Spawn", zhHans: "匪家"),
                    throwMethod: LocalizedText(
                        en: "Position: T Spawn. Aim: wall reference. Throw: jump throw.",
                        zhHans: "站位：匪家。瞄点：墙体参考点。投掷：跳投。"
                    ),
                    description: LocalizedText(
                        en: "Blocks CT for an A execute.",
                        zhHans: "封 CT，方便进 A 点。"
                    ),
                    difficulty: "Easy",
                    startMapX: 0.63,
                    startMapY: 0.37,
                    targetMapX: 0.69,
                    targetMapY: 0.50,
                    positionImageName: "mirage_ct_smoke_position",
                    aimImageName: "mirage_ct_smoke_aim",
                    resultImageName: "mirage_ct_smoke_result"
                )
            ]
        ),
        LineupGroup(
            id: "mirage_stairs_smoke",
            mapId: "mirage",
            targetName: LocalizedText(en: "Stairs Smoke", zhHans: "楼梯烟"),
            type: .smoke,
            side: "T",
            category: .aSite,
            targetMapX: 0.57,
            targetMapY: 0.57,
            isFeatured: false,
            variants: [
                LineupVariant(
                    id: "mirage_stairs_smoke_a_ramp",
                    name: LocalizedText(en: "A Ramp Lineup", zhHans: "A Ramp 丢法"),
                    spawnRequirement: LocalizedText(en: "Best when grouping A Ramp.", zhHans: "适合 A Ramp 集合爆弹。"),
                    startArea: LocalizedText(en: "A Ramp", zhHans: "A Ramp"),
                    throwMethod: LocalizedText(
                        en: "Position: A Ramp. Aim: sky reference. Throw: jump throw.",
                        zhHans: "站位：A Ramp。瞄点：天空参考点。投掷：跳投。"
                    ),
                    description: LocalizedText(
                        en: "Blocks Stairs for an A execute.",
                        zhHans: "封楼梯，压缩 A 点防守。"
                    ),
                    difficulty: "Medium",
                    startMapX: 0.57,
                    startMapY: 0.42,
                    targetMapX: 0.57,
                    targetMapY: 0.57,
                    positionImageName: "mirage_stairs_smoke_position",
                    aimImageName: "mirage_stairs_smoke_aim",
                    resultImageName: "mirage_stairs_smoke_result"
                )
            ]
        ),
        LineupGroup(
            id: "mirage_market_window_smoke",
            mapId: "mirage",
            targetName: LocalizedText(en: "Market Window Smoke", zhHans: "超市窗口烟"),
            type: .smoke,
            side: "T",
            category: .bSite,
            targetMapX: 0.21,
            targetMapY: 0.45,
            isFeatured: false,
            variants: [
                LineupVariant(
                    id: "mirage_market_window_smoke_b_apps",
                    name: LocalizedText(en: "B Apps Lineup", zhHans: "B 二楼丢法"),
                    spawnRequirement: LocalizedText(en: "Use from B Apps control.", zhHans: "适合控住 B 二楼后使用。"),
                    startArea: LocalizedText(en: "B Apps", zhHans: "B 二楼"),
                    throwMethod: LocalizedText(
                        en: "Position: B Apps. Aim: wall reference. Throw: jump throw.",
                        zhHans: "站位：B 二楼。瞄点：墙面参考点。投掷：跳投。"
                    ),
                    description: LocalizedText(
                        en: "Blocks Market Window for a B execute.",
                        zhHans: "封超市窗口，方便进 B 点。"
                    ),
                    difficulty: "Medium",
                    startMapX: 0.27,
                    startMapY: 0.31,
                    targetMapX: 0.21,
                    targetMapY: 0.45,
                    positionImageName: "mirage_market_window_smoke_position",
                    aimImageName: "mirage_market_window_smoke_aim",
                    resultImageName: "mirage_market_window_smoke_result"
                )
            ]
        ),
        LineupGroup(
            id: "mirage_b_short_smoke",
            mapId: "mirage",
            targetName: LocalizedText(en: "B Short Smoke", zhHans: "B 小烟"),
            type: .smoke,
            side: "T",
            category: .bSite,
            targetMapX: 0.50,
            targetMapY: 0.40,
            isFeatured: false,
            variants: [
                LineupVariant(
                    id: "mirage_b_short_smoke_b_apps",
                    name: LocalizedText(en: "B Apps Lineup", zhHans: "B 二楼丢法"),
                    spawnRequirement: LocalizedText(en: "Use from B Apps control.", zhHans: "适合控住 B 二楼后使用。"),
                    startArea: LocalizedText(en: "B Apps", zhHans: "B 二楼"),
                    throwMethod: LocalizedText(
                        en: "Position: B Apps. Aim: roof line. Throw: left click.",
                        zhHans: "站位：B 二楼。瞄点：屋顶线。投掷：左键投。"
                    ),
                    description: LocalizedText(
                        en: "Blocks Short pressure on a B hit.",
                        zhHans: "封 B 小，减轻进 B 压力。"
                    ),
                    difficulty: "Easy",
                    startMapX: 0.35,
                    startMapY: 0.37,
                    targetMapX: 0.50,
                    targetMapY: 0.40,
                    positionImageName: "mirage_b_short_smoke_position",
                    aimImageName: "mirage_b_short_smoke_aim",
                    resultImageName: "mirage_b_short_smoke_result"
                )
            ]
        ),
        LineupGroup(
            id: "mirage_a_site_flash",
            mapId: "mirage",
            targetName: LocalizedText(en: "A Site Flash", zhHans: "A 点闪"),
            type: .flash,
            side: "T",
            category: .tSide,
            targetMapX: 0.62,
            targetMapY: 0.58,
            isFeatured: true,
            variants: [
                LineupVariant(
                    id: "mirage_a_site_flash_a_ramp",
                    name: LocalizedText(en: "A Ramp Entry Flash", zhHans: "A Ramp 突破闪"),
                    spawnRequirement: LocalizedText(en: "Use before entering A Site.", zhHans: "适合进 A 点前使用。"),
                    startArea: LocalizedText(en: "A Ramp", zhHans: "A Ramp"),
                    throwMethod: LocalizedText(
                        en: "Position: A Ramp. Aim: wall edge. Throw: left click.",
                        zhHans: "站位：A Ramp。瞄点：墙边。投掷：左键投。"
                    ),
                    description: LocalizedText(
                        en: "Entry flash for A Site.",
                        zhHans: "进 A 点用的突破闪。"
                    ),
                    difficulty: "Easy",
                    startMapX: 0.53,
                    startMapY: 0.46,
                    targetMapX: 0.62,
                    targetMapY: 0.58,
                    positionImageName: "mirage_a_site_flash_position",
                    aimImageName: "mirage_a_site_flash_aim",
                    resultImageName: "mirage_a_site_flash_result"
                )
            ]
        ),
        LineupGroup(
            id: "mirage_ramp_molotov",
            mapId: "mirage",
            targetName: LocalizedText(en: "Ramp Molotov", zhHans: "A Ramp 火"),
            type: .molotov,
            side: "CT",
            category: .ctSide,
            targetMapX: 0.56,
            targetMapY: 0.82,
            isFeatured: false,
            variants: [
                LineupVariant(
                    id: "mirage_ramp_molotov_a_site",
                    name: LocalizedText(en: "A Site Anti-Ramp", zhHans: "A 点防 Ramp"),
                    spawnRequirement: LocalizedText(en: "Use when defending A Site.", zhHans: "适合 A 点防守时使用。"),
                    startArea: LocalizedText(en: "A Site", zhHans: "A 点"),
                    throwMethod: LocalizedText(
                        en: "Position: A Site. Aim: Ramp reference. Throw: left click.",
                        zhHans: "站位：A 点。瞄点：A Ramp 参考点。投掷：左键投。"
                    ),
                    description: LocalizedText(
                        en: "Slows an A Ramp push.",
                        zhHans: "拖住 A Ramp 前压。"
                    ),
                    difficulty: "Easy",
                    startMapX: 0.50,
                    startMapY: 0.52,
                    targetMapX: 0.56,
                    targetMapY: 0.82,
                    positionImageName: "mirage_ramp_molotov_position",
                    aimImageName: "mirage_ramp_molotov_aim",
                    resultImageName: "mirage_ramp_molotov_result"
                )
            ]
        ),
        LineupGroup(
            id: "mirage_default_molotov",
            mapId: "mirage",
            targetName: LocalizedText(en: "Default Molotov", zhHans: "默认包点火"),
            type: .molotov,
            side: "T",
            category: .aSite,
            targetMapX: 0.58,
            targetMapY: 0.75,
            isFeatured: false,
            variants: [
                LineupVariant(
                    id: "mirage_default_molotov_a_ramp",
                    name: LocalizedText(en: "A Ramp Clear", zhHans: "A Ramp 清默认"),
                    spawnRequirement: LocalizedText(en: "Use before committing to A Site.", zhHans: "适合进 A 点前清包点。"),
                    startArea: LocalizedText(en: "A Ramp", zhHans: "A Ramp"),
                    throwMethod: LocalizedText(
                        en: "Position: A Ramp. Aim: default box. Throw: left click.",
                        zhHans: "站位：A Ramp。瞄点：默认包位箱子。投掷：左键投。"
                    ),
                    description: LocalizedText(
                        en: "Clears Default on A Site.",
                        zhHans: "清 A 点默认包位。"
                    ),
                    difficulty: "Easy",
                    startMapX: 0.60,
                    startMapY: 0.47,
                    targetMapX: 0.58,
                    targetMapY: 0.75,
                    positionImageName: "mirage_default_molotov_position",
                    aimImageName: "mirage_default_molotov_aim",
                    resultImageName: "mirage_default_molotov_result"
                )
            ]
        )
    ]
}
