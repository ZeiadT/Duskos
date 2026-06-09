import SwiftUI

struct WeatherTopSection: View {
    let weather: WeatherResponse
    let textColor: Color

    var body: some View {
        VStack(spacing: 6) {
            Text(weather.location.name)
                .font(.system(size: 34, weight: .medium))
                .foregroundColor(textColor)

            Text("\(Int(weather.current.temp_c))°")
                .font(.system(size: 80, weight: .thin))
                .foregroundColor(textColor)

            Text(weather.current.condition.text)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(textColor.opacity(0.85))

            if let today = weather.forecast.forecastday.first {
                Text("H:\(Int(today.day.maxtemp_c))°  L:\(Int(today.day.mintemp_c))°")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(textColor.opacity(0.80))
            }

            AsyncImage(url: URL(string: "https:" + weather.current.condition.icon)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFit()
                        .frame(width: 72, height: 72)
                case .failure:
                    Image(systemName: "cloud.sun.fill")
                        .resizable().scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.yellow)
                case .empty:
                    ProgressView().frame(width: 72, height: 72)
                @unknown default:
                    EmptyView()
                }
            }
        }
        .padding(.top, 20)
    }
}