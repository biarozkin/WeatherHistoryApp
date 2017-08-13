//
//  Weather.swift
//  WeatherHistoryApp
//
//  Created by Igor Biarozkin on 11.08.17.
//  Copyright © 2017 biarozkin. All rights reserved.
//

import Foundation

class Weather {
    
    var dateAndTime: String?
    //let coordinates: CLLocationCoordinate2D? //CLLCoordiantes?
    var longtitude: Double?
    var latitude: Double?
    var place: String?
    var temperature: Double?
    var details: String?
    
    init(dateAndTime: String?, long: Double?, lat: Double?, place: String?, temperature: Double?, details: String?) {
        self.dateAndTime = dateAndTime
        self.longtitude = long
        self.latitude = lat
        self.place = place
        self.temperature = temperature
        self.details = details
    }
        
}

