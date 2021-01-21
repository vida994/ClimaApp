//
//  WeatherViewController.swift
//  ClimaApp
//
//  Created by Antonio Vidakovic on 20.01.2021..
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherConditionImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    // Create Core Location Manager to get access to user current GPS location
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        // Trigger permision request
        locationManager.requestWhenInUseAuthorization()
        // Get current one time location
        locationManager.requestLocation()
        
        // Set self as delegate
        searchTextField.delegate = self
        weatherManager.delegate = self
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        
        // Dismiss keyboard
        searchTextField.endEditing(true)
        }
    
    @IBAction func locationTapped(_ sender: Any) {
        
        // Trigger didUpdateLocations func from CLLocationManagerDelegate Methods
        // Get current one time location
        locationManager.requestLocation()
        
    }
    
    
}

// MARK: - UITextFieldDelegate Methods

extension WeatherViewController: UITextFieldDelegate {
    
    // Return pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss keyboard
        searchTextField.endEditing(true)
        return true
    }
    
    // Clear text from serach after editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // Save what user has typed
        if let city = searchTextField.text {
            
            weatherManager.fetchWeather(cityName: city)
            
        }
        searchTextField.text = ""
        
    }
    
    // User tapped somewhere else, dismiss keyboard
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        }
        else {
            searchTextField.placeholder = "Type something"
            return false
        }
        
    }
    
}

// MARK: - WeatherManagerProtocol Methods

extension WeatherViewController: WeatherManagerProtocol {
  
    func wheatherDataRecived(weather: WeatherModel) {
        
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.weatherConditionImage.image = UIImage(systemName: weather.conditionName)
            
        }
     }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
  }

// MARK: - CLLocationManagerDelegate Methods

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
            // Stop location manager so we can get location again when needed because it cannot be activated if running
            locationManager.stopUpdatingLocation()
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
