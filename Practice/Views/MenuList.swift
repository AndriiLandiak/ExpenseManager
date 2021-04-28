//
//  ContentView.swift
//  Practice
//
//  Created by Andrew Landiak on 19.04.2021.
//

//struct ContentView: View {
//    var body: some View {
//        TabView {
//            CardsScreen()
//                .tabItem { Label("Home", systemImage: "house") }
//            VStack {}
//                .tabItem { Label("Statistic", systemImage: "table") }
//            VStack {}
//                .tabItem { Label("Wallet", systemImage: "dollarsign.square") }
//            VStack {}
//                .tabItem { Label("Profile", systemImage: "person") }
//        }
//    }
//}

import SwiftUI

struct MenuList: View {
    
    @ObservedObject var transactionVM = TransactionListViewModel()
    
    @State private var areYouGoingToIncomeView = false
    @State private var areYouGoingToOutcomeView = false
    
    var body: some View {
        let dictionary = transactionVM.groupBy()
        let keys = dictionary.map {$0.key}
        let values = dictionary.map {$0.value}
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
//                Group {
//                    ForEach(keys.indices) { index in
//                        Section(header: Text(keys)) {
//                            Text(values)
//                        }
//                    }
//                }
//                Group {
//                    ForEach(self.transactionVM.transactions.indices, id: \.self) { idx in
//                        Section(header: (Text(String(transactionVM.transactions[idx].correctDate)))) {
//                            NavigationLink(
//                                destination: Edit(transactionVM: transactionVM, idx: idx)) {
//                                MenuCell(transactionVM: self.transactionVM.transactions[idx]).shadow(radius:10)
//                                }
//                        }
//                    }.onDelete(perform: delete(at:))
//                }
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
