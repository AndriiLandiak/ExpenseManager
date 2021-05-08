//
//  ManageData.swift
//  Practice
//
//  Created by Andrew Landiak on 23.04.2021.
//

import Foundation
import UIKit
import CoreData


public class ManageData {
    
    static let shared = ManageData(moc: NSManagedObjectContext.current)
    
    var managedContext: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.managedContext = moc
    }
    
    
    func getAllTrasaction() -> [Transaction] {
        var transfer = [Transaction]()
        let bdRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        let sdSortDate = NSSortDescriptor.init(key: "date", ascending: false)
        bdRequest.sortDescriptors = [sdSortDate]
        do {
            transfer = try self.managedContext.fetch(bdRequest)
        } catch {
            print(error)
        }
        return transfer
    }
    
    func addTrasaction(id: UUID,  sum: Double, date: Date, category: String, commentary:String) {
        let t = Transaction(context: self.managedContext)
        t.id = id
        t.date = date
        t.sum = sum
        t.category = category
        t.commentary = commentary
//        t.userEmail = userEmail
        do {
            try self.managedContext.save()
        } catch {
            print(error)
        }
    }
    
    func removeTrasaction(id: UUID) {
        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id=%@", id.uuidString)
        do {
            let bdays = try self.managedContext.fetch(fetchRequest)
            for bday in bdays {
                self.managedContext.delete(bday)
            }
            try self.managedContext.save()
        } catch {
          print(error)
        }
    }
    
    func updateTrasaction(id: UUID, sum: Double, date: Date, commentary:String) {
        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id=%@", id.uuidString)
        do {
            let trsfrs = try self.managedContext.fetch(fetchRequest).first
            trsfrs?.date = date
            trsfrs?.sum = sum
            trsfrs?.commentary = commentary
            try self.managedContext.save()
        } catch {
            print(error)
        }
    }
    
    func getAllCategory() -> [CatEntity] {
        var category = [CatEntity]()
        let bdRequest: NSFetchRequest<CatEntity> = CatEntity.fetchRequest()
        do {
            category = try self.managedContext.fetch(bdRequest)
        } catch {
            print(error)
        }
        return category
    }
    
    func addCategory(id: UUID, name: String) {
        let t = CatEntity(context: self.managedContext)
        t.id = id
        t.name = name
        do {
            try self.managedContext.save()
        } catch {
            print(error)
        }
    }
    
    func removeCategory(id: UUID) {
        let fetchRequest: NSFetchRequest<CatEntity> = CatEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id=%@", id.uuidString)
        do {
            let bdays = try self.managedContext.fetch(fetchRequest)
            for bday in bdays {
                self.managedContext.delete(bday)
            }
            try self.managedContext.save()
        } catch {
          print(error)
        }
    }
    
    func updateCategory(id: UUID, name:String) {
        let fetchRequest: NSFetchRequest<CatEntity> = CatEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id=%@", id.uuidString)
        do {
            let trsfrs = try self.managedContext.fetch(fetchRequest).first
            trsfrs?.name = name
            try self.managedContext.save()
        } catch {
            print(error)
        }
    }
    
}

extension NSManagedObjectContext {
    static var current: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
