//
//  HistoryViewController.swift
//  WeatherHistoryApp
//
//  Created by Igor Biarozkin on 11.08.17.
//  Copyright © 2017 biarozkin. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var weatherData: Array<Weather> = []
    override func viewWillAppear(_ animated: Bool) {
        weatherData = GlobalData.shared.requestsArray
        tableView.reloadData()
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("weatherDataCount: \(weatherData.count)")
        return weatherData.count
        //return GlobalData.sharedInstance.requestsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCellIdentifier", for: indexPath) as! HistoryTableViewCell
        cell.dateAndTimeLabel.text = weatherData[0].dateAndTime
        cell.coordinatesLabel.text = "\(weatherData[0].latitude!), \(weatherData[0].longtitude!)"
        cell.placeLabel.text = weatherData[0].place
        
        return cell
    }
}

