//
//  WeatherViewController.swift
//  ClimaApp
//
//  Created by Antonio Vidakovic on 20.01.2021..
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherConditionImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Set self as delegate
        searchTextField.delegate = self
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        
        // Dismiss keyboard
        searchTextField.endEditing(true)
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
