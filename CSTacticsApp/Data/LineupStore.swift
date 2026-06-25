import Foundation

enum LineupStore {
    static let mirageLineups: [UtilityLineup] = [
        UtilityLineup(
            mapName: "Mirage",
            name: "Window Smoke",
            type: .smoke,
            side: "T",
            startArea: "T Spawn",
            targetArea: "Mid Window",
            throwMethod: "Position: T Spawn. Aim: roof reference. Throw: jump throw.",
            difficulty: "Medium",
            description: "Blocks Mid Window for mid control.",
            mapX: 0.46,
            mapY: 0.31
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: "Connector Smoke",
            type: .smoke,
            side: "T",
            startArea: "T Spawn",
            targetArea: "Connector",
            throwMethod: "Position: T Spawn. Aim: wall reference. Throw: jump throw.",
            difficulty: "Medium",
            description: "Blocks Connector during a mid take.",
            mapX: 0.52,
            mapY: 0.40
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: "Jungle Smoke",
            type: .smoke,
            side: "T",
            startArea: "A Ramp",
            targetArea: "Jungle",
            throwMethod: "Position: A Ramp. Aim: top reference. Throw: jump throw.",
            difficulty: "Medium",
            description: "Cuts off Jungle for an A execute.",
            mapX: 0.58,
            mapY: 0.35
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: "CT Smoke",
            type: .smoke,
            side: "T",
            startArea: "T Spawn",
            targetArea: "CT",
            throwMethod: "Position: T Spawn. Aim: wall reference. Throw: jump throw.",
            difficulty: "Easy",
            description: "Blocks CT for an A execute.",
            mapX: 0.63,
            mapY: 0.37
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: "Stairs Smoke",
            type: .smoke,
            side: "T",
            startArea: "A Ramp",
            targetArea: "Stairs",
            throwMethod: "Position: A Ramp. Aim: sky reference. Throw: jump throw.",
            difficulty: "Medium",
            description: "Blocks Stairs for an A execute.",
            mapX: 0.57,
            mapY: 0.42
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: "Market Window Smoke",
            type: .smoke,
            side: "T",
            startArea: "B Apps",
            targetArea: "Market Window",
            throwMethod: "Position: B Apps. Aim: wall reference. Throw: jump throw.",
            difficulty: "Medium",
            description: "Blocks Market Window for a B execute.",
            mapX: 0.27,
            mapY: 0.31
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: "B Short Smoke",
            type: .smoke,
            side: "T",
            startArea: "B Apps",
            targetArea: "B Short",
            throwMethod: "Position: B Apps. Aim: roof line. Throw: left click.",
            difficulty: "Easy",
            description: "Blocks Short pressure on a B hit.",
            mapX: 0.35,
            mapY: 0.37
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: "A Site Flash",
            type: .flash,
            side: "T",
            startArea: "A Ramp",
            targetArea: "A Site",
            throwMethod: "Position: A Ramp. Aim: wall edge. Throw: left click.",
            difficulty: "Easy",
            description: "Entry flash for A Site.",
            mapX: 0.53,
            mapY: 0.46
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: "Ramp Molotov",
            type: .molotov,
            side: "CT",
            startArea: "A Site",
            targetArea: "A Ramp",
            throwMethod: "Position: A Site. Aim: Ramp reference. Throw: left click.",
            difficulty: "Easy",
            description: "Slows an A Ramp push.",
            mapX: 0.50,
            mapY: 0.52
        ),
        UtilityLineup(
            mapName: "Mirage",
            name: "Default Molotov",
            type: .molotov,
            side: "T",
            startArea: "A Ramp",
            targetArea: "Default",
            throwMethod: "Position: A Ramp. Aim: default box. Throw: left click.",
            difficulty: "Easy",
            description: "Clears Default on A Site.",
            mapX: 0.60,
            mapY: 0.47
        )
    ]
}
