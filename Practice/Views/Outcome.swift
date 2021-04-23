//
//  Outcome.swift
//  Practice
//
//  Created by Andrew Landiak on 23.04.2021.
//

import SwiftUI

struct Outcome: View {
    
    @ObservedObject var transactionVM = TransactionListViewModel()
    
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
                        Button("Зберегти") {
                           transactionVM.addTransaction(sum: -1213, date: Date(), category: "\u{1F6D2}", commentary: "Wow")
                           refreshData()
                    }
                }
            }
        }
    }
    func refreshData() {
        self.transactionVM.fetchAllTransaction()
    }
}
