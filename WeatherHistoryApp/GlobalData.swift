//
//  GlobalData.swift
//  WeatherHistoryApp
//
//  Created by Igor Biarozkin on 11.08.17.
//  Copyright © 2017 biarozkin. All rights reserved.
//

import Foundation

class GlobalData {
    static let shared = GlobalData()
    var requestsArray: Array<Weather> = []
}
