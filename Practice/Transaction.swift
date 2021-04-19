//
//  Transaction.swift
//  Practice
//
//  Created by Andrew Landiak on 19.04.2021.
//

import Foundation
import CoreData


public class Transaction: NSManagedObject, Identifiable {
    @NSManaged public var sumTotal: Double
    @NSManaged public var date: Date
    @NSManaged public var commentary: String
    @NSManaged public var category: String
}


extension Transaction {
    static func getAllTransactions() -> NSFetchRequest<Transaction> {
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest() as! NSFetchRequest<Transaction>
        
        let sortDescriptor = NSSortDescriptor(key: "sumTotal", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}

