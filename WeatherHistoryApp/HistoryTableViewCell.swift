//
//  HistoryTableViewCell.swift
//  WeatherHistoryApp
//
//  Created by Igor Biarozkin on 11.08.17.
//  Copyright © 2017 biarozkin. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
