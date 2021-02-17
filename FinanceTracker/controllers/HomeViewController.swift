//
//  HomeViewController.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 31/01/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var InvoiceTableView: UITableView!
    @IBOutlet weak var userBalanceLabel: UILabel!
    @IBOutlet weak var userIncomeLabel: UILabel!
    @IBOutlet weak var userExpenseLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initHomeViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // reset image on appearence
        if let user = AppDelegate.user {
            if let imageData = user.image {
                userImage?.image = UIImage(data: imageData)
            }
        }
    }
    
    func initHomeViews() {
        // customize the user profile icon
        userImage?.roundedImage(borderColor: UIColor.white.cgColor, cornerRadius: 16.0)
        // get a formatted string of user's balnace,income and expense
        let userFormattedBalance = UIUtils.getFormattedNumberString(for: AppDelegate.user?.balance).addCurrencySymbol()
        let userFormattedIncome = UIUtils.getFormattedNumberString(for: AppDelegate.user?.income).addCurrencySymbol()
        let userFormattedExpense = UIUtils.getFormattedNumberString(for: AppDelegate.user?.expense).addCurrencySymbol()
        // get a nice formatted string of the current date
        let formattedDate = UIUtils.getFormattedDateString(for: Date(), dateStyle: .long)
        // customize our labels
        userBalanceLabel.text = userFormattedBalance
        userIncomeLabel.text = userFormattedIncome
        userExpenseLabel.text = userFormattedExpense
        currentDateLabel.text = formattedDate
        // set our view's backgorund image
        UIUtils.setBackgroundImage(pView: self.view)
        
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gotoProfile))
        // add it to the image view;
        userImage?.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        userImage?.isUserInteractionEnabled = true
    }
    @objc func gotoProfile() {
        // move to profile tab
        tabBarController?.selectedIndex = 4
    }
 
    
}
