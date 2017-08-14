//
//  Utils.swift
//  WeatherHistoryApp
//
//  Created by Igor Biarozkin on 10.08.17.
//  Copyright © 2017 biarozkin. All rights reserved.
//

import Foundation
import UIKit

struct customColor {
    let headerColor = UIColor(red: 160 / 255, green: 236 / 255, blue: 254 / 255, alpha: 1)
    let mainColor = UIColor(red: 180 / 255, green: 236 / 255, blue: 254 / 255, alpha: 1)
}

class Utils {
    func kelvinToCelsius(_ kelvin: Double) -> Double {
        return kelvin - 273.15
    }
    
    func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTimeWithFormat = formatter.string(from: Date())
        
        return currentTimeWithFormat
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
