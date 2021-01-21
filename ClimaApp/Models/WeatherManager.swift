//
//  WeatherManager.swift
//  ClimaApp
//
//  Created by Antonio Vidakovic on 21.01.2021..
//

import Foundation
import CoreLocation

protocol WeatherManagerProtocol {
    func wheatherDataRecived(weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerProtocol?
    
    // Get reference to the url of data
    let weatherURl = "https://api.openweathermap.org/data/2.5/weather?appid=47b346c7c81a86fd0ed06f0f39dba8fc&units=metric"
    
    func fetchWeather(cityName: String) {
        
        let urlString = "\(weatherURl)&q=\(cityName)"
        
        if let url = URL(string: urlString) {
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                guard data != nil else {
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let decodedData = try decoder.decode(WeatherData.self, from: data!)
                    let name = decodedData.name
                    let temp = decodedData.main.temp
                    let id = decodedData.weather[0].id
                    
                    // Create weather object
                    let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
                    
                    delegate?.wheatherDataRecived(weather: weather)
                
                }
                catch {
                    // Error
                    delegate?.didFailWithError(error: error)
                 }
                
           
        }
            
            dataTask.resume()
      
        }
        
    }
    
    // Get weather data from give lat & lon
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let urlString = "\(weatherURl)&lat=\(latitude)&lon=\(longitude)"
        
        if let url = URL(string: urlString) {
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                guard data != nil else {
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let decodedData = try decoder.decode(WeatherData.self, from: data!)
                    let name = decodedData.name
                    let temp = decodedData.main.temp
                    let id = decodedData.weather[0].id
                    
                    // Create weather object
                    let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
                    
                    delegate?.wheatherDataRecived(weather: weather)
                
                }
                catch {
                    // Error
                    delegate?.didFailWithError(error: error)
                 }
                
           
        }
            
            dataTask.resume()
      
        }
        
    }
}
