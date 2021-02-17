//
//  InvoiceCollectionViewCell.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 06/02/2021.
//

import UIKit

class InvoiceCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionButtonOutLet: UIButton!
    //var invoiceType:invoiceType?
    @IBOutlet weak var iconHolderView: UIView!
    
    @IBAction func collectionItemTapped(_ sender: UIButton) {
    }
    
    func initViews() {
      //  guard let type = invoiceType else {return}
        //guard let icon  = type.invoiceIcon else {return}
       // iconHolderView?.backgroundColor = type.invoiceImageBgColor
        iconHolderView?.layer.cornerRadius = 10.0
        iconHolderView?.layer.borderColor = UIColor.black.cgColor
        iconHolderView?.layer.borderWidth = 1.5
       // collectionButtonOutLet?.setImage(icon, for: .normal)
    }
}
