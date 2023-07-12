//
//  AirModelData.swift
//  CourseWork2Starter
//
//  Created by Nuvin Godakanda Arachchi on 2023-03-31.
//

import Foundation

class AirModelData: ObservableObject {
    
    @Published var pollution: Pollution?
    
    private let API_KEY = "13eea8dac0c4e8dd3fe9236556f50389"
    
    init() {}
    
    func loadAirPollution(lat: Double, lon: Double) async throws {
        let urlString = "https://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=\(lat)&lon=\(lon)&appid=\(API_KEY)"
        let url = URL(string: urlString)
        
        let session = URLSession(configuration: .default)
        let (data, _) = try await session.data(from: url!)
        
        do {
            let pollutionData = try JSONDecoder().decode(Pollution.self, from: data)
            DispatchQueue.main.async {
                self.pollution = pollutionData
            }
        } catch {
            throw error
        }
    }
    
}
