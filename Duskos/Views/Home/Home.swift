import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @State private var showSearch = false

    private var textColor: Color {
        viewModel.isMorning ? .black : .white
    }

    var body: some View {
        ZStack {
            AppBackground(isMorning: viewModel.isMorning)
                .ignoresSafeArea()

            if viewModel.isLoading {
                WeatherStateView(state: .loading, textColor: textColor)

            } else if let error = viewModel.errorMessage {
                WeatherStateView(state: .error(error), textColor: textColor)

            } else if let weather = viewModel.weatherData {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        WeatherTopSection(
                            weather: weather,
                            textColor: textColor
                        )

                        ForecastSection(
                            weather: weather,
                            textColor: textColor,
                            isMorning: viewModel.isMorning,
                            viewModel: viewModel
                        )

                        bottomSection(weather: weather)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button { showSearch = true } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(textColor)
                        .font(.system(size: 18, weight: .medium))
                }
            }
        }
        .sheet(isPresented: $showSearch) {
            SearchView().environmentObject(viewModel)
        }
    }

    @ViewBuilder
    private func bottomSection(weather: WeatherResponse) -> some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                StatCard(
                    icon: "eye.fill",
                    title: "VISIBILITY",
                    value: "\(Int(weather.current.vis_km)) km",
                    textColor: textColor,
                    isMorning: viewModel.isMorning
                )
                StatCard(
                    icon: "humidity.fill",
                    title: "HUMIDITY",
                    value: "\(weather.current.humidity)%",
                    textColor: textColor,
                    isMorning: viewModel.isMorning
                )
            }
            HStack(spacing: 12) {
                StatCard(
                    icon: "thermometer",
                    title: "FEELS LIKE",
                    value: "\(Int(weather.current.feelslike_c))°",
                    textColor: textColor,
                    isMorning: viewModel.isMorning
                )
                StatCard(
                    icon: "gauge",
                    title: "PRESSURE",
                    value: "\(Int(weather.current.pressure_mb))",
                    textColor: textColor,
                    isMorning: viewModel.isMorning
                )
            }
        }
    }
}

struct WeatherStateView: View {
    enum State {
        case loading
        case error(String)
    }

    let state: State
    let textColor: Color

    var body: some View {
        switch state {
        case .loading:
            VStack(spacing: 16) {
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(textColor)
                Text("Loading weather...")
                    .foregroundColor(textColor)
                    .font(.body)
            }

        case .error(let message):
            VStack(spacing: 20) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.orange)
                Text(message)
                    .foregroundColor(textColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(WeatherViewModel())
        }
    }
}
