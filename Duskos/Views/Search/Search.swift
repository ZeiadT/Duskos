import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @Environment(\.dismiss) var dismiss

    @State private var searchText = ""
    @State private var showSavedAlert = false

    private var hasQuery: Bool {
        !searchText.isBlank
    }

    var body: some View {
        NavigationView {
            List {
                Section {
                    SearchBarRow(searchText: $searchText, onSubmit: search)
                }

                if hasQuery {
                    SearchActionSection(
                        searchText: searchText,
                        onSearch: search,
                        onSaveAndSearch: saveAndSearch
                    )
                }

                SavedLocationsSection(
                    locations: viewModel.savedLocations,
                    onSelect: { location in
                        viewModel.fetchWeather(cityName: location.query)
                        dismiss()
                    },
                    onDelete: viewModel.removeLocation
                )
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !viewModel.savedLocations.isEmpty {
                        EditButton()
                    }
                }
            }
            .alert("Location Saved ✓", isPresented: $showSavedAlert) {
                Button("OK") { dismiss() }
            } message: {
                Text("\"\(searchText)\" has been saved to your locations and weather is loading.")
            }
        }
    }

    // MARK: - Actions
    private func search() {
        let city = searchText.trimmed
        guard !city.isBlank else { return }
        viewModel.fetchWeather(cityName: city)
        dismiss()
    }

    private func saveAndSearch() {
        let city = searchText.trimmed
        guard !city.isBlank else { return }
        viewModel.addLocation(name: city, query: city)
        viewModel.fetchWeather(cityName: city)
        showSavedAlert = true
    }
}

// MARK: - Preview
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(WeatherViewModel())
    }
}