//
//  WeatherModel.swift
//  ClimaApp
//
//  Created by Antonio Vidakovic on 21.01.2021..
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    // Return string temp with only one decimal place
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    // Get condition name based on code of weather on API and set it to sf symbol name
    // Computed property
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
