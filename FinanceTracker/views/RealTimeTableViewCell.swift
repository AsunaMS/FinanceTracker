//
//  RealTimeTableViewCell.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 08/02/2021.
//

import UIKit

class RealTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyValue: UILabel!
    @IBOutlet weak var currencytitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
