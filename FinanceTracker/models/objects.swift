//
//  Invoice.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 01/02/2021.
//

import UIKit

struct Person {
    var firstName:String
    var lastName:String
    var invoices:[Invoice]
    var balance:Int
    var income:Int
    var expense:Int
    
    mutating func invoiceAdded(invoice:Invoice) {
        invoices.append(invoice)
        guard let amount  = invoice.invoiceAmount else {return}
        if invoice.invoiceInOut == .expense {
            balance = balance - amount
            expense = expense + amount
        } else if invoice.invoiceInOut == .income {
            balance = balance + amount
            income  = income + amount
        }
    }
}

class Invoice {
    var invoiceTitle:String?
    var invoiceDesc:String?
    var invoiceDate:Date?
    var invoiceType:invoiceType?
    var invoiceAmount:Int?
    var invoiceInOut:invoiceInOut?
    init(invoiceTitle:String?,invoiceDesc:String?,invoiceInOut:invoiceInOut?, invoiceType:invoiceType?,invoiceAmount:Int?,invoiceDate:Date?) {
        self.invoiceTitle = invoiceTitle
        self.invoiceDesc = invoiceDesc
        self.invoiceType = invoiceType
        self.invoiceAmount = invoiceAmount
        self.invoiceDate = invoiceDate
        self.invoiceInOut = invoiceInOut
    }
    convenience init(invoiceType:invoiceType) {
        self.init(invoiceTitle: nil, invoiceDesc: nil, invoiceInOut: nil, invoiceType: invoiceType, invoiceAmount: nil, invoiceDate: nil)
    }
    func setInvoiceAmount(invoiceAmount:Int,invoiceInOut:invoiceInOut){
        self.invoiceAmount = invoiceAmount
        self.invoiceInOut = invoiceInOut
    }
}

enum invoiceInOut {
    case expense
    case income
    
    var textColor:UIColor {
        switch self {
        case .expense:
        return #colorLiteral(red: 0.6075268817, green: 0.08433429636, blue: 0.1327555175, alpha: 1)
        case .income:
        return #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        }
    }
    var textSign:String {
        switch self {
        case .expense:
        return "-"
        case .income:
        return "+"
        }
    }
}

enum invoiceType {
    case flight
    case clothing
    case salary
    case groceries
    case rent
    case other
    
    public static let invoiceImageBorderColor:CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    public static let invoiceImageBorderWidth:CGFloat = 1.0
    public static let invoiceImageBgOpacity:CGFloat = 0.1
    public static let invoiceImageBorderCornerRadius:CGFloat = 30.0
    
    
    var invoiceTypeName:String {
        switch self {
        case .flight:
            return "Flight"
        case .clothing:
            return "Clothing"
        case .groceries:
        return "Groceries"
        case .salary:
        return "Salary"
        case .rent:
            return "Rent"
        case .other:
            return "Other"
        }
    }
    var invoiceIcon:UIImage? {
        switch self {
        case .flight:
        return #imageLiteral(resourceName: "plane")
        case .clothing:
        return #imageLiteral(resourceName: "clothing")
        case .salary:
        return #imageLiteral(resourceName: "salary")
        case .groceries:
        return #imageLiteral(resourceName: "groceries")
        case .rent:
        return #imageLiteral(resourceName: "rent")
        case .other:
        return #imageLiteral(resourceName: "other")
        }
    }
    var invoiceImageBgColor:UIColor? {
        let opacity = invoiceType.invoiceImageBgOpacity
        switch self {
        case .flight:
            return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).withAlphaComponent(opacity)
        case .clothing:
            return #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1).withAlphaComponent(opacity)
        case .salary:
            return #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1).withAlphaComponent(opacity)
        case .groceries:
            return #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1).withAlphaComponent(opacity)
        case .rent:
            return #colorLiteral(red: 0.6075268817, green: 0.08433429636, blue: 0.1327555175, alpha: 1).withAlphaComponent(opacity)
        case .other:
            return #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1).withAlphaComponent(opacity)
        }
    }
}
