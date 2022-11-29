//
//  ContentView.swift
//  WeatherApp
//
//  Created by Андрей Худик on 29.11.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                              weather = try await weatherManager.gerCurrentWeather(latitude: location.latitude, longtitude: location.longitude)
                            } catch {
                                print("Erorr gettting weather: \(error)")
                            }
                        }
                }
            } else if locationManager.isLoading {
                LoadingView()
            } else {
                WelcomeView()
                    .environmentObject(locationManager)
            }
        }
        .background(Color(hue: 0.642, saturation: 0.561, brightness: 0.269))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
