import Foundation

struct SavedLocation: Identifiable, Codable {
    var id = UUID()
    let name: String
    let query: String
}
