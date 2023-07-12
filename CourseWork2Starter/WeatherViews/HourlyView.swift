//
//  Hourly.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct HourlyView: View {
    
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        VStack {
            VStack{
                Text(modelData.userLocation)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    
                List {
                    ForEach(modelData.forecast!.hourly) { hour in
                        HourCondition(current: hour)
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

struct Hourly_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView().environmentObject(ModelData())
    }
}
