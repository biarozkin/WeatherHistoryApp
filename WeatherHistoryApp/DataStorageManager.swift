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
    
    func save(lWeather: Weather) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "WeatherEntity", in: managedContext)!
        let weather = NSManagedObject(entity: entity, insertInto: managedContext)
        
        weather.setValue(lWeather.dateAndTime, forKeyPath: "dateAndTime")
        weather.setValue(lWeather.place, forKeyPath: "place")
        weather.setValue(lWeather.latitude, forKeyPath: "latitude")
        weather.setValue(lWeather.longtitude, forKeyPath: "longtitude")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
