//
//  PopUpViewController.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 01/02/2021.
//

import UIKit

class InvoicePopUpViewController: UIViewController {
    
    
    @IBOutlet weak var dialogBoxView: UIView!
    @IBOutlet weak var popupInvoiceDate: UILabel!
    @IBOutlet weak var popupInvoiceTitle: UILabel!
    @IBOutlet weak var popupInvoiceIcon: UIImageView!
    @IBOutlet weak var popupInvoiceIconholder: UIView!
    @IBOutlet weak var popupInvoiceDesc: UITextView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var popupInvoiceAmount: UILabel!
    // default - .other
    var invoice:CoreInvoice?
    override func viewDidLoad() {
        super.viewDidLoad()
        initPopUpViews()
    }
    
    func initPopUpViews() {
        guard let invoice = invoice else{return}
        //adding an overlay to the view to give focus to the dialog box
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        //customizing the dialog box view
        dialogBoxView?.layer.cornerRadius = 6.0
        dialogBoxView?.layer.borderWidth = 1.2
        dialogBoxView?.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
        
        // updating the labels using our invoice instance
        popupInvoiceTitle?.text = invoice.invoiceTitle
        popupInvoiceDesc?.text = invoice.invoiceDesc
        if let date = invoice.invoiceDate {
            popupInvoiceDate?.text = UIUtils.getFormattedDateString(for: date, dateStyle: .full)
        }
        // updating the icon & icon holder aka UIView using our invoice instance
        if let type = invoice.invoiceType {
            popupInvoiceIcon?.image = CoreInvoice.invoiceIcon(invoiceType: type)
            popupInvoiceIconholder?.backgroundColor = CoreInvoice.invoiceImageBgColor(invoiceType: type)
            
            buttonView?.backgroundColor = CoreInvoice.invoiceImageBgColorFull(invoiceType: type)
        }
        // customize the icon holder aka UIView
        popupInvoiceIconholder?.layer.borderWidth = CoreInvoice.invoiceImageBorderWidth
        popupInvoiceIconholder?.layer.cornerRadius = CoreInvoice.invoiceImageBorderCornerRadius
        popupInvoiceIconholder?.layer.borderColor = CoreInvoice.invoiceImageBorderColor
        
        popupInvoiceAmount?.textColor = invoice.textColor
        popupInvoiceAmount?.text = "\(invoice.textSign)\(UIUtils.getFormattedNumberString(for: invoice.invoiceAmount).addCurrencySymbol())"
        // customzie the close button
        buttonView?.layer.cornerRadius = 6.0
        buttonView?.layer.borderWidth = 1.2
        buttonView?.layer.borderColor = UIColor(named: "white")?.cgColor
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {[weak self] in
            self?.dialogBoxView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01).rotated(by: 8.0)
        } completion: { (Bool) in
            self.dismiss(animated: true)
        }
    }

    
}
