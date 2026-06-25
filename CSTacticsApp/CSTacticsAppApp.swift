import SwiftUI

@main
struct CSTacticsAppApp: App {
    @StateObject private var languageManager = LanguageManager()
    @StateObject private var developerSettings = DeveloperSettings()
    @StateObject private var favoriteStore = FavoriteStore()

    var body: some Scene {
        WindowGroup {
            MapListView()
                .environmentObject(languageManager)
                .environmentObject(developerSettings)
                .environmentObject(favoriteStore)
        }
    }
}
