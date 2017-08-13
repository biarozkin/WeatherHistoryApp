//
//  MainViewController.swift
//  WeatherHistoryApp
//
//  Created by Igor Biarozkin on 08.08.17.
//  Copyright © 2017 biarozkin. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {

    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var coordinatesActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var placeActivityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var forecastDetailsLabel: UILabel!
    @IBOutlet weak var forecastActivityIndicator: UIActivityIndicatorView!
    
    var requestsArray: Array<Weather> = []

    //MARK: - LifeCycle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateUIWithData(_:)), name: kLocationRetrievedNotification, object: nil)
        prepareUI()
        prepareLocationManager()
    }
    
    deinit {
        //made for iOS 8 and earlier
        NotificationCenter.default.removeObserver(self, name: kLocationRetrievedNotification, object: nil)
    }
    
    
    //MARK: - Preparation
    func prepareLocationManager() {
        _ = LocationManager.shared
    }
    
    //MARK: - UI
    func prepareUI() {
        coordinatesLabel.isHidden = true
        coordinatesActivityIndicator.isHidden = false
        coordinatesActivityIndicator.hidesWhenStopped = true
        coordinatesActivityIndicator.startAnimating()
        
        placeLabel.isHidden = true
        placeActivityIndicator.isHidden = false
        placeActivityIndicator.hidesWhenStopped = true
        placeActivityIndicator.startAnimating()
        
        temperatureLabel.isHidden = true
        temperatureActivityIndicator.isHidden = false
        temperatureActivityIndicator.hidesWhenStopped = true
        temperatureActivityIndicator.startAnimating()
        
        forecastDetailsLabel.isHidden = true
        forecastActivityIndicator.isHidden = false
        forecastActivityIndicator.hidesWhenStopped = true
        forecastActivityIndicator.startAnimating()
    }
    
    func updateUIWithData(_ notification: NSNotification) {
        if let location = notification.userInfo?["location"] as? CLLocation {
            WeatherManager().getWeatherUsing(location.coordinate, completion: { (weatherData) in
                DispatchQueue.main.async {
                    self.updateLabels(weatherData)
                }
            })
        }
    }
    
    func updateLabels(_ weatherData: Array<Weather>) {
        let currentWeather = weatherData.last   //should I check for optional?
        coordinatesLabel.text = String(format: "lat: \(currentWeather!.latitude!)\nlong: \(currentWeather!.longtitude!)")
        coordinatesLabel.isHidden = false
        coordinatesActivityIndicator.stopAnimating()
        
        placeLabel.text = currentWeather?.place!
        placeLabel.isHidden = false
        placeActivityIndicator.stopAnimating()
        
        temperatureLabel.text = String(format: "%.0f°C", currentWeather!.temperature!)
        temperatureLabel.isHidden = false
        temperatureActivityIndicator.stopAnimating()
        
        forecastDetailsLabel.text = currentWeather?.details
        forecastDetailsLabel.isHidden = false
        forecastActivityIndicator.stopAnimating()
    }
        
}
