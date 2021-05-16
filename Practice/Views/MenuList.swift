//
//  ContentView.swift
//  Practice
//
//  Created by Andrew Landiak on 19.04.2021.
//


import SwiftUI
import Firebase
import LocalAuthentication

struct ContentView: View {
    
    @ObservedObject var transactionVM = TransactionListViewModel()
    
    @State private var newCategory = false
    @State private var areYouGoingToIncomeView = false
    @State private var areYouGoingToOutcomeView = false
    
    let user = Auth.auth().currentUser?.email ?? ""
    
    var daySections: [Day] {
        get {
            return transactionVM.groupBy()
        }
    }
    
    var idx = 0
    
    var body: some View {
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
                
                Group {
                    ForEach(daySections) { section in
                        Section(header:CustomHeader(name: section.dateString)
                        ) {
                            ForEach(section.tr) { trans in
                                NavigationLink(
                                    destination: Edit(transactionVM: transactionVM, idx: transactionVM.checkViewModel(trans: trans),  addNewCategory: false)) {
                                    MenuCell(transactionVM: trans).shadow(radius:10)
                                    }
                            }
                        }
                        .textCase(nil)
                    }
//                    .onDelete(perform: delete(at:))
                }
            }
            .navigationBarTitle(Text("Transactions"), displayMode: .inline)
            .onAppear {
                refreshData()
            }
        }
    }
    
    func refreshData() {
        self.transactionVM.fetchAllTransaction(userEmail: user)
    }
    
//    func delete(at offsets: IndexSet) {
//        for index in offsets {
//            self.transactionVM.removeTransaction(at: index)
//        }
//        refreshData()
//    }
}

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}


struct CustomHeader: View {
    let name: String

    var body: some View {
        Text(name)
        .padding(.leading, 15)
        .frame(width: UIScreen.screenWidth, height: 28, alignment: .leading)
        .background(Color("AuthorizationColor"))
        .foregroundColor(Color.white)
        .border(Color.black, width: 1)
    }
}

struct MenuList: View {
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.white
    }
    var body: some View {
        Home()
    }
}
