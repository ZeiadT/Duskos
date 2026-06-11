# Duskos - Weather Application

A beautiful and intuitive iOS weather application built with SwiftUI that provides real-time weather information, hourly forecasts, and location management.

## Overview

Duskos is a modern weather app that delivers comprehensive weather data with an elegant user interface. The app features dynamic theming based on time of day (morning/evening), real-time weather updates, and the ability to save and manage multiple locations.

## Features

✨ **Core Features**
- 🌤️ Real-time weather data with current conditions
- 📍 Search weather by city name or coordinates
- 💾 Save and manage multiple favorite locations
- 📅 3-day weather forecast with hourly breakdown
- 🌅 Dynamic day/night theming (morning/evening UI adaptation)

📊 **Weather Details**
- Current temperature and "feels like" temperature
- Weather condition descriptions with icons
- Humidity percentage
- Visibility in kilometers
- Atmospheric pressure in millibars
- Hourly temperature tracking
- Min/max daily temperatures

🎨 **User Experience**
- Clean and intuitive navigation
- Smooth transitions and animations
- Responsive loading states
- Error handling and user-friendly messages
- Search functionality with saved locations sidebar

## Architecture

### MVVM (Model-View-ViewModel)

The app follows the MVVM architectural pattern:

```
Views/
├── Home/           # Main weather display screen
├── Search/         # Location search and management
└── Forecast/       # Detailed forecast view

ViewModels/
└── WeatherViewModel.swift

Model/
├── WeatherModel.swift       # Data structures
├── NetworkClient.swift      # API communication
└── SavedLocation.swift      # Location management

Core/
├── DateUtil.swift           # Date utilities
└── StringExtensions.swift   # String helpers
```

## Project Structure

```
Duskos/
├── DuskosApp.swift                          # App entry point
├── ContentView.swift                        # Main navigation setup
├── Model/
│   ├── WeatherModel.swift                  # Weather API response models
│   ├── NetworkClient.swift                 # WeatherAPI integration
│   └── SavedLocation.swift                 # Saved location model
├── ViewModels/
│   └── WeatherViewModel.swift              # State management & business logic
├── Views/
│   ├── Component/
│   │   └── AppBackground.swift             # Dynamic background view
│   ├── Home/
│   │   ├── Home.swift                      # Main weather display
│   │   └── Component/
│   │       ├── WeatherTopSection.swift     # Current weather header
│   │       ├── ForecastSection.swift       # 3-day forecast view
│   │       ├── ForecastRowView.swift       # Individual day forecast
│   │       └── StatCard.swift              # Weather stat cards
│   ├── Search/
│   │   ├── Search.swift                    # Location search screen
│   │   └── Component/
│   │       ├── SearchBarRow.swift          # Search input field
│   │       ├── SearchActionSection.swift   # Action buttons
│   │       └── SavedLocationsSection.swift # Saved locations list
│   └── Forecast/
│       ├── Forecast.swift                  # Forecast view
│       └── Component/
│           └── HourRow.swift               # Hourly weather item
└── Core/
    ├── DateUtil.swift                      # Date formatting utilities
    └── StringExtensions.swift              # String helper methods
```

## Requirements

- **iOS**: 14.0 or later
- **Xcode**: 13.0 or later
- **Swift**: 5.5+
- **API Key**: WeatherAPI.com account (free tier available)

## Installation

### Prerequisites

1. Have Xcode installed on your Mac
2. Get a free API key from [WeatherAPI.com](https://www.weatherapi.com)

### Setup Instructions

1. **Clone the repository** (or open existing project):
   ```bash
   git clone <repository-url>
   cd Duskos
   ```

2. **Add API Key**:
   - Open `Duskos/Model/NetworkClient.swift`
   - Replace the `apiKey` with your WeatherAPI.com key:
   ```swift
   private let apiKey = "YOUR_API_KEY_HERE"
   ```

3. **Open in Xcode**:
   ```bash
   open Duskos.xcodeproj
   ```

4. **Select a simulator or device** and press `Cmd + R` to build and run

## Usage

### Getting Started

1. **Launch the app** - The app opens to the Home screen showing weather for the default location (Cairo, Egypt: 30.0715495, 31.0215953)

2. **Search for a Location**:
   - Tap the search icon (🔍) in the top-right corner
   - Type a city name (e.g., "New York", "London")
   - Tap the search action to fetch weather

3. **Save a Location**:
   - After searching, tap the save button to add it to favorites
   - Saved locations appear in the sidebar for quick access

4. **View Weather Details**:
   - Current conditions, temperature, and "feels like" temp
   - Humidity, visibility, and pressure statistics
   - 3-day forecast with hourly breakdown

### Theme Adaptation

The app automatically adjusts its theme based on time of day:
- **Morning (5:00 - 18:00)**: Light theme with black text
- **Evening (18:00 - 5:00)**: Dark theme with white text

## API Integration

### Data Source

The app uses the **WeatherAPI.com** API which provides:
- Current weather conditions
- 3-day forecast data
- Hourly weather breakdowns
- Weather icons and descriptions

### API Endpoints

```
GET https://api.weatherapi.com/v1/forecast.json
  ?key={apiKey}
  &q={query}              # city name or lat,lon
  &days=3                 # 3-day forecast
  &aqi=no                 # air quality (disabled)
  &alerts=no              # weather alerts (disabled)
```

### Response Structure

```json
{
  "location": { "name": "City Name" },
  "current": {
    "temp_c": 25.5,
    "feelslike_c": 26.0,
    "humidity": 65,
    "vis_km": 10.0,
    "pressure_mb": 1013.25,
    "condition": { "text": "Sunny", "icon": "..." }
  },
  "forecast": {
    "forecastday": [
      {
        "date": "2026-06-11",
        "day": { "maxtemp_c": 28, "mintemp_c": 20 },
        "hour": [ /* hourly data */ ]
      }
    ]
  }
}
```

## Key Components

### WeatherViewModel
Manages application state including:
- Current weather data fetching
- Loading and error states
- Saved locations management
- Time-based theme determination

### NetworkClient
Singleton responsible for:
- API requests to WeatherAPI.com
- URL construction and encoding
- JSON response decoding
- Error handling

### Views
- **HomeView**: Main display with current weather and forecast
- **SearchView**: Location search with saved locations management
- **ForecastView**: Detailed hourly forecast display

## Technologies Used

- **SwiftUI**: Modern iOS UI framework
- **Combine**: Reactive programming framework for state management
- **Foundation**: URLSession for networking
- **Codable**: JSON serialization/deserialization

## File Descriptions

| File | Purpose |
|------|---------|
| `DuskosApp.swift` | App entry point and window group setup |
| `ContentView.swift` | Navigation setup and initial location fetch |
| `WeatherViewModel.swift` | State management and business logic |
| `NetworkClient.swift` | API communication and data fetching |
| `WeatherModel.swift` | Codable data structures for API responses |
| `SavedLocation.swift` | Model for user-saved locations |
| `HomeView.swift` | Main weather display screen |
| `SearchView.swift` | Location search interface |
| `AppBackground.swift` | Dynamic background theming |

## Contributing

When contributing to this project:

1. Follow Swift naming conventions (camelCase for variables/functions, PascalCase for types)
2. Use descriptive variable and function names
3. Add comments only for non-obvious logic
4. Test on both light and dark themed devices
5. Ensure API key is never committed (use `.env` or secrets management)

## Git Workflow

```bash
# Create a feature branch
git checkout -b feature/your-feature-name

# Make your changes and commit
git add .
git commit -m "Add feature description"

# Push to remote
git push origin feature/your-feature-name
```

## Known Limitations

- Default location is hardcoded to Cairo, Egypt
- 3-day forecast only (limited by free API tier)
- No persistent local storage of weather data
- Requires internet connection for all features
- API key is visible in code (consider environment variables for production)

## Future Enhancements

- 🔔 Push notifications for severe weather
- 💾 Local data persistence with Core Data
- 🗺️ Map view integration
- 📊 Historical weather data and trends
- 🌐 Multi-language support
- 🔐 Secure API key management
- ⭐ Weather alerts and warnings

## License

[Add your license here]

## Author

**Zeiad Mohammed**
- Created: June 2026

## Support

For issues or questions:
1. Check existing issues in the repository
2. Create a new issue with detailed description
3. Include steps to reproduce for bugs

---

**Last Updated**: June 2026
**Version**: 1.0
