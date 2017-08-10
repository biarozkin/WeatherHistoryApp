//
//  Weather.swift
//  WeatherHistoryApp
//
//  Created by Igor Biarozkin on 10.08.17.
//  Copyright © 2017 biarozkin. All rights reserved.
//

import Foundation

class Weather {
    
    let temperature: Double
    let weatherDetails: String
    
    init(temperature: Double, weatherDetails: String) {
        self.temperature = temperature
        self.weatherDetails = weatherDetails
    }
    
}
