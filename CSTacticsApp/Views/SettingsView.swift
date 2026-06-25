import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var languageManager: LanguageManager
    @EnvironmentObject private var developerSettings: DeveloperSettings

    var body: some View {
        Form {
            Picker(
                L10n.text(.language, for: languageManager),
                selection: $languageManager.selectedLanguage
            ) {
                Text(L10n.text(.followSystem, for: languageManager))
                    .tag(AppLanguage.system)
                Text(L10n.text(.simplifiedChinese, for: languageManager))
                    .tag(AppLanguage.zhHans)
                Text(L10n.text(.english, for: languageManager))
                    .tag(AppLanguage.en)
            }

            Section {
                Toggle(
                    L10n.text(.developerMode, for: languageManager),
                    isOn: $developerSettings.isDeveloperModeEnabled
                )
            }
        }
        .navigationTitle(L10n.text(.settings, for: languageManager))
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(LanguageManager())
            .environmentObject(DeveloperSettings())
    }
}
