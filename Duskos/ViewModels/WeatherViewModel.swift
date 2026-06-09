import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var savedLocations: [SavedLocation] = []

    // MARK: - Saved locations
    func addLocation(name: String, query: String) {
        guard !savedLocations.contains(where: { $0.name.lowercased() == name.lowercased() }) else { return }
        savedLocations.append(SavedLocation(name: name, query: query))
    }

    func removeLocation(at offsets: IndexSet) {
        savedLocations.remove(atOffsets: offsets)
    }
}