//
//  ContentView.swift
//  Duskos
//
//  Created by Zeiad Mohammed on 06/06/2026.
//


import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        NavigationView {
            HomeView()
        }
        .navigationViewStyle(.stack)
        .onAppear {
            viewModel.fetchWeather(lat: 30.0715495, lon: 31.0215953)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(WeatherViewModel())
    }
}
