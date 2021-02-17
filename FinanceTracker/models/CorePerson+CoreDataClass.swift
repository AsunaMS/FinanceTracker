//
//  CorePerson+CoreDataClass.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 07/02/2021.
//
//

import Foundation
import CoreData

@objc(CorePerson)
public class CorePerson: NSManagedObject {
    
    // initiation without image
    convenience init(firstName:String,lastName:String,balance:Int64,income:Int64,expense:Int64,invoices:[NSSet]) {
        self.init(context:CoreData.sharedContext)
        self.firstName = firstName
        self.lastName = lastName
        self.balance = balance
        self.income = income
        self.expense = expense
        self.invoices = invoices
    }
    // initiation without image and invoices
    convenience init(firstName:String,lastName:String,balance:Int64,income:Int64,expense:Int64) {
        self.init(context:CoreData.sharedContext)
        self.firstName = firstName
        self.lastName = lastName
        self.balance = balance
        self.income = income
        self.expense = expense
    }
    // initiation without invoices
    convenience init(firstName:String,lastName:String,balance:Int64,income:Int64,expense:Int64, image:Data) {
        self.init(context:CoreData.sharedContext)
        self.firstName = firstName
        self.lastName = lastName
        self.balance = balance
        self.income = income
        self.expense = expense
        self.image = image
    }
    // initial set of user's desired curreny
    func setUserCurrency(currency:CoreCurrency) {
        self.currency = currency
    }
    // change user's profile image
    func setUserImage(data: Data) {
        self.image = data
        CoreData.shared.saveUser(person: self)
    }
    // un-used right now, maybe adding a system to change the application's currency preferences
    struct ConversionFailure{
        var message:String
        init(balance:Int64, currency: String,newCurrency:String) {
            self.message = "Conversion Failed! your balance \(balance.description) of \(currency) is lower then 1 \(newCurrency)"
        }
    }
    
    // return a set of all the ueers invoices
    func getInvoices() -> Set<CoreInvoice>? {
        let listOfInvoices = value(forKey: "invoices") as! Set<CoreInvoice>
       return listOfInvoices
    }
    
    // return a user invoice by its index in the set
    func getInvoice(at index: Int) -> CoreInvoice? {
        let listOfInvoices = value(forKey: "invoices") as! Set<CoreInvoice>
        for (i,invoice) in listOfInvoices.enumerated() {
            if i == index {
                return invoice
            }
        }
        return nil
    }
    // user adding an invoice, update user
     func invoiceAdded(invoice:CoreInvoice) {
        AppDelegate.user?.addToInvoices(invoice)
        if invoice.invoiceInOut == "expense" {
            balance = balance - invoice.invoiceAmount
            expense = expense + invoice.invoiceAmount
        } else if invoice.invoiceInOut == "income" {
            balance = balance + invoice.invoiceAmount
            income  = income + invoice.invoiceAmount
        }
        CoreData.shared.saveUser(person: self)
    }
    
}
