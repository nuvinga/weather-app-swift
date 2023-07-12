//
//  LocationHelper.swift
//  Coursework2
//
//  Created by G Lukka.
//

import Foundation

import CoreLocation
func getLocFromLatLong(lat: Double, lon: Double) async -> String
{
    var locationString: String
    var cityString: String
    var countryString: String
    var placemarks: [CLPlacemark]
    let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    
    let ceo: CLGeocoder = CLGeocoder()
    
    let loc: CLLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
    do {
        placemarks = try await ceo.reverseGeocodeLocation(loc)
        if placemarks.count > 0 {
            
            if (!placemarks[0].name!.isEmpty) {
                locationString = placemarks[0].name!
                
                if (!placemarks[0].country!.isEmpty) {
                    countryString = placemarks[0].country!
                    
                    if (!placemarks[0].locality!.isEmpty) {
                        cityString = placemarks[0].locality!
                        locationString = "\(locationString),\n\(cityString), \(countryString)"
                        
                    } else {
                        locationString = "\(locationString),\n\(countryString)"
                    }
                }
                
            } else {
                locationString = (placemarks[0].locality ?? "No City")
            }
            
            return locationString
        }
    } catch {
        print("Reverse geodecoe fail: \(error.localizedDescription)")
        locationString = "No City, No Country"
       
        return locationString
    }
    
    return "Error getting Location"
}
