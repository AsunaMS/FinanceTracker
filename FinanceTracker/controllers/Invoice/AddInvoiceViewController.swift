//
//  AddInvoiceViewController.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 02/02/2021.
//

import UIKit


protocol UpdateUserInvoices {
    func   didUpdate(dismiss:UIViewController, invoice:CoreInvoice,alert:UIAlertController?)
}
class AddInvoiceViewController: UIViewController {
    
    
    
    @IBOutlet weak var invoiceIcon: UIImageView!
    @IBOutlet weak var invoiceDescTextField: UITextField!
    @IBOutlet weak var invoiceTitleTextField: UITextField!
    @IBOutlet weak var closeButtonHolder: UIView!
    @IBOutlet weak var addButtonHolder: UIView!
    @IBOutlet weak var dialogBoxView: UIView!
    
    @IBOutlet weak var invoiceIconHolder: UIView!
    
    weak var parentVC:UIViewController!
    var invoice:CoreInvoice?
    var updateInvoicesDeleagate:UpdateUserInvoices?
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    func initViews() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.01)
        if let invoice = invoice , let type = invoice.invoiceType{
            self.invoiceIcon?.image = CoreInvoice.invoiceIcon(invoiceType: type)
            addButtonHolder?.backgroundColor = CoreInvoice.invoiceImageBgColorFull(invoiceType: type)
            closeButtonHolder?.backgroundColor = CoreInvoice.invoiceImageBgColorFull(invoiceType: type)
        }
        
        //customizing the dialog box view
        dialogBoxView?.layer.cornerRadius = 6.0
        dialogBoxView?.layer.borderWidth = 1.2
        dialogBoxView?.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
        
        if let type = invoice?.invoiceType {
            invoiceIconHolder?.backgroundColor =  CoreInvoice.invoiceImageBgColor(invoiceType: type)
        }
        invoiceIconHolder?.layer.borderWidth = CoreInvoice.invoiceImageBorderWidth
        invoiceIconHolder?.layer.cornerRadius = CoreInvoice.invoiceImageBorderCornerRadius
        invoiceIconHolder?.layer.borderColor = CoreInvoice.invoiceImageBorderColor
        invoiceTitleTextField.delegate = self
        invoiceDescTextField.delegate = self
    }
    
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        // dismiss and return to home tab
        self.dismiss(animated: true)
        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let invoiceTitle = invoiceTitleTextField.text, let invoiceDesc = invoiceDescTextField.text else {return}
        
        // present a alert in case the title or description are empty
        if invoiceTitle.isEmpty || invoiceDesc.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "Invoice title & description should contain at least 1 letters or symbols each", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        //
        self.invoice?.invoiceTitle = invoiceTitle
        self.invoice?.invoiceDesc = invoiceDesc
        self.invoice?.invoiceDate = Date()
        if let invoice = self.invoice, let invoiceTitle = invoice.invoiceTitle {
            let alert = UIAlertController(title: "Invoice Added", message: "\(invoiceTitle) Added to your invoices", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in
                
            }))
            updateInvoicesDeleagate?.didUpdate(dismiss:self,invoice:invoice,alert: alert)
            self.dismiss(animated: true)
        }
    }
    
}

extension AddInvoiceViewController : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing textSu
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        let limit:Int = textField == invoiceTitleTextField ? 20 : 50
        // make sure the result is under 16 characters
        return updatedText.count <= limit
    }
}
