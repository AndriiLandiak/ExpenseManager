//
//  TransfersListViewModel.swift
//  Practice
//
//  Created by Andrew Landiak on 23.04.2021.
//

import Foundation
import SwiftUI
import Combine


class TransactionListViewModel: ObservableObject {
    @Published var transactions = [TransactionViewModel]()
    
    func groupBy() -> [Day] {
        var date = [Day]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let grouped = Dictionary(grouping: transactions)  { (occurrence: TransactionViewModel) -> String in
            dateFormatter.string(from: occurrence.date)
        }
        date = grouped.map { day -> Day in
            Day(id: day.value[0].id, dateString: day.value[0].correctDate, tr: day.value)
        }
        return date
    }
    
    func getBalance() -> Double {
        var result: Double = 0
        for el in transactions {
            result += el.sum
        }
        return result
    }

    
    func takeDictionary() -> [String:Double] {
        var emptyDict: [String: Double] = [:]
        for el in transactions {
            if el.sum < 0 && !emptyDict.keys.contains(el.category) {
                emptyDict[el.category] = -el.sum
            } else if el.sum < 0, let zalupa = emptyDict[el.category] {
                emptyDict[el.category] = zalupa + (-el.sum)
            } else {
                continue
            }
        }
        return emptyDict
    }
    
    func takeByYear(_ year: Int) -> [String:Double] {
        var emptyDict: [String: Double] = [:]
        for el in transactions {
            if el.sum < 0 && !emptyDict.keys.contains(el.category) && Int(el.yearString) == year {
                emptyDict[el.category] = -el.sum
            } else if el.sum < 0, let zalupa = emptyDict[el.category], Int(el.yearString) == year {
                emptyDict[el.category] = zalupa + (-el.sum)
            } else {
                continue
            }
        }
        return emptyDict
    }
    
    func takeByYearAndMonth(_ year: Int,_ month: Int) -> [String:Double] {
        let monthSymbols = Calendar.current.monthSymbols
        var emptyDict: [String: Double] = [:]
        for el in transactions {
            if el.sum < 0 && !emptyDict.keys.contains(el.category) && Int(el.yearString) == year && el.onlyMonthString == monthSymbols[month] {
                emptyDict[el.category] = -el.sum
            } else if el.sum < 0, let zalupa = emptyDict[el.category], Int(el.yearString) == year, el.onlyMonthString == monthSymbols[month] {
                emptyDict[el.category] = zalupa + (-el.sum)
            } else {
                continue
            }
        }
        return emptyDict
    }
    
    func checkViewModel(trans: TransactionViewModel) -> Int {
        var s = 0
        for el in transactions {
            if el.id != trans.id {
                s += 1
                continue
            } else {
                return s
            }
        }
        return s
    }

    func fetchAllTransaction(userEmail: String) {
        self.transactions = ManageData.shared.getAllUserTransaction(userEmail: userEmail).map(TransactionViewModel.init)
    }
    
    func removeTransaction(at index: Int) {
        let bday = transactions[index]
        ManageData.shared.removeTrasaction(id: bday.id)
    }
}

