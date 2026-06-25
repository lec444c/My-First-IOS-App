import SwiftUI
import UIKit

struct TacticalMapView: View {
    @EnvironmentObject private var languageManager: LanguageManager
    @State private var selectedLineup: UtilityLineup?

    let mapName: String
    let lineups: [UtilityLineup]

    var body: some View {
        GeometryReader { geometry in
            let availableWidth = max(geometry.size.width - 32, 1)
            let availableHeight = max(geometry.size.height - 72, 1)
            let mapContainerSize = CGSize(width: availableWidth, height: availableHeight)
            let mapImageSize = UIImage(named: "mirage_map")?.size ?? CGSize(width: 1, height: 1)

            VStack(spacing: 16) {
                ZoomableScrollView(
                    minScale: 1.0,
                    maxScale: 4.0,
                    doubleTapScale: 2.5
                ) {
                    MapCanvas(
                        containerSize: mapContainerSize,
                        imageSize: mapImageSize,
                        lineups: lineups,
                        onSelect: { lineup in
                            selectedLineup = lineup
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

                Text(L10n.text(.tapUtilityHint, for: languageManager))
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
        .navigationTitle(mapName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $selectedLineup) { lineup in
            LineupDetailView(lineup: lineup)
        }
    }
}

private struct MapCanvas: View {
    let containerSize: CGSize
    let imageSize: CGSize
    let lineups: [UtilityLineup]
    let onSelect: (UtilityLineup) -> Void

    var body: some View {
        let imageRect = fittedImageRect(
            imageSize: imageSize,
            containerSize: containerSize
        )

        ZStack {
            Image("mirage_map")
                .resizable()
                .scaledToFit()
                .frame(width: containerSize.width, height: containerSize.height)

            ForEach(lineups) { lineup in
                Button {
                    onSelect(lineup)
                } label: {
                    UtilityPoint(lineup: lineup)
                }
                .buttonStyle(.plain)
                .frame(width: 44, height: 44)
                .contentShape(Rectangle())
                .position(
                    x: imageRect.minX + imageRect.width * lineup.mapX,
                    y: imageRect.minY + imageRect.height * lineup.mapY
                )
            }
        }
        .frame(width: containerSize.width, height: containerSize.height)
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
            .accessibilityLabel("\(lineup.name.value(for: languageManager)), \(lineup.type.displayName(for: languageManager))")
    }
}

private struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    let minScale: CGFloat
    let maxScale: CGFloat
    let doubleTapScale: CGFloat
    let content: Content

    init(
        minScale: CGFloat,
        maxScale: CGFloat,
        doubleTapScale: CGFloat,
        @ViewBuilder content: () -> Content
    ) {
        self.minScale = minScale
        self.maxScale = maxScale
        self.doubleTapScale = doubleTapScale
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

    NavigationStack {
        TacticalMapView(
            mapName: L10n.text(.mirage, for: languageManager),
            lineups: LineupStore.mirageLineups
        )
        .environmentObject(languageManager)
    }
}
