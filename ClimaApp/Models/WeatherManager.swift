//
//  WeatherManager.swift
//  ClimaApp
//
//  Created by Antonio Vidakovic on 21.01.2021..
//

import Foundation

struct WeatherManager {
    
    // Get reference to the url of data
    let weatherURl = "https://api.openweathermap.org/data/2.5/weather?appid=47b346c7c81a86fd0ed06f0f39dba8fc&units=metric"
    
    func fetchWeather(cityName: String) {
        
        let urlString = "\(weatherURl)&q=\(cityName)"
        
        if let url = URL(string: urlString) {
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let decodedData = try decoder.decode(WeatherData.self, from: data!)
                    let cityName = decodedData.name
                    let temp = decodedData.main.temp
                    let id = decodedData.weather[0].id
                
                }
                catch {
                    // Error
                }
                
           
        }
            
            dataTask.resume()
      
        }
        
    }
}
