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
    
    typealias JSONDictionary = [String: Any]
    var weatherData: Array<Weather> = []
    
    func getWeatherUsing(_ coordinates: CLLocationCoordinate2D, completion: @escaping (Array<Weather>) -> () ) {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&APPID=\(apiKey)")
        print("fullURL:\(url)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if !(error != nil) {
                if let data = data {
                    self.parseJSONWeather(data)
                    //DispatchQueue.main.async {
                        completion(self.weatherData)
                    //}
                    
                }
            } else {
                print("Error while getting weatherData:\(error?.localizedDescription)")
            }
        }
        task.resume()
    }
    
    private func parseJSONWeather(_ data: Data) {
        let currentWeather = Weather(dateAndTime: nil, long: nil, lat: nil, place: nil, temperature: nil, details: nil)

        do {
            let json = try JSONSerialization.jsonObject(with: data) as! NSDictionary
            
            if let coord = json["coord"] as? JSONDictionary {
                if let lon = coord["lon"] as? Double {
                    currentWeather.longtitude = lon
                }
                if let lat = coord["lat"] as? Double {
                    currentWeather.latitude = lat
                }
            }
            
            if let name = json["name"] as? String {
                currentWeather.place = name
            }
            
            if let main = json["main"] as? NSDictionary {
                if let temp = main["temp"] as? Double {
                    currentWeather.temperature = Utils().kelvinToCelsius(temp)
                }
            }
            
            if let weatherArray = json["weather"] as? [NSDictionary] {
                let weather = weatherArray[0] as NSDictionary
                if let description = weather["description"] as? String {
                    currentWeather.details = description
                }
            }
            
            currentWeather.dateAndTime = Utils().getCurrentTime()
        
            DataStorageManager().save(lWeather: currentWeather)
            
            weatherData.removeAll()
            weatherData.append(currentWeather)
            
        } catch {
            print("Error while JSON parsing")
        }
    }

}
