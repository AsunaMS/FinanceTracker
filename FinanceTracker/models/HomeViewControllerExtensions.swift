//
//  HomeViewControllerExtensions.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 01/02/2021.
//

import UIKit

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let popupViewController = UIStoryboard(name: "InvoiceStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "InvoicePopUpViewController") as? InvoicePopUpViewController {
            popupViewController.modalPresentationStyle = .custom
            popupViewController.modalTransitionStyle = .crossDissolve
            tableView.deselectRow(at: indexPath, animated: true)
            // Assign the current invoice
            guard let user  = AppDelegate.user else {
                present(popupViewController, animated: true)
                return }
            //presenting the pop up viewController from the home viewController
            let userInvoice =  user.getInvoice(at: indexPath.row)
            popupViewController.invoice = userInvoice
            present(popupViewController, animated: true)
        }
        
    }
    
}
extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let user = AppDelegate.user else { return 0}
        return user.invoices?.count ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "hcell", for: indexPath) as! HomeTableViewCell
        guard let user = AppDelegate.user else { return cell}
        // get current invoice from the invoice list
        let userInvoice = user.getInvoice(at: indexPath.row)
        // set the cell's invoice instance
        cell.invoice =  userInvoice
        // initiation of the cell views
        cell.initCell()
        return cell
    }
}
