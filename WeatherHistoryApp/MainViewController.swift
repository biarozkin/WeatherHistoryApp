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
    @IBOutlet weak var forecastDetailsLabel: UILabel!
    
    
    let locationManager = CLLocationManager()

    //MARK: - LifeCycle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLocationManager()
        prepareUI()
    }
    
    func prepareLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func prepareUI() {
        coordinatesLabel.isHidden = true
        coordinatesActivityIndicator.isHidden = false
        coordinatesActivityIndicator.hidesWhenStopped = true
        coordinatesActivityIndicator.startAnimating()
        
        placeLabel.isHidden = true
        placeActivityIndicator.isHidden = false
        placeActivityIndicator.hidesWhenStopped = true
        placeActivityIndicator.startAnimating()
        
    }
    
    func updateCoordinatesLabelWith(_ location: CLLocation) {
        coordinatesLabel.text = String(format: "Lat: \(location.coordinate.latitude)\nlong: \(location.coordinate.longitude)")
        coordinatesLabel.isHidden = false
        updatePlaceLabelUsing(location)
    }
    
    func updatePlaceLabelUsing(_ location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if (error == nil) {
                if (placemarks?.count)! > 0 {
                    let placemark = placemarks!.first! as CLPlacemark
                    if let locality = placemark.locality {
                        self.placeLabel.text = locality
                    }
                    self.placeLabel.isHidden = false
                }
            } else {
                print("Error while reverse geocoding: \(error?.localizedDescription)")
            }
            self.placeActivityIndicator.stopAnimating()
        }
    }
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //if-statement-workaround made for not to use cached location position, if the latest one was retrieved more than 60 secs ago
        if locations.last!.timestamp.timeIntervalSinceNow > -60.0 {
            print("didUpdateLocations_case1")
            if let location = locations.last {
                print("LocationDate: \(location.timestamp)")
                print("LocationCoordinates: \(location.coordinate)")
                
                WeatherManager().getWeatherUsing(location.coordinate)
                
                coordinatesActivityIndicator.stopAnimating()
                updateCoordinatesLabelWith(location)
            }
        } else {
            print("didUpdateLocations_case2")
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while retrieving location: \(error.localizedDescription))")
        locationManager.requestLocation()
    }
}
