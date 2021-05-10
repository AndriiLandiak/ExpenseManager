//
//  Edit.swift
//  Practice
//
//  Created by Andrew Landiak on 23.04.2021.
//

import SwiftUI
import Firebase

struct Edit: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var transactionVM = TransactionListViewModel()
    
    private let expViewModel = AddExpensesViewModel()
    private let incViewModel = AddIncomeViewModel()
    let user = Auth.auth().currentUser?.email ?? ""
    var idx: Int
    var check: Int = 0
    
    @State var addNewCategory: Bool
    @State var checkExpense: Bool = true
    @State private var commentary: String = ""
    @State private var sum: String = ""
    @State private var date = Date()
    
    var body: some View {
        Form {
            if transactionVM.transactions[idx].sum < 0 {
                Text("Expense").frame(minWidth:0, maxWidth: .infinity)
            }else {
                Text("Income").frame(minWidth:0, maxWidth: .infinity)
            }
            HStack {
                Image(systemName: "bag")
                if transactionVM.transactions[idx].sum < 0 {
                    TextField(String(transactionVM.transactions[idx].sum), text: $sum).keyboardType(.numberPad).multilineTextAlignment(.trailing)
                }else {
                    TextField(String(transactionVM.transactions[idx].sum), text: $sum).keyboardType(.numberPad).multilineTextAlignment(.trailing)
                }
            }
            
            HStack {
                Image(systemName: "calendar") 
                DatePicker("", selection: $date, displayedComponents: .date).position(x: -15, y: 17)
            }
            HStack {
                Image(systemName: "text.bubble")
                TextField(String(transactionVM.transactions[idx].commentary), text: $commentary)
            }
        }.onAppear() {
            if transactionVM.transactions[idx].sum < 0 {
                sum = String(-transactionVM.transactions[idx].sum)
                checkExpense = true
            }else {
                sum = String(transactionVM.transactions[idx].sum)
                checkExpense = false
            }
            commentary = transactionVM.transactions[idx].commentary
            date = transactionVM.transactions[idx].date
        }
        .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: {
                            self.transactionVM.removeTransaction(at: idx)
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "trash")
                        }
                        Button("Save") {
                            if commentary != transactionVM.transactions[idx].commentary || Double(sum) != transactionVM.transactions[idx].sum ||
                                date != transactionVM.transactions[idx].date {
                                let transNew = TransactionViewModel(id: transactionVM.transactions[idx].id, sum: Double(sum) ?? 0, date: date, category: transactionVM.transactions[idx].category, commentary: commentary, userEmail: user)
                                if checkExpense {
                                    expViewModel.updateTransaction(transaction: transNew)
                                } else {
                                    incViewModel.updateTransaction(transaction: transNew)
                                }
                                presentationMode.wrappedValue.dismiss()
                                
                    }
                }
            }
        }
    }
    }

}

//testing
