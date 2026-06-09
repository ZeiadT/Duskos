import SwiftUI

struct ForecastSection: View {
    let weather: WeatherResponse
    let textColor: Color
    let isMorning: Bool
    let viewModel: WeatherViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            sectionHeader
            Divider().background(textColor.opacity(0.25))
            forecastRows
            Spacer(minLength: 14)
        }
        .background(isMorning ? .white.opacity(0.40) : .black.opacity(0.40))
        .cornerRadius(18)
    }

    private var sectionHeader: some View {
        HStack {
            Image(systemName: "calendar")
                .font(.caption)
                .foregroundColor(textColor.opacity(0.6))
            Text("3-DAY FORECAST")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(textColor.opacity(0.6))
                .kerning(1)
        }
        .padding(.horizontal, 16)
        .padding(.top, 14)
        .padding(.bottom, 10)
    }

    private var forecastRows: some View {
        ForEach(Array(weather.forecast.forecastday.enumerated()), id: \.offset) { index, day in
            NavigationLink(
                destination: ForecastView(forecastDay: day)
                    .environmentObject(viewModel)
            ) {
                ForecastRowView(index: index, day: day, textColor: textColor)
            }
            .buttonStyle(PlainButtonStyle())

            if index < weather.forecast.forecastday.count - 1 {
                Divider()
                    .background(textColor.opacity(0.20))
                    .padding(.horizontal, 16)
            }
        }
    }
}
