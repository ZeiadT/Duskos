import Foundation

extension String {
    var trimmed: String {
        trimmingCharacters(in: .whitespaces)
    }

    var isBlank: Bool {
        trimmed.isEmpty
    }
}