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
        ManageData.shared.addTrasaction(id: transaction.id, sum: -transaction.sum, date: transaction.date, category: transaction.category, commentary: transaction.commentary)
    }
}
