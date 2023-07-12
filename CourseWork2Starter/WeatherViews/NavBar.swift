//
//  NavBar.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct NavBar: View {
    
    var body: some View {
        TabView{
            Home()
                .tabItem {
                    Label("City", systemImage: "magnifyingglass")
                }
            
            CurrentWeatherView()
                .tabItem {
                    Label("Weather Now", systemImage: "sun.max.fill")
                }
            
            HourlyView()
                .tabItem {
                    Label("Hourly Summary", systemImage: "clock.fill")
                }
            
            ForecastView()
                .tabItem {
                    Label("Forecast", systemImage: "calendar")
                }
            
            PollutionView()
                .tabItem {
                    Label("Pollution", systemImage: "aqi.high")
                }
        }.onAppear {
            UITabBar.appearance().isTranslucent = false
        }
        
    }
        
}

