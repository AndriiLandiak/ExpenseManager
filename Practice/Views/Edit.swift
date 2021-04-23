//
//  Edit.swift
//  Practice
//
//  Created by Andrew Landiak on 23.04.2021.
//

import SwiftUI

struct Edit: View {
    
    @ObservedObject var transactionVM = TransactionListViewModel()
    var idx: Int = 0
    
    @State private var commentary: String = ""
    @State private var sum: String = ""
    @State private var date = Date()
    
    var body: some View {
        Form {
            Text("Витрати | Прибуток | Борг")
            HStack {
                Image(systemName: "bag")
                TextField("0", text: $sum).keyboardType(.numberPad).multilineTextAlignment(.trailing)
            }
            HStack {
                Text("Різні категорії")
            }
            HStack {
                Image(systemName: "calendar")
                DatePicker("", selection: $date, displayedComponents: .date).position(x: -15, y: 17)
            }
            HStack {
                Image(systemName: "text.bubble")
                TextField("Коментар", text: $commentary)
            }
        }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: {
                            self.transactionVM.removeTransaction(at: idx)
                            refreshData()
                            
                        }) {
                            Image(systemName: "trash")
                        }
                        Button("Зберегти") {
                            print("Good")
                    }
                }
            }
        }
    }

    func refreshData() {
        self.transactionVM.fetchAllTransaction()
    }
}

