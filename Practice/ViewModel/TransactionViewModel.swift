//
//  TransfersViewModel.swift
//  Practice
//
//  Created by Andrew Landiak on 23.04.2021.
//

import Foundation
import SwiftUI
import Combine
import Firebase

class TransactionViewModel {
    var id: UUID
    var sum: Double
    var date: Date
    var category: String
    var commentary: String
    var userEmail: String
    
    var returnAll: String {
        return category + " " + commentary + " " +  userEmail
    }
    
    var monthAndDayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.dateFormat = "d MMMM"
        return f
    }()

    var yearFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .short
        f.dateFormat = "y"
        return f
    }()
    
    var dayWeekFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .short
        f.dateFormat = "EEEE"
        return f
    }()
    
    var correctDate: String {
        let year = Calendar.current.component(.year, from: Date())
        if year == Int(yearString) { return monthString + ", " + dayInWeekString }
        else { return monthString + " " + yearString + ", " + dayInWeekString}
    }
    
    var monthString: String {
        return monthAndDayFormatter.string(from: date).lowercased()
    }
    
    var onlyMonthString: String {
        let s = (monthAndDayFormatter.string(from: date).lowercased())
        let newS = s.components(separatedBy: CharacterSet.decimalDigits).joined(separator: "")
        return newS.removeWhitespace().capitalizingFirstLetter()
    }
    
    var dayInWeekString: String {
        return dayWeekFormatter.string(from: date).lowercased()
    }
    var yearString: String {
        return yearFormatter.string(from: date)
    }
    


    
    init(transaction: Transaction) {
        self.id = transaction.id ?? UUID()
        self.sum = transaction.sum
        self.date = transaction.date ?? Date()
        self.category = transaction.category ?? ""
        self.commentary = transaction.commentary ?? ""
        self.userEmail = transaction.userEmail ?? ""
    }
    
    init(id: UUID, sum: Double, date: Date, category: String, commentary: String, userEmail: String) {
        self.id = id
        self.sum = sum
        self.date = date
        self.category = category
        self.commentary = commentary
        self.userEmail = userEmail
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }

    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
