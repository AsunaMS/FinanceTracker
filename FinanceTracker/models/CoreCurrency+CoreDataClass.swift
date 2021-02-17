//
//  CoreCurrency+CoreDataClass.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 13/02/2021.
//
//

import Foundation
import CoreData

@objc(CoreCurrency)
public class CoreCurrency: NSManagedObject {
    // initiating with currency name & symbol
    convenience init(name:String,symbol:String) {
        self.init(context:CoreData.sharedContext)
        self.name = name
        self.symbol = symbol
    }
}
