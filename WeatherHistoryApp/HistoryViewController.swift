//
//  HistoryViewController.swift
//  WeatherHistoryApp
//
//  Created by Igor Biarozkin on 11.08.17.
//  Copyright © 2017 biarozkin. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var weatherData: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WeatherEntity")
        
        do {
            weatherData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        tableView.reloadData()
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("weatherDataCount: \(weatherData.count)")
        return weatherData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCellIdentifier", for: indexPath) as! HistoryTableViewCell
        
        let weather = weatherData[indexPath.row]
        cell.dateAndTimeLabel.text = weather.value(forKeyPath: "dateAndTime") as? String
        cell.placeLabel.text = weather.value(forKeyPath: "place") as? String
        cell.coordinatesLabel.text =
            String("\(weather.value(forKeyPath: "latitude") as! Double),\(weather.value(forKeyPath: "longtitude") as! Double)")
        
        return cell
    }
}

