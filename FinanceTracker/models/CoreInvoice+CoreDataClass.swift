//
//  CoreInvoice+CoreDataClass.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 07/02/2021.
//
//

import Foundation
import CoreData
import UIKit

@objc(CoreInvoice)
public class CoreInvoice: NSManagedObject {
    
    // initiation for a full invoice
    convenience init(invoiceTitle:String,invoiceDesc:String,invoiceAmount:Int64,invoiceType:String,invoiceDate:Date,invoiceInOut:String) {
        self.init(context:CoreData.sharedContext)
        self.invoiceTitle = invoiceTitle
        self.invoiceDesc = invoiceDesc
        self.invoiceAmount = invoiceAmount
        self.invoiceType = invoiceType
        self.invoiceDate = invoiceDate
        self.invoiceInOut = invoiceInOut
    }
    // initiation only of the invoiceType
    convenience init(invoiceType:String) {
        self.init(context:CoreData.sharedContext)
        self.invoiceType = invoiceType
    }
    
    // global invoice properties
    public static let invoiceImageBorderColor:CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    public static let invoiceImageBorderWidth:CGFloat = 1.0
    public static let invoiceImageBgOpacity:CGFloat = 0.1
    public static let invoiceImageBorderCornerRadius:CGFloat = 30.0
    
    // returns textColor by invoiceInOut (expense /income)
    var textColor:UIColor {
        switch self.invoiceInOut {
        case "expense":
            return #colorLiteral(red: 0.6075268817, green: 0.08433429636, blue: 0.1327555175, alpha: 1)
        case "income":
            return #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        default:
            return #colorLiteral(red: 0.6075268817, green: 0.08433429636, blue: 0.1327555175, alpha: 1)
        }
    }
    
    // returns textSign by invoiceInOut (expense /income)
    var textSign:String {
        switch self.invoiceInOut {
        case "expense":
            return "-"
        case "income":
            return "+"
        default:
            return "-"
        }
    }
    
    // returns invoice type name by invoice type
    static func invoiceTypeName(invoiceType:String) -> String {
        switch invoiceType {
        case "flight":
            return "Flight"
        case "clothing":
            return "Clothing"
        case "groceries":
            return "Groceries"
        case "salary":
            return "Salary"
        case "rent":
            return "Rent"
        case "other":
            return "Other"
        default:
            return ""
        }
    }
    
    // returns invoice icon by invoice type
    static func invoiceIcon(invoiceType:String) -> UIImage {
        switch invoiceType {
        case "flight":
            return #imageLiteral(resourceName: "plane")
        case "clothing":
            return #imageLiteral(resourceName: "clothing")
        case "groceries":
            return #imageLiteral(resourceName: "groceries")
        case "salary":
            return #imageLiteral(resourceName: "salary")
        case "rent":
            return #imageLiteral(resourceName: "rent")
        case "other":
            return #imageLiteral(resourceName: "other")
        default:
            return #imageLiteral(resourceName: "other")
        }
    }
    
    // returns invoice background color by invoice type with custom opacity
    static func invoiceImageBgColor(invoiceType:String) -> UIColor {
        let opacity = CoreInvoice.invoiceImageBgOpacity
        switch invoiceType {
        case "flight":
            return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).withAlphaComponent(opacity)
        case "clothing":
            return #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1).withAlphaComponent(opacity)
        case "salary":
            return #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1).withAlphaComponent(opacity)
        case "groceries":
            return #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1).withAlphaComponent(opacity)
        case "rent":
            return #colorLiteral(red: 0.6075268817, green: 0.08433429636, blue: 0.1327555175, alpha: 1).withAlphaComponent(opacity)
        case "other":
            return #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1).withAlphaComponent(opacity)
        default:
            return #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1).withAlphaComponent(opacity)
        }
    }
    
    // returns invoice background color by invoice type full opacity
    static func invoiceImageBgColorFull(invoiceType:String) -> UIColor {
        switch invoiceType {
        case "flight":
            return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case "clothing":
            return #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        case "salary":
            return #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        case "groceries":
            return #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        case "rent":
            return #colorLiteral(red: 0.6075268817, green: 0.08433429636, blue: 0.1327555175, alpha: 1)
        case "other":
            return #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        default:
            return #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        }
    }
    
}
