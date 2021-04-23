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
    
    func fetchAllTransaction() {
        self.transactions = ManageData.shared.getAllTrasaction().map(TransactionViewModel.init)
    }
    
    func addTransaction(sum: Double, date: Date, category: String, commentary: String) {
        ManageData.shared.addTrasaction(id: UUID(), sum: sum, date: date, category: category, commentary: commentary)
    }
    
    func removeTransaction(at index: Int) {
        let bday = transactions[index]
        ManageData.shared.removeTrasaction(id: bday.id)
    }
}
