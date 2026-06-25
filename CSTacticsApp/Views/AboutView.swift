import SwiftUI
import UIKit

struct AboutView: View {
    @EnvironmentObject private var languageManager: LanguageManager

    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AboutCard {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(L10n.text(.appDisplayName, for: languageManager))
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)

                        Text(L10n.text(.appIntro, for: languageManager))
                            .font(.body)
                            .foregroundStyle(.white.opacity(0.82))
                    }
                }

                AboutCard {
                    VStack(spacing: 12) {
                        CreatorAvatarView(imageName: "creator_avatar")

                        Text(L10n.text(.creatorName, for: languageManager))
                            .font(.title3.bold())
                            .foregroundStyle(.white)

                        infoRow(
                            title: L10n.text(.appName, for: languageManager),
                            value: L10n.text(.appDisplayName, for: languageManager)
                        )
                        infoRow(
                            title: L10n.text(.creator, for: languageManager),
                            value: L10n.text(.creatorName, for: languageManager)
                        )
                        infoRow(
                            title: L10n.text(.version, for: languageManager),
                            value: appVersion
                        )
                    }
                }

                textCard(
                    title: L10n.text(.unofficialNotice, for: languageManager),
                    body: L10n.text(.unofficialNoticeText, for: languageManager)
                )

                textCard(
                    title: L10n.text(.acknowledgements, for: languageManager),
                    body: L10n.text(.acknowledgementsText, for: languageManager)
                )
            }
            .padding(16)
        }
        .background(Color(red: 0.06, green: 0.07, blue: 0.08).ignoresSafeArea())
        .navigationTitle(L10n.text(.about, for: languageManager))
        .navigationBarTitleDisplayMode(.inline)
    }

    private func infoRow(title: String, value: String) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .foregroundStyle(.white.opacity(0.62))
            Spacer()
            Text(value)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .multilineTextAlignment(.trailing)
        }
    }

    private func textCard(title: String, body: String) -> some View {
        AboutCard {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.white)
                Text(body)
                    .font(.body)
                    .foregroundStyle(.white.opacity(0.82))
            }
        }
    }
}

private struct CreatorAvatarView: View {
    let imageName: String

    var body: some View {
        Group {
            if let image = UIImage(named: imageName) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white.opacity(0.72))
            }
        }
        .frame(width: 96, height: 96)
        .clipShape(Circle())
        .overlay {
            Circle()
                .stroke(.white.opacity(0.18), lineWidth: 1)
        }
    }
}

private struct AboutCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Color(red: 0.12, green: 0.13, blue: 0.15))
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NavigationStack {
        AboutView()
            .environmentObject(LanguageManager())
    }
}
