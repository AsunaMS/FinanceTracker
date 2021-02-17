//
//  HomeTableViewCell.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 01/02/2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var homeCellImage: UIImageView!
    
    @IBOutlet weak var homeCellTitle: UILabel!
    @IBOutlet weak var homeCellDate: UILabel!
    @IBOutlet weak var homeCellImageHolder: UIView!
    @IBOutlet weak var homeCellMoney: UILabel!
    var invoice:CoreInvoice?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initCell() {
        guard let invoice = invoice else{return}
        guard let type = invoice.invoiceType else {return}
        // Home tableview cell invoice properties
        homeCellTitle?.text = invoice.invoiceTitle
        homeCellImage?.image = CoreInvoice.invoiceIcon(invoiceType: type)
        homeCellMoney?.textColor = invoice.textColor
        // format the date instace to a better looking string
        if let date = invoice.invoiceDate {
            homeCellDate?.text = UIUtils.getFormattedDateString(for: date, dateStyle: .full)
        }
        // handle the invoice "money" amount string
        homeCellMoney?.text? = ""
        homeCellMoney?.text? += invoice.textSign
        homeCellMoney?.text? += UIUtils.getFormattedNumberString(for: invoice.invoiceAmount).addCurrencySymbol()
        // customize the imageholder aka UIView that holds UIImage
        homeCellImageHolder?.backgroundColor =  CoreInvoice.invoiceImageBgColor(invoiceType: type)
        homeCellImageHolder?.layer.borderWidth = CoreInvoice.invoiceImageBorderWidth
        homeCellImageHolder?.layer.cornerRadius = CoreInvoice.invoiceImageBorderCornerRadius
        homeCellImageHolder?.layer.borderColor = CoreInvoice.invoiceImageBorderColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
