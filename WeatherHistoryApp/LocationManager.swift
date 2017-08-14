//
//  LocationManager.swift
//  WeatherHistoryApp
//
//  Created by Igor Biarozkin on 12.08.17.
//  Copyright © 2017 biarozkin. All rights reserved.
//

import Foundation
import CoreLocation

let kLocationRetrievedNotification = Notification.Name(rawValue:"LocationRetrievedNotification")

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    static let shared = LocationManager()
    var isLocationRetrieved: Bool = false
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //if-statement-workaround made for not to use cached location position, if the latest one was retrieved less than 60 secs ago
        //if locations.last!.timestamp.timeIntervalSinceNow > -60.0 {
        if isLocationRetrieved == false {
            if let location = locations.last {
                let locationDict: [String: CLLocation] = ["location": location]
                NotificationCenter.default.post(name: kLocationRetrievedNotification, object: nil, userInfo: locationDict)
                isLocationRetrieved = true
            }
        }
//        } else {
//            print("Error while retrieving location, trying one more time..")
//            manager.requestLocation()
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while retrieving location: \(error.localizedDescription))")
        manager.requestLocation()
    }
}
