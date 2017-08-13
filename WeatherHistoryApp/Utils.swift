//
//  Utils.swift
//  WeatherHistoryApp
//
//  Created by Igor Biarozkin on 10.08.17.
//  Copyright © 2017 biarozkin. All rights reserved.
//

import Foundation

class Utils {
    
    func kelvinToCelsius(_ kelvin: Double) -> Double {
        return kelvin - 273.15
    }
    
    func getCurrentTime() -> String {
        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
        return timestamp
    }
    
}
