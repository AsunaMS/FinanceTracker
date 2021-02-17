//
//  CatalogTableViewCell.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 02/02/2021.
//

import UIKit

class CatalogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var catalogIconHolder: UIView!
    @IBOutlet weak var catalogIcon: UIImageView!
    @IBOutlet weak var catalogTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
    }
    
    func initViews() {
        // customize catalog icon holder aka UIView holding a UIImage
        catalogIconHolder.layer.borderWidth = CoreInvoice.invoiceImageBorderWidth
        catalogIconHolder.layer.cornerRadius = 25.0
        catalogIconHolder.layer.borderColor = CoreInvoice.invoiceImageBorderColor
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
