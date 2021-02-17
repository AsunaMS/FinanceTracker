//
//  CorePerson+CoreDataProperties.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 07/02/2021.
//
//

import Foundation
import CoreData


extension CorePerson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CorePerson> {
        return NSFetchRequest<CorePerson>(entityName: "CorePerson")
    }
    @NSManaged public var image: Data?
    @NSManaged public var currency:CoreCurrency?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var balance: Int64
    @NSManaged public var income: Int64
    @NSManaged public var expense: Int64
    @NSManaged public var invoices: [NSSet]?

}

// MARK: Generated accessors for invoices
extension CorePerson {

    @objc(addInvoicesObject:)
    @NSManaged public func addToInvoices(_ value: CoreInvoice)

    @objc(removeInvoicesObject:)
    @NSManaged public func removeFromInvoices(_ value: CoreInvoice)

    @objc(addInvoices:)
    @NSManaged public func addToInvoices(_ values: NSSet)

    @objc(removeInvoices:)
    @NSManaged public func removeFromInvoices(_ values: NSSet)

}

extension CorePerson : Identifiable {

}
