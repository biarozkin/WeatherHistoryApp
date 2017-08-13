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
//        //let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .full, timeStyle: .full)
//        //print("\(timestamp)")
//        let date = Date()
//        //print("\(date)")
//        return date
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date())
//        // convert your string to date
//        let yourDate = formatter.date(from: myString)
//        //then again set the date format whhich type of output you need
//        formatter.dateFormat = "dd-MMM-yyyy"
//        // again convert your date to string
//        let myStringafd = formatter.string(from: yourDate!)
//        
//        print(myStringafd)
        return myString
    }
    
}
