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

    func fetchAllTransaction() {
        self.transactions = ManageData.shared.getAllTrasaction().map(TransactionViewModel.init)
    }
    
    func removeTransaction(at index: Int) {
        let bday = transactions[index]
        ManageData.shared.removeTrasaction(id: bday.id)
    }
}
