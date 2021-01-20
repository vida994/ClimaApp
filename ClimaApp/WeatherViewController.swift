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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Set self as delegate
        searchTextField.delegate = self
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        
        
        
    }
    
}

// MARK: - UITextFieldDelegate Methods

extension WeatherViewController: UITextFieldDelegate {
    
    // Return pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    //
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
    }
    
}
