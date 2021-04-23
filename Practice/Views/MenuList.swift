//
//  ContentView.swift
//  Practice
//
//  Created by Andrew Landiak on 19.04.2021.
//

import SwiftUI

struct MenuList: View {
    
    @ObservedObject var transactionVM = TransactionListViewModel()
    
    @State var areYouGoingToIncomeView: Bool
    @State var areYouGoingToOutcomeView: Bool
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    HStack {
                        NavigationLink(destination: Income(transactionVM: transactionVM), isActive: $areYouGoingToIncomeView) {
                            Text("To income")
//                            areYouGoingToIncomeView = false
                        }
                        NavigationLink(destination: Outcome(transactionVM: transactionVM), isActive: $areYouGoingToOutcomeView) {
                            EmptyView()
                            Text("To outcome")
//                            areYouGoingToOutcomeView = false
                        }
//                        Button(action: {
//                            self.areYouGoingToIncomeView = true
//                        }, label: {
//                            Image(systemName: "plus.circle.fill")
//                        })
//                        Spacer()
//                        Button(action: {
//                            self.areYouGoingToOutcomeView = true
//                        }, label: {
//                            Image(systemName: "minus.circle.fill")
//                        })
                    }.onAppear() {
                        refreshData()
                    }
                }
                Group {
                    ForEach(self.transactionVM.transactions.indices, id: \.self) { idx in
                        NavigationLink(
                            destination: Edit(transactionVM: transactionVM, idx: idx)) {
                            Print(type(of: idx))
                                MenuCell(transactionVM: self.transactionVM.transactions[idx]).shadow(radius:10)
                            }
                    }.onDelete(perform: delete(at:))
                    
                }
            }
            .navigationBarHidden(true)
            .navigationBarTitle("")
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

struct HeaderList: View {
    var body: some View {
            Text("Hello, world!")
                .padding()
    }
}
