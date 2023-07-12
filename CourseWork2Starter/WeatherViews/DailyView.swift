//
//  DailyView.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct DailyView: View {
    var day : Daily
   
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(day.weather[0].icon)@2x.png")) { phase in
                if let image = phase.image {
                    image
                } else if phase.error != nil {
                    Image(systemName: "exclamationmark.triangle")
                } else {
                    ProgressView()
                }
            }
            
            Spacer()
            
            VStack {
                Text("\(day.weather[0].weatherDescription.rawValue.capitalized)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text("\(Date(timeIntervalSince1970: TimeInterval((Int)(day.dt))).formatted(.dateTime.weekday(.wide).day()))")
                    .font(.caption)
            }
        
            Spacer()
            
            HStack {
                Text("\((Int)(day.temp.max))ºC")
                    .font(.callout)
                    .fontWeight(.bold)
                Text("/")
                    .font(.callout)
                Text("\((Int)(day.temp.min))ºC")
                    .font(.callout)
                    .fontWeight(.bold)
            }
        }
    }
    
}

struct DailyView_Previews: PreviewProvider {
    static var day = ModelData().forecast!.daily
    
    static var previews: some View {
        DailyView(day: day[0])
    }
}
