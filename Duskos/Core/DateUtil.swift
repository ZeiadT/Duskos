import Foundation

enum DateUtil {

    static func extractHour(from timeString: String) -> Int {
        let parts = timeString.split(separator: " ")
        guard parts.count > 1 else { return 0 }
        let timePart = String(parts[1])
        return Int(timePart.split(separator: ":").first ?? "0") ?? 0
    }

    static func formatHour(from timeString: String) -> String {
        let hour = extractHour(from: timeString)
        switch hour {
        case 0:  return "12 AM"
        case 12: return "12 PM"
        case 1..<12: return "\(hour) AM"
        default: return "\(hour - 12) PM"
        }
    }

    static func todayDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }

    static func dayTitle(from dateString: String) -> String {
        let input = DateFormatter()
        input.dateFormat = "yyyy-MM-dd"
        guard let date = input.date(from: dateString) else { return "Forecast" }
        let output = DateFormatter()
        output.dateFormat = "EEEE, MMM d"
        return output.string(from: date)
    }

    static func filteredHours(
        for forecastDay: ForecastDay,
        currentHour: Int
    ) -> [Hour] {
        guard forecastDay.date == todayDateString() else {
            return forecastDay.hour
        }
        return forecastDay.hour.filter {
            extractHour(from: $0.time) >= currentHour
        }
    }
}