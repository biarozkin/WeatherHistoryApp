//
//  DetailsViewController.swift
//  WeatherHistoryApp
//
//  Created by Igor Biarozkin on 14.08.17.
//  Copyright © 2017 biarozkin. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {

    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    var currentWeather: NSManagedObject?
    
    //MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        dateAndTimeLabel.text = currentWeather?.value(forKeyPath: "dateAndTime") as? String
        coordinatesLabel.text = String("\(currentWeather?.value(forKeyPath: "latitude") as! Double),\(currentWeather?.value(forKeyPath: "longtitude") as! Double)")
        placeLabel.text = currentWeather?.value(forKeyPath: "place") as? String
        temperatureLabel.text = String(format:"%.0f°C", currentWeather?.value(forKeyPath: "temperature") as! Double)
        detailsLabel.text = currentWeather?.value(forKeyPath: "details") as? String
    }

    override func viewWillDisappear(_ animated: Bool) {
        currentWeather = nil
        print("viewWillDisappear")
    }
    
    //MARK: - Actions
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
