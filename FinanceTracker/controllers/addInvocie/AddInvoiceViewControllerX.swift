//
//  AddInvoiceViewControllerX.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 06/02/2021.
//

import UIKit

class AddInvoiceViewControllerX: UIViewController {
    
    @IBOutlet weak var invoiceAmountTextField: UITextField!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var invoiceTypeCollection: UICollectionView!
    
    @IBOutlet weak var roundedView1: UIView!
    
    @IBOutlet weak var roundedView2: UIView!
    
    @IBOutlet weak var roundedView3: UIView!
    
    @IBOutlet weak var addInvoiceButtonOutLet: UIButton!
    @IBOutlet weak var invoiceInOutSegmentControll: UISegmentedControl!
    let catalogItems:[invoiceType] = [.flight,.clothing,.groceries,.rent,.salary,.other]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
        // Do any additional setup after loading the view.
    }
    
    func initViews() {
        invoiceTypeCollection.delegate = self
        invoiceTypeCollection.dataSource =  self
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        addInvoiceButtonOutLet?.layer.cornerRadius = 10.0
        addInvoiceButtonOutLet?.clipsToBounds = true
        addInvoiceButtonOutLet?.layer.borderWidth = 1.0
        addInvoiceButtonOutLet?.layer.borderColor =  UIColor.black.cgColor
    }
    
    
    @IBAction func writeANoteTapped(_ sender: UIButton) {
    }
    
    @IBAction func pickAPhotoTapped(_ sender: UIButton) {
    }
    
    @IBAction func calenderButtonTapped(_ sender: UIButton) {
    }
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addInvoiceTapped(_ sender: UIButton) {
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension AddInvoiceViewControllerX : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        1
    }
    
    
}

extension AddInvoiceViewControllerX : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:InvoiceCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "InvoicecollectionViewCell",
            for: indexPath) as! InvoiceCollectionViewCell
        cell.invoiceType = catalogItems[indexPath.row]
        cell.initViews()
        return cell
    }
}


