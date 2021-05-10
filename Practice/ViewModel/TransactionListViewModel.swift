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
    
    func groupBy() -> Dictionary<DateComponents, [TransactionViewModel]> {
        let a = Dictionary(grouping: transactions) { (trans) -> DateComponents in
            let date2 = Calendar.current.dateComponents([.year, .day, .month], from: (trans.date))
            return date2
        }
        return a
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

    func fetchAllTransaction(userEmail: String) {
        self.transactions = ManageData.shared.getAllUserTransaction(userEmail: userEmail).map(TransactionViewModel.init)
    }
    
    func removeTransaction(at index: Int) {
        let bday = transactions[index]
        ManageData.shared.removeTrasaction(id: bday.id)
    }
}

