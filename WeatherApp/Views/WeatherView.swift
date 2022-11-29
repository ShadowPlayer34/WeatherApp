//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Андрей Худик on 29.11.22.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            if weather.weather[0].main == "Sun" {
                                Image(systemName: "sun.max")
                                    .font(.system(size: 40))
                            } else if weather.weather[0].main == "Rain" {
                                Image(systemName: "cloud.rain")
                                    .font(.system(size: 40))
                            } else if weather.weather[0].main == "Clouds" {
                                Image(systemName: "cloud")
                                    .font(.system(size: 40))
                            }
                            
                            Text(weather.weather[0].main)
                        }
                        .frame(maxWidth: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(weather.main.feels_like.roundDouble() + "°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    Spacer()
                        .frame(height: 80)
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                VStack{
                    Text("Weather now")
                        .bold()
                        .padding(.bottom)
                        .padding(.top)
                    HStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            if #available(iOS 16, *) {
                                WeatherRow(logo: "thermometer.low", name: "Min Temp", value: (weather.main.temp_min.roundDouble() + "°"))
                            } else {
                                WeatherRow(logo: "thermometer", name: "Min Temp", value: (weather.main.temp_min.roundDouble() + "°"))
                            }
                            Spacer()
                                .frame(maxHeight: 20)
                            WeatherRow(logo: "wind", name: "Wind Speed", value: (weather.wind.speed.roundDouble() + "m/s"))
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            if #available(iOS 16, *) {
                                WeatherRow(logo: "thermometer.high", name: "Min Temp", value: (weather.main.temp_min.roundDouble() + "°"))
                            } else {
                                WeatherRow(logo: "thermometer", name: "Max Temp", value: (weather.main.temp_max.roundDouble() + "°"))
                            }
                            Spacer()
                                .frame(maxHeight: 20)
                            WeatherRow(logo: "humidity", name: "Humidity", value: (weather.main.humidity.roundDouble() + "%"))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.642, saturation: 0.561, brightness: 0.269))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.642, saturation: 0.561, brightness: 0.269))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
