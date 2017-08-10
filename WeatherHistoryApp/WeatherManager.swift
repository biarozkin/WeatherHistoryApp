//
//  WeatherManager.swift
//  WeatherHistoryApp
//
//  Created by Igor Biarozkin on 10.08.17.
//  Copyright © 2017 biarozkin. All rights reserved.
//

import Foundation
import CoreLocation

let apiKey = "1d26cc3d8a8191b006901b69ac3cf753"

class WeatherManager {
    
    func getWeatherUsing(_ coordinates: CLLocationCoordinate2D) {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&APPID=\(apiKey)")
        print("fullURL:\(url)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if !(error != nil) {
                if let data = data {
                    self.parseJSONWeather(data)
                }
            } else {
                print("Error while getting weatherData:\(error?.localizedDescription)")
            }
        }
        task.resume()
    }
    
    private func parseJSONWeather(_ data: Data) {
    
        do {
            let json = try JSONSerialization.jsonObject(with: data) as! NSDictionary
            
            if let main = json["main"] as? NSDictionary {
                if let temp = main["temp"] as? Double {
                    print("temp is:\(temp)")
                }
            }
           
            if let weatherArray = json["weather"] as? [NSDictionary] {
                let weather = weatherArray[0] as NSDictionary
                if let description = weather["description"] as? String {
                    print("description is: \(description)")
                }
            }
        } catch {
            print("Error while JSON parsing")
        }
    }
    
}
