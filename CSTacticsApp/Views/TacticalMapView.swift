import SwiftUI
import UIKit

struct TacticalMapView: View {
    @EnvironmentObject private var languageManager: LanguageManager
    @EnvironmentObject private var developerSettings: DeveloperSettings

    @State private var selectedLineup: UtilityLineup?
    @State private var selectedLineupCluster: LineupCluster?
    @State private var selectedAreaFilter: MapAreaFilter = .featured
    @State private var selectedTypeFilter: MapUtilityTypeFilter = .all
    @State private var currentZoomScale: CGFloat = 1.0
    @State private var editedCoordinates: [MapPointKey: CGPoint] = [:]
    @State private var activeCoordinate: EditedLineupCoordinate?
    @State private var lastEditedCoordinate: EditedLineupCoordinate?
    @State private var copyStatusMessage: String?

    let mapName: String
    let lineups: [UtilityLineup]

    private var filteredLineups: [UtilityLineup] {
        lineups.filter { lineup in
            selectedAreaFilter.matches(lineup)
                && selectedTypeFilter.matches(lineup)
        }
    }

    var body: some View {
        GeometryReader { geometry in
            let availableWidth = max(geometry.size.width - 32, 1)
            let reservedHeight: CGFloat = developerSettings.isDeveloperModeEnabled ? 344 : 176
            let availableHeight = max(geometry.size.height - reservedHeight, 1)
            let mapContainerSize = CGSize(width: availableWidth, height: availableHeight)
            let mapImageSize = UIImage(named: "mirage_map")?.size ?? CGSize(width: 1, height: 1)

            VStack(spacing: 12) {
                MapFilterBar(
                    selectedAreaFilter: $selectedAreaFilter,
                    selectedTypeFilter: $selectedTypeFilter
                )
                .environmentObject(languageManager)

                ZoomableScrollView(
                    minScale: 1.0,
                    maxScale: 4.0,
                    doubleTapScale: 2.5,
                    isPointEditingEnabled: developerSettings.isDeveloperModeEnabled,
                    zoomScale: $currentZoomScale
                ) {
                    MapCanvas(
                        containerSize: mapContainerSize,
                        imageSize: mapImageSize,
                        lineups: filteredLineups,
                        editedCoordinates: editedCoordinates,
                        developerModeEnabled: developerSettings.isDeveloperModeEnabled,
                        zoomScale: currentZoomScale,
                        onSelect: { lineup in
                            selectedLineup = lineup
                        },
                        onSelectCluster: { cluster in
                            selectedLineupCluster = cluster
                        },
                        onCoordinateChanged: { lineup, kind, coordinate in
                            updateEditedCoordinate(
                                for: lineup,
                                kind: kind,
                                coordinate: coordinate,
                                isFinished: false
                            )
                        },
                        onCoordinateEnded: { lineup, kind, coordinate in
                            updateEditedCoordinate(
                                for: lineup,
                                kind: kind,
                                coordinate: coordinate,
                                isFinished: true
                            )
                        }
                    )
                    .environmentObject(languageManager)
                }
                .frame(width: mapContainerSize.width, height: mapContainerSize.height)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .overlay {
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.secondary.opacity(0.35), lineWidth: 1)
                }

                Text(mapHintText)
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                if developerSettings.isDeveloperModeEnabled {
                    DeveloperCoordinatePanel(
                        coordinate: activeCoordinate ?? lastEditedCoordinate,
                        statusMessage: copyStatusMessage,
                        onCopyCoordinates: copyCurrentCoordinates,
                        onCopyJSON: copyJSONCoordinates
                    )
                    .environmentObject(languageManager)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
        .navigationTitle(mapName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $selectedLineup) { lineup in
            LineupDetailView(lineup: lineup)
        }
        .sheet(item: $selectedLineupCluster) { cluster in
            ClusterLineupSheet(cluster: cluster) { lineup in
                selectedLineupCluster = nil
                DispatchQueue.main.async {
                    selectedLineup = lineup
                }
            }
            .environmentObject(languageManager)
        }
    }

    private var mapHintText: String {
        if developerSettings.isDeveloperModeEnabled {
            return L10n.text(.developerMapHint, for: languageManager)
        }

        return L10n.text(.tapUtilityHint, for: languageManager)
    }

    private func updateEditedCoordinate(
        for lineup: UtilityLineup,
        kind: MapPointKind,
        coordinate: CGPoint,
        isFinished: Bool
    ) {
        let editedCoordinate = EditedLineupCoordinate(
            id: MapPointKey(lineupID: lineup.id, kind: kind),
            lineupName: lineup.name.value(for: languageManager),
            kind: kind,
            mapX: Double(coordinate.x),
            mapY: Double(coordinate.y)
        )

        editedCoordinates[editedCoordinate.id] = coordinate
        copyStatusMessage = nil

        if isFinished {
            activeCoordinate = nil
            lastEditedCoordinate = editedCoordinate
        } else {
            activeCoordinate = editedCoordinate
        }
    }

    private func copyCurrentCoordinates() {
        guard let coordinate = activeCoordinate ?? lastEditedCoordinate else {
            return
        }

        UIPasteboard.general.string = coordinate.coordinateText
        copyStatusMessage = L10n.text(.coordinatesCopied, for: languageManager)
    }

    private func copyJSONCoordinates() {
        let jsonItems = lineups.map { lineup in
            let startCoordinate = coordinate(for: lineup, kind: .start) ?? .zero
            var item: [String: Any] = [
                "id": lineup.id.uuidString,
                "startMapX": roundedCoordinate(Double(startCoordinate.x)),
                "startMapY": roundedCoordinate(Double(startCoordinate.y))
            ]

            if let targetCoordinate = coordinate(for: lineup, kind: .target) {
                item["targetMapX"] = roundedCoordinate(Double(targetCoordinate.x))
                item["targetMapY"] = roundedCoordinate(Double(targetCoordinate.y))
            }

            return item
        }

        if let data = try? JSONSerialization.data(
            withJSONObject: jsonItems,
            options: [.prettyPrinted, .sortedKeys]
        ),
           let jsonString = String(data: data, encoding: .utf8) {
            UIPasteboard.general.string = jsonString
            copyStatusMessage = L10n.text(.jsonCopied, for: languageManager)
        }
    }

    private func coordinate(for lineup: UtilityLineup, kind: MapPointKind) -> CGPoint? {
        let key = MapPointKey(lineupID: lineup.id, kind: kind)

        if let editedCoordinate = editedCoordinates[key] {
            return editedCoordinate
        }

        switch kind {
        case .start:
            return CGPoint(x: lineup.startMapX, y: lineup.startMapY)
        case .target:
            return lineup.targetCoordinate
        }
    }

    private func roundedCoordinate(_ value: Double) -> Double {
        (value * 1000).rounded() / 1000
    }
}

private struct MapFilterBar: View {
    @EnvironmentObject private var languageManager: LanguageManager

    @Binding var selectedAreaFilter: MapAreaFilter
    @Binding var selectedTypeFilter: MapUtilityTypeFilter

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            filterTitle(L10n.text(.mapFilterArea, for: languageManager))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(MapAreaFilter.allCases) { filter in
                        FilterChip(
                            title: filter.displayName(for: languageManager),
                            isSelected: selectedAreaFilter == filter
                        ) {
                            selectedAreaFilter = filter
                        }
                    }
                }
            }

            filterTitle(L10n.text(.mapFilterUtilityType, for: languageManager))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(MapUtilityTypeFilter.allCases) { filter in
                        FilterChip(
                            title: filter.displayName(for: languageManager),
                            isSelected: selectedTypeFilter == filter
                        ) {
                            selectedTypeFilter = filter
                        }
                    }
                }
            }
        }
    }

    private func filterTitle(_ title: String) -> some View {
        Text(title)
            .font(.caption.weight(.semibold))
            .foregroundStyle(.secondary)
    }
}

private struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(isSelected ? Color.accentColor : Color(.secondarySystemBackground))
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

private struct MapCanvas: View {
    @EnvironmentObject private var languageManager: LanguageManager

    private let coordinateSpaceName = "tacticalMapCanvas"

    let containerSize: CGSize
    let imageSize: CGSize
    let lineups: [UtilityLineup]
    let editedCoordinates: [MapPointKey: CGPoint]
    let developerModeEnabled: Bool
    let zoomScale: CGFloat
    let onSelect: (UtilityLineup) -> Void
    let onSelectCluster: (LineupCluster) -> Void
    let onCoordinateChanged: (UtilityLineup, MapPointKind, CGPoint) -> Void
    let onCoordinateEnded: (UtilityLineup, MapPointKind, CGPoint) -> Void

    var body: some View {
        let imageRect = fittedImageRect(
            imageSize: imageSize,
            containerSize: containerSize
        )
        let clusters = clusteredLineups(in: imageRect)

        ZStack {
            Image("mirage_map")
                .resizable()
                .scaledToFit()
                .frame(width: containerSize.width, height: containerSize.height)

            if developerModeEnabled {
                ForEach(lineups) { lineup in
                    if let targetCoordinate = targetCoordinate(for: lineup) {
                        let startPoint = pointLocation(
                            for: startCoordinate(for: lineup),
                            in: imageRect
                        )
                        let targetPoint = pointLocation(
                            for: targetCoordinate,
                            in: imageRect
                        )

                        Path { path in
                            path.move(to: startPoint)
                            path.addLine(to: targetPoint)
                        }
                        .stroke(lineup.type.color.opacity(0.75), lineWidth: 2)
                    }
                }

                ForEach(lineups) { lineup in
                    let startPoint = pointLocation(for: startCoordinate(for: lineup), in: imageRect)

                    draggablePoint(
                        lineup: lineup,
                        kind: .start,
                        imageRect: imageRect,
                        pointSize: CGSize(width: 124, height: 76)
                    )
                    .position(startPoint)

                    if let targetCoordinate = targetCoordinate(for: lineup) {
                        let targetPoint = pointLocation(for: targetCoordinate, in: imageRect)

                        draggablePoint(
                            lineup: lineup,
                            kind: .target,
                            imageRect: imageRect,
                            pointSize: CGSize(width: 112, height: 68)
                        )
                        .position(targetPoint)
                    }
                }
            } else {
                ForEach(clusters) { cluster in
                    if cluster.lineups.count > 1 {
                        Button {
                            onSelectCluster(cluster)
                        } label: {
                            ClusterPoint(count: cluster.lineups.count)
                        }
                        .buttonStyle(.plain)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                        .position(cluster.center)
                        .accessibilityLabel(
                            "\(cluster.lineups.count) \(L10n.text(.clusteredUtilities, for: languageManager))"
                        )
                    } else if let lineup = cluster.lineups.first {
                        Button {
                            onSelect(lineup)
                        } label: {
                            UtilityPoint(lineup: lineup)
                        }
                        .buttonStyle(.plain)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                        .position(cluster.center)
                    }
                }
            }
        }
        .frame(width: containerSize.width, height: containerSize.height)
        .coordinateSpace(name: coordinateSpaceName)
    }

    private func clusteredLineups(in imageRect: CGRect) -> [LineupCluster] {
        if developerModeEnabled {
            return lineups.map { lineup in
                LineupCluster(
                    lineups: [lineup],
                    center: pointLocation(for: startCoordinate(for: lineup), in: imageRect)
                )
            }
        }

        let screenDistance: CGFloat = zoomScale > 2.0 ? 28 : 58
        var clusters: [LineupCluster] = []

        for lineup in lineups {
            let point = pointLocation(for: startCoordinate(for: lineup), in: imageRect)

            if let index = clusters.firstIndex(where: { cluster in
                distance(from: cluster.center, to: point) * max(zoomScale, 1) <= screenDistance
            }) {
                clusters[index].add(lineup, at: point)
            } else {
                clusters.append(LineupCluster(lineups: [lineup], center: point))
            }
        }

        return clusters
    }

    private func draggablePoint(
        lineup: UtilityLineup,
        kind: MapPointKind,
        imageRect: CGRect,
        pointSize: CGSize
    ) -> some View {
        EditableMapPoint(lineup: lineup, kind: kind)
            .frame(width: pointSize.width, height: pointSize.height)
            .contentShape(Rectangle())
            .highPriorityGesture(
                DragGesture(
                    minimumDistance: 0,
                    coordinateSpace: .named(coordinateSpaceName)
                )
                .onChanged { value in
                    let newCoordinate = normalizedCoordinate(
                        from: value.location,
                        in: imageRect
                    )
                    onCoordinateChanged(lineup, kind, newCoordinate)
                }
                .onEnded { value in
                    let newCoordinate = normalizedCoordinate(
                        from: value.location,
                        in: imageRect
                    )
                    onCoordinateEnded(lineup, kind, newCoordinate)
                }
            )
            .accessibilityLabel(
                "\(lineup.name.value(for: languageManager)), \(kind.displayName(for: languageManager))"
            )
    }

    private func fittedImageRect(imageSize: CGSize, containerSize: CGSize) -> CGRect {
        let imageAspectRatio = imageSize.width / imageSize.height
        let containerAspectRatio = containerSize.width / containerSize.height

        let fittedSize: CGSize
        if imageAspectRatio > containerAspectRatio {
            fittedSize = CGSize(
                width: containerSize.width,
                height: containerSize.width / imageAspectRatio
            )
        } else {
            fittedSize = CGSize(
                width: containerSize.height * imageAspectRatio,
                height: containerSize.height
            )
        }

        let offsetX = (containerSize.width - fittedSize.width) / 2
        let offsetY = (containerSize.height - fittedSize.height) / 2

        return CGRect(
            x: offsetX,
            y: offsetY,
            width: fittedSize.width,
            height: fittedSize.height
        )
    }

    private func startCoordinate(for lineup: UtilityLineup) -> CGPoint {
        let key = MapPointKey(lineupID: lineup.id, kind: .start)

        if let editedCoordinate = editedCoordinates[key] {
            return editedCoordinate
        }

        return CGPoint(x: lineup.startMapX, y: lineup.startMapY)
    }

    private func targetCoordinate(for lineup: UtilityLineup) -> CGPoint? {
        let key = MapPointKey(lineupID: lineup.id, kind: .target)

        if let editedCoordinate = editedCoordinates[key] {
            return editedCoordinate
        }

        return lineup.targetCoordinate
    }

    private func pointLocation(for coordinate: CGPoint?, in imageRect: CGRect) -> CGPoint {
        guard let coordinate else {
            return .zero
        }

        return CGPoint(
            x: imageRect.minX + imageRect.width * coordinate.x,
            y: imageRect.minY + imageRect.height * coordinate.y
        )
    }

    private func normalizedCoordinate(from location: CGPoint, in imageRect: CGRect) -> CGPoint {
        let mapX = (location.x - imageRect.minX) / imageRect.width
        let mapY = (location.y - imageRect.minY) / imageRect.height

        return CGPoint(
            x: clamped(mapX),
            y: clamped(mapY)
        )
    }

    private func distance(from firstPoint: CGPoint, to secondPoint: CGPoint) -> CGFloat {
        let deltaX = firstPoint.x - secondPoint.x
        let deltaY = firstPoint.y - secondPoint.y

        return sqrt(deltaX * deltaX + deltaY * deltaY)
    }

    private func clamped(_ value: CGFloat) -> CGFloat {
        min(max(value, 0), 1)
    }
}

private struct UtilityPoint: View {
    @EnvironmentObject private var languageManager: LanguageManager

    let lineup: UtilityLineup

    var body: some View {
        Text(lineup.type.symbol)
            .font(.headline)
            .foregroundStyle(lineup.type == .flash ? .black : .white)
            .frame(width: 34, height: 34)
            .background(lineup.type.color)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.white, lineWidth: 2)
            }
            .shadow(radius: 3)
            .frame(width: 44, height: 44)
            .accessibilityLabel(
                "\(lineup.name.value(for: languageManager)), \(lineup.type.displayName(for: languageManager))"
            )
    }
}

private struct ClusterPoint: View {
    let count: Int

    var body: some View {
        Text("\(count)")
            .font(.headline.weight(.bold))
            .foregroundStyle(.white)
            .frame(width: 36, height: 36)
            .background(Color.accentColor)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.white, lineWidth: 2)
            }
            .shadow(radius: 4)
            .frame(width: 44, height: 44)
    }
}

private struct TargetPoint: View {
    let lineup: UtilityLineup

    var body: some View {
        Circle()
            .fill(lineup.type.color)
            .frame(width: 16, height: 16)
            .overlay {
                Circle()
                    .stroke(.white, lineWidth: 2)
            }
            .shadow(radius: 2)
    }
}

private struct EditableMapPoint: View {
    @EnvironmentObject private var languageManager: LanguageManager

    let lineup: UtilityLineup
    let kind: MapPointKind

    var body: some View {
        ZStack {
            if kind == .start {
                UtilityPoint(lineup: lineup)
            } else {
                TargetPoint(lineup: lineup)
                    .frame(width: 44, height: 44)
            }

            Text(labelText)
                .font(.caption2)
                .lineLimit(1)
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .foregroundStyle(.primary)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .offset(y: 34)
        }
    }

    private var labelText: String {
        "\(shortName) \(kind.displayName(for: languageManager))"
    }

    private var shortName: String {
        let name = lineup.name.value(for: languageManager)
        let parts = name.split(separator: " ")

        if parts.count > 1 {
            return parts.prefix(2).joined(separator: " ")
        }

        return name
    }
}

private struct ClusterLineupSheet: View {
    @EnvironmentObject private var languageManager: LanguageManager
    @Environment(\.dismiss) private var dismiss

    let cluster: LineupCluster
    let onSelect: (UtilityLineup) -> Void

    var body: some View {
        NavigationStack {
            List(cluster.lineups) { lineup in
                Button {
                    dismiss()
                    onSelect(lineup)
                } label: {
                    HStack(spacing: 12) {
                        UtilityPoint(lineup: lineup)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(lineup.name.value(for: languageManager))
                                .font(.headline)
                            Text(lineup.type.displayName(for: languageManager))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
            .navigationTitle(L10n.text(.clusteredUtilities, for: languageManager))
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.medium])
    }
}

private enum MapAreaFilter: CaseIterable, Hashable, Identifiable {
    case featured
    case aSite
    case bSite
    case mid
    case tSide
    case ctSide

    var id: Self {
        self
    }

    func displayName(for languageManager: LanguageManager) -> String {
        switch self {
        case .featured:
            return L10n.text(.mapFilterFeatured, for: languageManager)
        case .aSite:
            return LineupCategory.aSite.displayName(for: languageManager)
        case .bSite:
            return LineupCategory.bSite.displayName(for: languageManager)
        case .mid:
            return LineupCategory.mid.displayName(for: languageManager)
        case .tSide:
            return LineupCategory.tSide.displayName(for: languageManager)
        case .ctSide:
            return LineupCategory.ctSide.displayName(for: languageManager)
        }
    }

    func matches(_ lineup: UtilityLineup) -> Bool {
        switch self {
        case .featured:
            return lineup.isFeatured
        case .aSite:
            return lineup.category == .aSite
        case .bSite:
            return lineup.category == .bSite
        case .mid:
            return lineup.category == .mid
        case .tSide:
            return lineup.category == .tSide
        case .ctSide:
            return lineup.category == .ctSide
        }
    }
}

private enum MapUtilityTypeFilter: CaseIterable, Hashable, Identifiable {
    case all
    case smoke
    case flash
    case molotov
    case he

    var id: Self {
        self
    }

    func displayName(for languageManager: LanguageManager) -> String {
        switch self {
        case .all:
            return L10n.text(.mapFilterAll, for: languageManager)
        case .smoke:
            return UtilityType.smoke.displayName(for: languageManager)
        case .flash:
            return UtilityType.flash.displayName(for: languageManager)
        case .molotov:
            return UtilityType.molotov.displayName(for: languageManager)
        case .he:
            return UtilityType.he.displayName(for: languageManager)
        }
    }

    func matches(_ lineup: UtilityLineup) -> Bool {
        switch self {
        case .all:
            return true
        case .smoke:
            return lineup.type == .smoke
        case .flash:
            return lineup.type == .flash
        case .molotov:
            return lineup.type == .molotov
        case .he:
            return lineup.type == .he
        }
    }
}

private struct LineupCluster: Identifiable {
    var lineups: [UtilityLineup]
    var center: CGPoint

    var id: String {
        lineups.map { $0.id.uuidString }.joined(separator: "-")
    }

    mutating func add(_ lineup: UtilityLineup, at point: CGPoint) {
        let existingCount = CGFloat(lineups.count)
        center = CGPoint(
            x: (center.x * existingCount + point.x) / (existingCount + 1),
            y: (center.y * existingCount + point.y) / (existingCount + 1)
        )
        lineups.append(lineup)
    }
}

private enum MapPointKind: String, Hashable {
    case start
    case target

    func displayName(for languageManager: LanguageManager) -> String {
        switch self {
        case .start:
            return L10n.text(.startPoint, for: languageManager)
        case .target:
            return L10n.text(.targetPoint, for: languageManager)
        }
    }

    var xFieldName: String {
        switch self {
        case .start:
            return "startMapX"
        case .target:
            return "targetMapX"
        }
    }

    var yFieldName: String {
        switch self {
        case .start:
            return "startMapY"
        case .target:
            return "targetMapY"
        }
    }
}

private struct MapPointKey: Hashable {
    let lineupID: UUID
    let kind: MapPointKind
}

private struct EditedLineupCoordinate: Identifiable {
    let id: MapPointKey
    let lineupName: String
    let kind: MapPointKind
    let mapX: Double
    let mapY: Double

    var coordinateText: String {
        String(
            format: "%@: %.3f, %@: %.3f",
            kind.xFieldName,
            mapX,
            kind.yFieldName,
            mapY
        )
    }
}

private struct DeveloperCoordinatePanel: View {
    @EnvironmentObject private var languageManager: LanguageManager

    let coordinate: EditedLineupCoordinate?
    let statusMessage: String?
    let onCopyCoordinates: () -> Void
    let onCopyJSON: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let coordinate {
                Text(sectionTitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text("\(coordinate.lineupName) \(coordinate.kind.displayName(for: languageManager))")
                    .font(.subheadline.weight(.semibold))

                Text(coordinate.coordinateText)
                    .font(.system(.footnote, design: .monospaced))
            } else {
                Text(L10n.text(.noEditedCoordinate, for: languageManager))
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 12) {
                Button(L10n.text(.copyCoordinates, for: languageManager), action: onCopyCoordinates)
                    .disabled(coordinate == nil)

                Button(L10n.text(.copyJSON, for: languageManager), action: onCopyJSON)
            }
            .buttonStyle(.bordered)

            if let statusMessage {
                Text(statusMessage)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private var sectionTitle: String {
        if statusMessage == nil {
            return L10n.text(.liveCoordinates, for: languageManager)
        }

        return L10n.text(.lastEditedCoordinate, for: languageManager)
    }
}

private struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    let minScale: CGFloat
    let maxScale: CGFloat
    let doubleTapScale: CGFloat
    let isPointEditingEnabled: Bool
    @Binding var zoomScale: CGFloat
    let content: Content

    init(
        minScale: CGFloat,
        maxScale: CGFloat,
        doubleTapScale: CGFloat,
        isPointEditingEnabled: Bool,
        zoomScale: Binding<CGFloat>,
        @ViewBuilder content: () -> Content
    ) {
        self.minScale = minScale
        self.maxScale = maxScale
        self.doubleTapScale = doubleTapScale
        self.isPointEditingEnabled = isPointEditingEnabled
        self._zoomScale = zoomScale
        self.content = content()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        let hostingController = UIHostingController(rootView: content)

        scrollView.delegate = context.coordinator
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = maxScale
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bouncesZoom = true
        scrollView.panGestureRecognizer.minimumNumberOfTouches = isPointEditingEnabled ? 2 : 1
        scrollView.backgroundColor = .clear

        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(hostingController.view)

        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            hostingController.view.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            hostingController.view.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        ])

        let doubleTapGesture = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleDoubleTap(_:))
        )
        doubleTapGesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapGesture)

        context.coordinator.hostingController = hostingController
        context.coordinator.scrollView = scrollView

        return scrollView
    }

    func updateUIView(_ scrollView: UIScrollView, context: Context) {
        context.coordinator.parent = self
        context.coordinator.hostingController?.rootView = content
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = maxScale
        scrollView.panGestureRecognizer.minimumNumberOfTouches = isPointEditingEnabled ? 2 : 1
    }

    final class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ZoomableScrollView
        var hostingController: UIHostingController<Content>?
        weak var scrollView: UIScrollView?

        init(parent: ZoomableScrollView) {
            self.parent = parent
        }

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            hostingController?.view
        }

        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            let newZoomScale = scrollView.zoomScale

            if abs(parent.zoomScale - newZoomScale) > 0.01 {
                DispatchQueue.main.async {
                    self.parent.zoomScale = newZoomScale
                }
            }
        }

        @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
            guard let scrollView else {
                return
            }

            if scrollView.zoomScale > parent.minScale {
                scrollView.setZoomScale(parent.minScale, animated: true)
                return
            }

            let tapPoint = gesture.location(in: hostingController?.view)
            let zoomSize = CGSize(
                width: scrollView.bounds.width / parent.doubleTapScale,
                height: scrollView.bounds.height / parent.doubleTapScale
            )
            let zoomRect = CGRect(
                x: tapPoint.x - zoomSize.width / 2,
                y: tapPoint.y - zoomSize.height / 2,
                width: zoomSize.width,
                height: zoomSize.height
            )

            scrollView.zoom(to: zoomRect, animated: true)
        }
    }
}

#Preview {
    let languageManager = LanguageManager()
    let developerSettings = DeveloperSettings()

    NavigationStack {
        TacticalMapView(
            mapName: L10n.text(.mirage, for: languageManager),
            lineups: LineupStore.mirageLineups
        )
        .environmentObject(languageManager)
        .environmentObject(developerSettings)
    }
}
