import Foundation

typealias ErrorHandler = (String) -> Void
typealias SuccessHandler = (WeatherResponse) -> Void

class NetworkClient{
    
    private let apiKey = "c8f3d8a56cd64bd28ea164350260506"
    private let baseUrl = "https://api.weatherapi.com/v1/forecast.json"
    
    static let shared = NetworkClient()
    private init() {}
    
    
    // MARK: - Fetch by lat/lon
    func fetchWeather(lat: Double, lon: Double, onError: @escaping ErrorHandler, onSuccess: @escaping SuccessHandler) {
        let query = "\(lat),\(lon)"
        fetchWeather(query: query, onError: onError, onSuccess: onSuccess)
    }

    // MARK: - Fetch by city name
    func fetchWeather(cityName: String, onError: @escaping ErrorHandler, onSuccess: @escaping SuccessHandler) {
        fetchWeather(query: cityName, onError: onError, onSuccess: onSuccess)
    }

    // MARK: - Core fetch method
    private func fetchWeather(query: String, onError: @escaping ErrorHandler, onSuccess: @escaping SuccessHandler) {
        
        let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        let urlString = "\(baseUrl)?key=\(apiKey)&q=\(encoded)&days=3&aqi=no&alerts=no"

        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                onError("Invalid URL")
            }
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                
                if let error = error {
                    onError("Network error: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    onError("No data received")
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    onSuccess(decoded)
                } catch {
                    onError("Could not load weather. Check your API key.")
                }
            }
        }.resume()
    }
}
