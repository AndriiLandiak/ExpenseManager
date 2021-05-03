//
//  ContentView.swift
//  Practice
//
//  Created by Andrew Landiak on 19.04.2021.
//


import SwiftUI

struct ContentView: View {
    
    @ObservedObject var transactionVM = TransactionListViewModel()
    
    @State private var newCategory = false
    @State private var areYouGoingToIncomeView = false
    @State private var areYouGoingToOutcomeView = false
    
    var body: some View {
//        let dictionary = transactionVM.groupBy()
//        let keys = dictionary.map {$0.key}
//        let values = dictionary.map {$0.value}
        NavigationView {
            List {
                Group {
                        VStack(alignment: .leading) {
                            Button(action: {
                                areYouGoingToIncomeView = true
                                areYouGoingToOutcomeView = false
                                refreshData()
                            }, label: {
                                Image(systemName: "plus.circle")
                            })
                        }.background(
                            NavigationLink(destination: Expenses(addNewPresented: $areYouGoingToIncomeView, addNewCategory: newCategory), isActive: $areYouGoingToIncomeView) {
                                Expenses(addNewPresented: $areYouGoingToIncomeView, addNewCategory: newCategory)
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
                            NavigationLink(destination: Income(addNewPresented: $areYouGoingToOutcomeView), isActive: $areYouGoingToOutcomeView) {
                                Income(addNewPresented: $areYouGoingToOutcomeView)
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
                Group {
                    ForEach(self.transactionVM.transactions.indices, id: \.self) { idx in
                        Section(header: (Text(String(transactionVM.transactions[idx].correctDate)))) {
                            NavigationLink(
                                destination: Edit(transactionVM: transactionVM, idx: idx)) {
                                MenuCell(transactionVM: self.transactionVM.transactions[idx]).shadow(radius:10)
                                }
                        }
                    }.onDelete(perform: delete(at:))
                }
            }
            .navigationBarTitle(Text("Main"), displayMode: .inline)
            .onAppear {
                refreshData()
            }
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

struct MenuList: View {
    @ObservedObject var transactionVM = TransactionListViewModel()
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.white
        refreshData()
    }
    var body: some View {
            TabView {
                AccountView(addNewCategory: false)
                    .tabItem { Label("Account", systemImage: "house")
                        Print("Pidar")
                        Print(transactionVM.transactions.count)
                    }
                ContentView()
                    .tabItem { Label("Transaction", systemImage: "arrow.left.arrow.right.circle")
                        Print("Pidar")
                    }
                PieChartView(
                    values: Array(transactionVM.takeDictionary().values),
                    names: Array(transactionVM.takeDictionary().keys),
                    formatter: {value in String(format: "%.2f", value)})
                    .tabItem { Label("Analytics", systemImage: "banknote") }.onTapGesture {
                        refreshData()
                    }
            }.colorMultiply(.white)
            .edgesIgnoringSafeArea(.top)
            .accentColor(.black)
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
