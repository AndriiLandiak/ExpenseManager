//
//  TransfersViewModel.swift
//  Practice
//
//  Created by Andrew Landiak on 23.04.2021.
//

import Foundation
import SwiftUI
import Combine


class TransactionViewModel {
    var id: UUID
    var sum: Double
    var date: Date
    var category: String
    var commentary: String
    
    var monthFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .short
        f.dateFormat = "MMM"
        return f
    }()
    
    var dayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .short
        f.dateFormat = "dd"
        return f
    }()
    
    var monthString: String {
        return monthFormatter.string(from: date)
    }
    
    var dayString: String {
        return dayFormatter.string(from: date)
    }
    
    init(id: UUID, sum: Double, date: Date, category: String, commentary: String) {
        self.id = id
        self.sum = sum
        self.date = date
        self.category = category
        self.commentary = commentary
    }
    
    init(transaction: Transaction) {
        self.id = transaction.id ?? UUID()
        self.sum = transaction.sum
        self.date = transaction.date ?? Date()
        self.category = transaction.category ?? ""
        self.commentary = transaction.commentary ?? ""
    }
}
