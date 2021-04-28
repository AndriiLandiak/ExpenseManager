//
//  ContentView.swift
//  Practice
//
//  Created by Andrew Landiak on 19.04.2021.
//

import SwiftUI

struct MenuList: View {
    
    @ObservedObject var transactionVM = TransactionListViewModel()
    @State private var areYouGoingToIncomeView = false
    @State private var areYouGoingToOutcomeView = false
    
    var body: some View {
        NavigationView {
            List {
                Group {
                        VStack(alignment: .leading) {
                            Button(action: {
                                areYouGoingToIncomeView = true
                                areYouGoingToOutcomeView = false
                                print(areYouGoingToIncomeView)
                                refreshData()
                            }, label: {
                                Image(systemName: "plus.circle")
                            })
                        }.background(
                            NavigationLink(destination: Income(addNewPresented: $areYouGoingToIncomeView), isActive: $areYouGoingToIncomeView) {
                                Income(addNewPresented: $areYouGoingToIncomeView)
                            }
                        )
                        VStack(alignment: .trailing) {
                            Button(action: {
                                areYouGoingToOutcomeView = true
                                areYouGoingToIncomeView = false
                                print(areYouGoingToOutcomeView)
                                refreshData()
                            }, label: {
                                Image(systemName: "minus.circle")
                            })
                        }.background(
                            NavigationLink(destination: Outcome(addNewPresented: $areYouGoingToOutcomeView), isActive: $areYouGoingToOutcomeView) {
                                Outcome(addNewPresented: $areYouGoingToOutcomeView)
                            }
                        )
                }
                Group {
                    ForEach(self.transactionVM.transactions.indices, id: \.self) { idx in
                        Section(header: (Text(String(idx)))) {
                            NavigationLink(
                                destination: Edit(transactionVM: transactionVM, idx: idx)) {

                                    MenuCell(transactionVM: self.transactionVM.transactions[idx]).shadow(radius:10)
                                }
                        }
                    }.onDelete(perform: delete(at:))
                }
            }
            .navigationBarHidden(true)
            .navigationBarTitle("")
        }
        .onAppear {
            refreshData()
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
