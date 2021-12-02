import Foundation

struct System: Codable {
    let version: String?
    let buildTime: String?
    let isDebug, isProduction, isAdmin, isUserInteractive: Bool?
    let startupPath, appData, osName, osVersion: String?
    let isMonoRuntime, isMono, isLinux, isOsx: Bool?
    let isWindows: Bool?
    let mode, branch, authentication, sqliteVersion: String?
    let urlBase, runtimeVersion, runtimeName, startTime: String?
    let packageVersion, packageAuthor, packageUpdateMechanism: String?
}
