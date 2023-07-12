//
//  PollutionView.swift
//  Coursework2
//
//  Created by GirishALukka on 30/12/2022.
//

import SwiftUI

struct PollutionView: View {
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var pollutionData: AirModelData

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Spacer()
                
                Text(modelData.userLocation)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 20) {
                    HStack {
                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather[0].icon).png")) { phase in
                            if let image = phase.image {
                                image
                            } else if phase.error != nil {
                                Image(systemName: "exclamationmark.triangle")
                            } else {
                                ProgressView()
                            }
                        }
                        Text("\(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)")
                            .font(.headline)
                    }
                    
                    HStack {
                        Text("\((Int)(modelData.forecast!.current.temp))")
                            .font(.system(size: 150, weight: .medium, design: .default))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color(UIColor.systemGray6), Color(UIColor.lightGray)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        Text("ºC")
                    }
                    
                    VStack(spacing: 10) {
                        HStack(spacing: 15) {
                            Label("Feels Like", systemImage: "thermometer.medium")
                            Text("\((Int)(modelData.forecast!.current.feelsLike))ºC")
                        }
                        
                        HStack(spacing: 20) {
                            Label("\((Int)(modelData.forecast!.daily[0].temp.max))ºC", systemImage: "arrow.up")
                            Label("\((Int)(modelData.forecast!.daily[0].temp.min))ºC", systemImage: "arrow.down")
                        }
                    }
                    
                }
                
                Spacer()
                
                VStack(alignment: .center, spacing: 10) {
                    HStack(alignment: .center) {
                        Label("Air Quality Data", systemImage: "aqi.high")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .padding(.vertical, 10)
                            .padding(.leading)
                        Spacer()
                    }
                    .background {
                        Color
                            .white
                            .opacity(0.2)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    Spacer()
                    
                    if (pollutionData.pollution?.list[0].components != nil) {
                        HStack {
                            Spacer()
                            VStack {
                                Image("so2").resizable().scaledToFit()
                                Text("\(String(format: "%.2f", (pollutionData.pollution?.list[0].components.so2 ?? 0)))")
                                    .padding(.top, 10)
                            }
                            .padding(10)
                            Spacer()
                            VStack {
                                Image("nox").resizable().scaledToFit()
                                Text("\(String(format: "%.2f", (pollutionData.pollution?.list[0].components.no ?? 0)))")
                                    .padding(.top, 10)
                            }
                            .padding(10)
                            Spacer()
                            VStack {
                                Image("voc").resizable().scaledToFit()
                                Text("\(String(format: "%.2f", (pollutionData.pollution?.list[0].components.co ?? 0)))")
                                    .padding(.top, 10)
                            }
                            .padding(10)
                            Spacer()
                            VStack {
                                Image("pm").resizable().scaledToFit()
                                Text("\(String(format: "%.2f", (pollutionData.pollution?.list[0].components.pm10 ?? 0)))")
                                    .padding(.top, 10)
                            }
                            .padding(10)
                            Spacer()
                        }
                    } else {
                        ProgressView()
                            .foregroundColor(.white)
                    }
                    
                    
                    Spacer()
                    
                }
                .background {
                    Color
                        .white
                        .opacity(0.2)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding(.horizontal)
                
                Spacer()

            }
            .onAppear {
                Task.init {
                    try await self.pollutionData.loadAirPollution(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                }
            }
        }
        .foregroundColor(.white)
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
                .overlay(Color.black.opacity(0.7))
                .ignoresSafeArea()
        )
    }
}

struct Pollution_Previews: PreviewProvider {
    static var previews: some View {
        PollutionView()
            .environmentObject(ModelData())
            .environmentObject(AirModelData())
    }
}
