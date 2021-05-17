//
//  AddIncomeViewModel.swift
//  Practice
//
//  Created by Andrew Landiak on 27.04.2021.
//

import Foundation
import SwiftUI

class AddExpensesViewModel {
    
    func addTransaction(transaction: TransactionViewModel) {
        ManageData.shared.addTrasaction(id: transaction.id, sum: -transaction.sum, date: transaction.date, category: transaction.category, commentary: transaction.commentary, userEmail: transaction.userEmail, card: transaction.card)
    }
    
    func updateTransaction(transaction: TransactionViewModel) {
        ManageData.shared.updateTrasaction(id: transaction.id, sum: -transaction.sum, date: transaction.date, commentary: transaction.commentary, creditCard: transaction.card)
    }
}

