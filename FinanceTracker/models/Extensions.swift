//
//  Extensions.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 08/02/2021.
//

import Foundation
extension Double {
    // an extension to cut a Double to 3 fraction digits
    func cutCurrency() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value:self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        return String(formatter.string(from:number) ?? "")
    }
}
extension String {
    // an extension to add a currency symbol to a string
    func addCurrencySymbol() -> String{
        var copy = self
        if let user = AppDelegate.user, let currency = user.currency, let symbol = currency.symbol {
            copy += symbol
            return copy
        }
        return self
    }
}
