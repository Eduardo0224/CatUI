import Foundation
import CoreText

// MARK: - CatFontRegistration

/// Registers custom fonts bundled with CatUI. Call once at app startup.
/// Safe to call multiple times — duplicates are silently ignored.
public enum CatFontRegistration {

    /// Register all bundled Coolvetica fonts.
    public static func registerAll() {
        registerFonts(withExtension: "otf")
        registerFonts(withExtension: "ttf")
    }

    // MARK: - Private

    private static func registerFonts(withExtension ext: String) {
        guard let bundleURL = Bundle.module.resourceURL else {
            print("[CatUI] Bundle resource URL not found")
            return
        }

        let fileManager = FileManager.default
        guard let enumerator = fileManager.enumerator(
            at: bundleURL,
            includingPropertiesForKeys: nil,
            options: [.skipsHiddenFiles, .skipsPackageDescendants]
        ) else { return }

        for case let fileURL as URL in enumerator where fileURL.pathExtension == ext {
            var error: Unmanaged<CFError>?
            if CTFontManagerRegisterFontsForURL(fileURL as CFURL, .process, &error) {
                // Successfully registered — nothing to log
            } else if let cfError = error?.takeRetainedValue() {
                let code = CTFontManagerError(rawValue: CFErrorGetCode(cfError))
                switch code {
                case .alreadyRegistered, .duplicatedName:
                    // Already registered by SPM — expected, not an error
                    break
                default:
                    print("[CatUI] Font registration error for \(fileURL.lastPathComponent): \(cfError.localizedDescription)")
                }
            }
        }
    }
}
