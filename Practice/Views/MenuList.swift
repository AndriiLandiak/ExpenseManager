//
//  ContentView.swift
//  Practice
//
//  Created by Andrew Landiak on 19.04.2021.
//


import SwiftUI
import Firebase

struct ContentView: View {
    
    @ObservedObject var transactionVM = TransactionListViewModel()
    
    @State private var checkButtonTransaction = false // to check if button add trans was clicked
    @State private var newCategory = false
    @State private var areYouGoingToIncomeView = false
    @State private var areYouGoingToOutcomeView = false
    @State private var forSearchBar = false
    @State private var tapOnButton = false // when tap on plus and we should make gray screen
    @State private var searchText: String = ""
    let user = Auth.auth().currentUser?.email ?? ""
    var daySections: [Day] {
        get {
            return transactionVM.groupBy()
        }
    }
    var body: some View {
        NavigationView {
            ZStack {
                if tapOnButton {
                    Print("pomidor")
                }
                List {
                    if forSearchBar {
                        SearchBar(text: $searchText)
                                .padding(.top, 0)
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
                .onAppear {
                    checkButtonTransaction = false
                    refreshData()
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationTitle("")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            forSearchBar.toggle()
                        }, label: {
                            if forSearchBar {
                                Image(systemName: "magnifyingglass.circle")
                                    .frame(width: 100, height: 100)
                            } else {
                                Image(systemName: "magnifyingglass")
                                    .frame(width: 100, height: 100)
                            }
                        })
                    }
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Text(String(transactionVM.getBalance().rounded(2)) + " $").font(Font.body.bold())
                    }
                  }
                if checkButtonTransaction {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            VStack {
                                HStack  {
                                    Text("Expense")
                                        .padding(.trailing, -10)
                                        .padding(.bottom, 2)
                                    Button(action: {
                                        areYouGoingToIncomeView = false
                                        areYouGoingToOutcomeView = true
                                        refreshData()
                                    }, label: {
                                        Text("-")
                                        .font(.system(.largeTitle))
                                        .frame(width: 57, height: 50)
                                        .foregroundColor(Color.white)
                                        .padding(.bottom, 5)
                                    })
                                    .background(
                                        NavigationLink(destination: Expenses(addNewPresented: $areYouGoingToOutcomeView, addNewCategory: newCategory, choiceFilter: 1), isActive: $areYouGoingToOutcomeView) {
                                            EmptyView()
                                        }
                                    )
                                    .background(Color("PlusColor"))
                                    .cornerRadius(38.5)
                                    .padding()
                                    .padding(.trailing, 0)
                                    .shadow(color: Color.black.opacity(0.3),
                                            radius: 3,
                                            x: 3,
                                            y: 3)
                                }
                                HStack  {
                                    Text("Income")
                                        .padding(.trailing, -10)
                                        .padding(.bottom, 5)
                                    Button(action: {
                                        areYouGoingToIncomeView = true
                                        areYouGoingToOutcomeView = false
                                        refreshData()
                                    }, label: {
                                        Text("+")
                                        .font(.system(.largeTitle))
                                        .frame(width: 57, height: 50)
                                        .foregroundColor(Color.white)
                                        .padding(.bottom, 5)
                                    })
                                    .background(
                                        NavigationLink(destination: Expenses(addNewPresented: $areYouGoingToIncomeView, addNewCategory: newCategory, choiceFilter: 0), isActive: $areYouGoingToIncomeView) {
                                            EmptyView()
                                        }
                                    )
                                    .background(Color("PlusColor"))
                                    .cornerRadius(38.5)
                                    .padding()
                                    .padding(.bottom, 0)
                                    .padding(.trailing, -10)
                                    .shadow(color: Color.black.opacity(0.3),
                                            radius: 3,
                                            x: 3,
                                            y: 3)
                                }
                            }
                        }
                    }
                } else {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                checkButtonTransaction.toggle()
                                tapOnButton.toggle()
                            }, label: {
                                Text("+")
                                .font(.system(.largeTitle))
                                .frame(width: 57, height: 50)
                                .foregroundColor(Color.white)
                                .padding(.bottom, 5)
                            })
                            .background(Color("PlusColor"))
                            .cornerRadius(38.5)
                            .padding()
                            .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3)
                        }
                    }
                }
            }
        }.navigationTitle("")
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func refreshData() {
        self.transactionVM.fetchAllTransaction(userEmail: user)
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

struct SearchBar: View {
    @Binding var text: String

    @State private var isEditing = false
        
    var body: some View {
        HStack {
            TextField("Search ...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.text = ""
                                
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}
