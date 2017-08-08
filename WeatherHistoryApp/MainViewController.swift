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
    @IBOutlet weak var addressFromCoordinatesLabel: UILabel!
    @IBOutlet weak var addressActivityIndicator: UIActivityIndicatorView!

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
        
        addressFromCoordinatesLabel.isHidden = true
        addressActivityIndicator.isHidden = false
        addressActivityIndicator.hidesWhenStopped = true
        addressActivityIndicator.startAnimating()
        
    }
    
    func updateCoordinatesLabelWith(_ location: CLLocation) {
        coordinatesLabel.text = String(format: "Lat: \(location.coordinate.latitude)\nlong: \(location.coordinate.longitude)")
        coordinatesLabel.isHidden = false
        reverseGeocodingUsing(location)
    }
    
    func reverseGeocodingUsing(_ location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if (error == nil) {
                if (placemarks?.count)! > 0 {
                    let placemark = placemarks!.first! as CLPlacemark
                    print("!!!!: \(placemark.locality)")
                    self.addressFromCoordinatesLabel.text = placemark.locality
                    self.addressFromCoordinatesLabel.isHidden = false
                }
            } else {
                print("Error while reverse geocoding: \(error?.localizedDescription)")
            }
            self.addressActivityIndicator.stopAnimating()
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
        if let location = locations.last {
            print("LocationDate: \(location.timestamp)")
            print("LocationCoordinates: \(location.coordinate)")
            coordinatesActivityIndicator.stopAnimating()
            updateCoordinatesLabelWith(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while retrieving location: \(error.localizedDescription))")
    }
}