import SwiftUI

@main
struct CSTacticsAppApp: App {
    @StateObject private var languageManager = LanguageManager()

    var body: some Scene {
        WindowGroup {
            MapListView()
                .environmentObject(languageManager)
        }
    }
}
