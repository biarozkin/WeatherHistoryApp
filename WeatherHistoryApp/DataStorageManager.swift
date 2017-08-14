//
//  DataStorageManager.swift
//  WeatherHistoryApp
//
//  Created by Igor Biarozkin on 13.08.17.
//  Copyright © 2017 biarozkin. All rights reserved.
//

import UIKit
import CoreData

class DataStorageManager: NSObject {
    func saveToDisk(lWeather: Weather) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "WeatherEntity", in: managedContext)!
        let weather = NSManagedObject(entity: entity, insertInto: managedContext)
        
        weather.setValue(lWeather.dateAndTime, forKeyPath: "dateAndTime")
        weather.setValue(lWeather.place, forKeyPath: "place")
        weather.setValue(lWeather.latitude, forKeyPath: "latitude")
        weather.setValue(lWeather.longtitude, forKeyPath: "longtitude")
        weather.setValue(lWeather.temperature, forKey: "temperature")
        weather.setValue(lWeather.details, forKey: "details")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error while saving data to disk: \(error.localizedDescription)")
        }
    }
    
    func loadFromDisk() -> [NSManagedObject]? {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WeatherEntity")
        
        do {
            var weatherData: [NSManagedObject] = []
            weatherData = try managedContext.fetch(fetchRequest)
            return weatherData
        } catch let error as NSError {
            print("Error while fetching data from disk: \(error.localizedDescription)")
            return nil
        }
    }
}
