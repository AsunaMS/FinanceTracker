//
//  CoreInvoice+CoreDataProperties.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 07/02/2021.
//
//

import Foundation
import CoreData


extension CoreInvoice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreInvoice> {
        return NSFetchRequest<CoreInvoice>(entityName: "CoreInvoice")
    }
    

    @NSManaged public var invoiceTitle: String?
    @NSManaged public var invoiceDesc: String?
    @NSManaged public var invoiceAmount: Int64
    @NSManaged public var invoiceType: String?
    @NSManaged public var invoiceDate: Date?
    @NSManaged public var invoiceInOut: String?

}

extension CoreInvoice : Identifiable {

}
