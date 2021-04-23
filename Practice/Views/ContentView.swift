//
//  ContentView.swift
//  Practice
//
//  Created by Andrew Landiak on 19.04.2021.
//

import SwiftUI

var b = 10.5

struct ContentView: View {
    
    @ObservedObject var transactionVM = TransactionListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Test")) {
                    VStack {
                        Button(action: {
                            b+=1
                            transactionVM.addTransaction(sum: b, date: Date(), category: "\u{1F6D2}", commentary: "Wow")
                            refreshData()
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                        })
                        Text("Hello, world!")
                            .padding()
                    }.onAppear() {
                        refreshData()
                    }
                }
                Section(header: Text("Answers")) {
                    ForEach(self.transactionVM.transactions.indices, id: \.self) { idx in
                            MenuCell(transactionVM: self.transactionVM.transactions[idx]).shadow(radius:10)
                    }.onDelete(perform: delete(at:))
                }
            }.navigationBarTitle(Text("Order view")).padding(.top)
             .navigationBarItems(trailing: EditButton())
        }
        
    }
    func refreshData() {
        self.transactionVM.fetchAllTransaction()
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            self.transactionVM.removeTransaction(at: index)
        }
        refreshData()
    }
    
}





extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}
