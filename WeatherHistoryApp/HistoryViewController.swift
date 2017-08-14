//
//  HistoryViewController.swift
//  WeatherHistoryApp
//
//  Created by Igor Biarozkin on 11.08.17.
//  Copyright © 2017 biarozkin. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var weatherData: [NSManagedObject] = []

    //MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = customColor().mainColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        weatherData = DataStorageManager().loadFromDisk()!
        tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource
extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("weatherDataCount: \(weatherData.count)")
        return weatherData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCellIdentifier", for: indexPath) as! HistoryTableViewCell
        if indexPath.row == 0 {
            cell.backgroundColor = customColor().headerColor
            cell.dateAndTimeLabel.text = "Date"
            cell.detailsHeaderLabel.text = "Details"
            cell.coordinatesLabel.text = nil
            cell.placeLabel.text = nil
        } else {
            cell.backgroundColor = customColor().mainColor
            
            let weather = weatherData[indexPath.row - 1]
            cell.detailsHeaderLabel.text = nil
            cell.dateAndTimeLabel.text = weather.value(forKeyPath: "dateAndTime") as? String
            cell.placeLabel.text = weather.value(forKeyPath: "place") as? String
            cell.coordinatesLabel.text =
                String("\(weather.value(forKeyPath: "latitude") as! Double),\(weather.value(forKeyPath: "longtitude") as! Double)")
        }
        return cell
    }
}

 //MARK: - UITableViewDelegate
extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            let detailsVC = storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
            let weather = weatherData[indexPath.row - 1]
            detailsVC.currentWeather = weather
            present(detailsVC, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

