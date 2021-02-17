//
//  InvoiceAmountViewController.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 05/02/2021.
//

import UIKit

class InvoiceAmountViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var closeButtonHolder: UIView!
    @IBOutlet weak var addButtonHolder: UIView!
    @IBOutlet weak var inOutPicker: UIPickerView!
    @IBOutlet weak var invoiceAmount: UITextField!
    var invoiceInOut:String?
    var invoice:CoreInvoice?
    var updateUserInvoicedelegate:UpdateUserInvoices?
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        // Do any additional setup after loading the view.
    }
    
    func initViews() {
        // default selection of row
        pickerView(inOutPicker, didSelectRow: 0, inComponent: 0)
        // define the delegates
        invoiceAmount.delegate = self
        inOutPicker?.delegate = self
        inOutPicker?.dataSource = self
        // reload components
        inOutPicker?.reloadAllComponents()
        guard let invoice = invoice else{return}
        // customize the button colors with invoice type
        if let type = invoice.invoiceType {
            closeButtonHolder?.backgroundColor = CoreInvoice.invoiceImageBgColorFull(invoiceType: type)
            addButtonHolder?.backgroundColor = CoreInvoice.invoiceImageBgColorFull(invoiceType: type)
        }
    }
    
    
    @IBAction func newButtonTapped(_ sender: Any) {
        // check if the invoice amount is empty
        if let amount = invoiceAmount?.text {
            if amount.isEmpty {
                invoiceAmount.placeholder = "Please provide amount"
                return
            } else {
                if let intAmount = Int64(amount) {
                    // set the invoice amount
                    self.invoice?.invoiceAmount = intAmount
                    let addInvoiceVC:AddInvoiceViewController = UIStoryboard(name: "InvoiceStoryBoard", bundle: nil).instantiateViewController(identifier: "AddInvoiceViewController") as! AddInvoiceViewController
                    // update the invoice and pass to our next controller
                    self.invoice?.invoiceInOut = invoiceInOut
                    addInvoiceVC.invoice = self.invoice
                    // pass a weak reference to our current presenting VC
                    addInvoiceVC.parentVC = self.presentingViewController
                    // pass our delegate to the next controller
                    addInvoiceVC.updateInvoicesDeleagate = updateUserInvoicedelegate
                    // present our next controller and dismiss our current one
                    weak var pvc = self.presentingViewController
                    self.dismiss(animated: true) {
                        if pvc?.presentedViewController != nil {
                            return
                        }
                        pvc?.present(addInvoiceVC, animated: true)
                    }
                }
            }
        }
        
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let invoice = invoice else {return 0}
        guard let invoiceType = invoice.invoiceType else {return 0}
        // "other" has a choice between expense and income(2) and the others default to 1 type
        if invoiceType == "other" {
            return 2
        }
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        // create a new custom label fro pickerview text
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Montserrat", size: 10)
            pickerLabel?.textAlignment = NSTextAlignment.center
           
        }
        // customize our picker text according the invoice type
        guard let invoice = invoice else {return pickerLabel!}
        guard let invoiceType = invoice.invoiceType else {return pickerLabel! }
        pickerLabel?.backgroundColor = CoreInvoice.invoiceImageBgColor(invoiceType: invoiceType)
        if invoiceType == "other" {
            if row == 0 {
                pickerLabel?.text = "Expense"
                pickerLabel?.textColor = #colorLiteral(red: 0.6075268817, green: 0.08433429636, blue: 0.1327555175, alpha: 1)
            }else {
                pickerLabel?.text =  "Income"
                pickerLabel?.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            }
        }else if invoiceType == "salary" {
            pickerLabel?.text =  "Income"
            pickerLabel?.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        }else {
            pickerLabel?.text = "Expense"
            pickerLabel?.textColor = #colorLiteral(red: 0.6075268817, green: 0.08433429636, blue: 0.1327555175, alpha: 1)
        }
        
        return pickerLabel!;
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let invoice = invoice else {return }
        guard let invoiceType = invoice.invoiceType else {return }
        
        // customize our controllers text according the invoice type selection
        if invoiceType == "other" {
            if row == 0 {
                self.invoiceInOut = "expense"
                self.invoiceAmount?.textColor = #colorLiteral(red: 0.6075268817, green: 0.08433429636, blue: 0.1327555175, alpha: 1)
            }else {
                self.invoiceInOut = "income"
                self.invoiceAmount?.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            }
        }else if invoiceType == "salary" {
            self.invoiceInOut = "income"
            self.invoiceAmount?.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        }else {
            self.invoiceInOut = "expense"
            self.invoiceAmount?.textColor = #colorLiteral(red: 0.6075268817, green: 0.08433429636, blue: 0.1327555175, alpha: 1)
        }
    }
    
   
    
}

extension InvoiceAmountViewController : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing textSu
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        // make sure the result is under 16 characters
        return updatedText.count <= 8 && allowedCharacters.isSuperset(of: characterSet)
    }
}
