//
//  CatalogTableViewController.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 02/02/2021.
//

import UIKit

class CatalogTableViewController: UITableViewController, UpdateUserInvoices {
    // all invoice types currently available
    let catalogItems:[String] = ["flight","clothing","groceries","rent","salary","other"]
    var selectedIndexPath: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func didUpdate(dismiss:UIViewController,invoice:CoreInvoice,alert:UIAlertController?) {
        // after updating invoices navigate to home
        tabBarController?.selectedIndex = 0
        // add a invoice to the user's object
        let tbvc:HomeViewController = tabBarController?.selectedViewController as! HomeViewController
        // reload invoice tableview data and views
        AppDelegate.user?.invoiceAdded(invoice: invoice)
        tbvc.InvoiceTableView.reloadData()
        tbvc.initHomeViews()
        // dismiss the addinvoice VC
        dismiss.dismiss(animated: true) {
            if let alert = alert {
                tbvc.present(alert, animated: true)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return catalogItems.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        // animate a diselect row for better looking performance
        tableView.deselectRow(at: indexPath, animated: true)
        if self.presentedViewController != nil {
            return
        }
        let invoiceAmountVC:InvoiceAmountViewController = UIStoryboard(name: "InvoiceStoryBoard", bundle: nil).instantiateViewController(identifier: "InvoiceAmountViewController") as! InvoiceAmountViewController
        invoiceAmountVC.invoice = CoreInvoice.init(invoiceType: catalogItems[indexPath.row])
        invoiceAmountVC.updateUserInvoicedelegate = self
        present(invoiceAmountVC, animated: true)
    }
    // set fixed size for our cell height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CatalogTableViewCell = tableView.dequeueReusableCell(withIdentifier: "catalogCell", for: indexPath) as! CatalogTableViewCell
        let invoiceType:String = catalogItems[indexPath.row]
        // customize our cell's views with invoice type instance
        cell.catalogTitleLabel?.text = CoreInvoice.invoiceTypeName(invoiceType: invoiceType)
        cell.catalogIconHolder.backgroundColor = CoreInvoice.invoiceImageBgColor(invoiceType: invoiceType)
        cell.catalogIcon?.image = CoreInvoice.invoiceIcon(invoiceType: invoiceType)
        return cell
    }
    
    
}
