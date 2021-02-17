//
//  CoreCurrency+CoreDataProperties.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 13/02/2021.
//
//

import Foundation
import CoreData


extension CoreCurrency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreCurrency> {
        return NSFetchRequest<CoreCurrency>(entityName: "CoreCurrency")
    }

    @NSManaged public var name: String?
    @NSManaged public var symbol: String?

}

extension CoreCurrency : Identifiable {

}
