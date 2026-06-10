import SwiftUI

struct ForecastView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    let forecastDay: ForecastDay

    private let currentHour = Calendar.current.component(.hour, from: Date())

    private var textColor: Color {
        viewModel.isMorning ? .black : .white
    }

    private var isToday: Bool {
        forecastDay.date == DateUtil.todayDateString()
    }

    private var filteredHours: [Hour] {
        DateUtil.filteredHours(
            for: forecastDay,
            currentHour: currentHour
        )
    }

    var body: some View {
        ZStack {
            AppBackground(isMorning: viewModel.isMorning)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(Array(filteredHours.enumerated()), id: \.element.id) { index, hour in
                        HourRowView(
                            hour: hour,
                            isFirst: index == 0,
                            isToday: isToday,
                            textColor: textColor
                        )

                        if index < filteredHours.count - 1 {
                            Divider()
                                .background(textColor.opacity(0.20))
                                .padding(.horizontal, 20)
                        }
                    }
                }
                .background(
                    viewModel.isMorning
                        ? .white.opacity(0.40)
                        : .black.opacity(0.40)
                )
                .cornerRadius(18)
                .padding(.horizontal, 16)
                .padding(.top, 20)
                .padding(.bottom, 30)
            }
        }
        .navigationTitle(DateUtil.dayTitle(from: forecastDay.date))
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ForecastView(forecastDay: ForecastDay(
                date: "2024-01-15",
                day: Day(
                    maxtemp_c: 20,
                    mintemp_c: 10,
                    condition: Condition(
                        text: "Sunny",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"
                    )
                ),
                hour: []
            ))
            .environmentObject(WeatherViewModel())
        }
    }
}