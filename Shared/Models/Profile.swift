
import Foundation

// MARK: - WelcomeElement
struct Profile: Codable {
    let name: String
    let upgradeAllowed: Bool
    let cutoff: QualityDetails
    let items: [Item]
    let id: Int
}

// MARK: - Cutoff
struct QualityDetails: Codable {
    let id: Int
    let name: String
    let source: String
    let resolution: Int
}

// MARK: - Item
struct Item: Codable {
    let quality: QualityDetails
    let allowed: Bool
}

