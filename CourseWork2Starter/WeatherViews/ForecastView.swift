//
//  Forecast.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct ForecastView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        VStack {
            VStack{
                Text(modelData.userLocation)
                    .font(.title3)
                    .multilineTextAlignment(.center)

                List{
                    ForEach(modelData.forecast!.daily) { day in
                        DailyView(day: day)
                    }
                }
                .foregroundColor(.black)
            }
            .opacity(0.8)
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

struct Forecast_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView().environmentObject(ModelData())
    }
}
