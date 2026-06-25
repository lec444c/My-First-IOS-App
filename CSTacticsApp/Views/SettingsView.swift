import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var languageManager: LanguageManager

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
        }
        .navigationTitle(L10n.text(.settingsTitle, for: languageManager))
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(LanguageManager())
    }
}
