import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    private let client :NetworkClient = NetworkClient.shared

    @Published var weatherData: WeatherResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var savedLocations: [SavedLocation] = []
    
    
    lazy var onError: ErrorHandler = { [weak self] errMsg in
        guard let self = self else { return }
        self.isLoading = false
        self.errorMessage = errMsg
    }
    lazy var onSuccess: SuccessHandler = { [weak self] response in
        guard let self = self else { return }
        self.isLoading = false
        self.weatherData = response
    }

    // MARK: - Saved locations
    func addLocation(name: String, query: String) {
        guard !savedLocations.contains(where: { $0.name.lowercased() == name.lowercased() }) else { return }
        savedLocations.append(SavedLocation(name: name, query: query))
    }

    func removeLocation(at offsets: IndexSet) {
        savedLocations.remove(atOffsets: offsets)
    }
    
    // MARK: - Fetch Weather Data
    func fetchWeather(cityName: String){
        isLoading = true
        client.fetchWeather(cityName: cityName, onError: onError, onSuccess: onSuccess)
    }
    func fetchWeather(lat: Double, lon: Double){
        isLoading = true
        client.fetchWeather(lat: lat, lon: lon, onError: onError, onSuccess: onSuccess)
    }

    var isMorning: Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour >= 5 && hour < 18
    }
}