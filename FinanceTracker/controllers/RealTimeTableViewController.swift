//
//  RealTimeTableViewController.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 08/02/2021.
//

import UIKit

class RealTimeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var currencies:[CurrencyObj]?

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    func initViews() {
        // set our view's delegates
        tableView?.delegate = self
        tableView?.dataSource = self
        currencyPicker?.delegate = self
        currencyPicker?.dataSource = self
        // sort shared currencies alphabetically
        setCurrenciesAndSort()
    }
    
    func setCurrenciesAndSort() {
        currencies = CurrencyDataSource.shared.map { (item)  in
                return CurrencyObj(name: item.key, value: item.value.cutCurrency())
            }.sorted(by: { (o1, o2) -> Bool in
                o1.name < o2.name
            })
    }
    
  
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currencyPicker: UIPickerView!
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let currencies = currencies else {return 0 }
        return currencies.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // in case our shared currencies are empty inform user of connection problem
        if CurrencyDataSource.shared.isEmpty {
            if Reachability.isConnectedToNetwork() {
                AppDelegate.loadCurrencies()
                setCurrenciesAndSort()
                tableView?.reloadData()
                return
            }
            let netAlert = UIAlertController(title: "No Network", message: "Couldn't retrieve realtime currencies", preferredStyle: .alert)
            netAlert.addAction(UIAlertAction(title: "Okay", style: .cancel))
            present(netAlert,animated: true)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RealTimeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! RealTimeTableViewCell
        guard let currencies = currencies, !currencies.isEmpty else {return cell}

        cell.currencytitle.text = currencies[indexPath.row].name
        cell.currencyValue.text = currencies[indexPath.row].value
        return cell
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Currencies.shared.count
    }
    //    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //
    //    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Montserrat", size: 10)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        pickerLabel?.textColor = UIColor.black
        pickerLabel?.text = Currencies.shared[row].name
        
        return pickerLabel!;
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        CurrencyDataSource.changeBaseCurrency(newCurrency: Currencies.shared[row]) { [weak self] (errorMessage) in
            if let errorMessage = errorMessage {
                print(errorMessage)
                return
            }
            self?.currencies = {
                return CurrencyDataSource.shared.map { (item)  in
                    return CurrencyObj(name: item.key, value: item.value.cutCurrency())
                }
            }().sorted(by: { (o1, o2) -> Bool in
                o1.name < o2.name
            })
            DispatchQueue.main.async {
            
                self?.tableView.reloadData()
            }
            
        }

    }
    
}



