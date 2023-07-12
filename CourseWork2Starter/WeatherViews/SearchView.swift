//
//  SearchView.swift
//  CWK2_23_GL
//
//  Created by GirishALukka on 11/03/2023.
//

import SwiftUI
import CoreLocation

struct SearchView: View {
    @EnvironmentObject var modelData: ModelData
    
    @Binding var isSearchOpen: Bool
    @State var location = ""
    @Binding var userLocation: String
    @State private var errorAlert: Bool = false
    
    var body: some View {
        ZStack {
            Color.cyan
                .ignoresSafeArea()
                .opacity(0.5)
            
            VStack{
                Label("Search Location", systemImage: "location.fill")
                    .font(.title)
                    .foregroundColor(.blue)
                
                TextField("Enter New Location", text: self.$location, onCommit: {
                    CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
                        if let lat = placemarks?.first?.location?.coordinate.latitude,
                           let lon = placemarks?.first?.location?.coordinate.longitude {
                            Task {
                                do {
                                    let _ = try await modelData.loadData(lat: lat, lon: lon)
                                    userLocation = location
                                    modelData.userLocation = location
                                } catch {
                                    errorAlert = true
                                }
                            }
                            isSearchOpen.toggle()
                        } else {
                            errorAlert = true
                        }
                    }
                })
                .padding(10)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Ariel", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.black)
                .cornerRadius(15)
                .alert(isPresented: $errorAlert){
                    Alert(
                        title: Text("Invalid Location!"),
                        message: Text("Sorry, we couldn't find the entered location.\nPlease Try Again"),
                        dismissButton: .cancel(Text("Okay"))
                    )
                }
                
            }
        }
    }
    
} //View

