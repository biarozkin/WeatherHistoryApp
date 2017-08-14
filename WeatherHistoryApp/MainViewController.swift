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
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var forecastDetailsLabel: UILabel!
    
    @IBOutlet weak var requestIsInProgressLabel: UILabel!
    @IBOutlet weak var requestProgressActivityIndicator: UIActivityIndicatorView!


    //MARK: - VC LifeCycle & Preparation
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(locationRetrieved(_:)), name: kLocationRetrievedNotification, object: nil)
        prepareUI()
        prepareLocationManager()
    }
    
    deinit {
        //made for iOS 8 and earlier
        NotificationCenter.default.removeObserver(self, name: kLocationRetrievedNotification, object: nil)
    }
    
    func prepareLocationManager() {
        _ = LocationManager.shared
    }
    
    //MARK: - UI
    func prepareUI() {
        //requestProgressActivityIndicator.isHidden = false
        requestProgressActivityIndicator.hidesWhenStopped = true
        requestProgressActivityIndicator.startAnimating()
        
        coordinatesLabel.isHidden = true
        placeLabel.isHidden = true
        temperatureLabel.isHidden = true
        forecastDetailsLabel.isHidden = true
    }
    
    func updateUIWith(_ currentWeather: Weather) {
        requestProgressActivityIndicator.stopAnimating()
        requestIsInProgressLabel.isHidden = true
        
        coordinatesLabel.text = String(format: "latitude: \(currentWeather.latitude!) \nlongtitude: \(currentWeather.longtitude!)")
        coordinatesLabel.isHidden = false
        
        placeLabel.text = currentWeather.place!
        placeLabel.isHidden = false

        temperatureLabel.text = String(format: "%.0f°C", currentWeather.temperature!)
        temperatureLabel.isHidden = false
        
        forecastDetailsLabel.text = currentWeather.details
        forecastDetailsLabel.isHidden = false
    }
    
    //MARK: - Notifications
    func locationRetrieved(_ notification: NSNotification) {
        if let location = notification.userInfo?["location"] as? CLLocation {
            WeatherManager().getWeatherUsing(location.coordinate, completion: { (currentWeather) in
                DispatchQueue.main.async {
                    self.updateUIWith(currentWeather)
                }
            })
        }
    }
}
