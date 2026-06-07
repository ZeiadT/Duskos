import Foundation

struct WeatherResponse: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

struct Location: Codable {
    let name: String
}

struct Current: Codable {
    let temp_c: Double
    let feelslike_c: Double
    let humidity: Int
    let vis_km: Double
    let pressure_mb: Double
    let condition: Condition
}

struct Condition: Codable {
    let text: String
    let icon: String
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable, Identifiable {
    var id: String { date }
    let date: String
    let day: Day
    let hour: [Hour]
}

struct Day: Codable {
    let maxtemp_c: Double
    let mintemp_c: Double
    let condition: Condition
}

struct Hour: Codable, Identifiable {
    var id: String { time }
    let time: String
    let temp_c: Double
    let condition: Condition
}
