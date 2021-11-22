//
//  Income.swift
//  Practice
//
//  Created by Andrew Landiak on 23.04.2021.
//

import SwiftUI
import UIKit
import Firebase

class AddNewIncomeOutcome: ObservableObject {
    @Published var commentary: String = ""
    @Published var sum: String = ""
    @Published var date = Date()
    @Published var creditCard = false
}

struct Expenses: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var newData = AddNewIncomeOutcome()
    @ObservedObject var categoryVM = CategoryListViewModel()
    private let viewModelIncome = AddIncomeViewModel()
    private let viewModelExpensen = AddExpensesViewModel()
    private let user = Auth.auth().currentUser?.email ?? ""
    @Binding var addNewPresented: Bool
    @State private var areYouGoingToIncomeView = true
    @State var addNewCategory: Bool
    @State private var selectedFrameworkIndex: Int = -1
    @State var choiceFilter: Int
    @State var cashFilter: Int = 0
    @State var alert = false
    @State var error = ""
    
    var body: some View {
        VStack {
            if choiceFilter == 1 {
                ZStack {
                    Form {
                        HStack {
                            Image(systemName: "bag")
                            TextField("0", text: $newData.sum).keyboardType(.numberPad).multilineTextAlignment(.trailing)
                        }
                        Picker("", selection: $cashFilter, content: {
                            Text("Cash").tag(0)
                            Text("Credit card").tag(1)
                        }).pickerStyle(SegmentedPickerStyle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.clear,lineWidth: 2)
                        )
                        VStack {
                            Picker("Category: ", selection: $selectedFrameworkIndex) {
                                ForEach(categoryVM.categories.indices, id: \.self) { idx in
                                    if idx == categoryVM.categories.indices.last {
                                        HStack{
                                            Image(systemName: categoryVM.categories[idx].imageName)
                                            Text(categoryVM.categories[idx].name)
                                        }
                                        .navigationBarTitle("Select category", displayMode: .inline)
                                        .navigationBarItems(trailing: button())
                                    } else {
                                        HStack{
                                            Image(systemName: categoryVM.categories[idx].imageName)
                                            Text(categoryVM.categories[idx].name)
                                        }
                                    }
                                }
                            }
                            .background(Color.white)
                        }.background(Color.white)
                        HStack {
                            Image(systemName: "calendar")
                            DatePicker("", selection: $newData.date, in: ...Date(), displayedComponents: .date).position(x: 70, y: 16).labelsHidden()
                                .accentColor(Color("AuthorizationColor"))
                        }
                        HStack {
                            Image(systemName: "text.bubble")
                            TextField("Commentary", text: $newData.commentary)
                        }
                    }
                    if self.alert{
                        ErrorView(alert: self.$alert, error: self.$error)
                    }
                }
            } else {
                ZStack {
                    Form {
                        HStack {
                            Image(systemName: "bag")
                            TextField("0", text: $newData.sum).keyboardType(.numberPad).multilineTextAlignment(.trailing)
                        }
                        Picker("", selection: $cashFilter, content: {
                            Text("Cash").tag(0)
                            Text("Credit card").tag(1)
                        }).pickerStyle(SegmentedPickerStyle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)                    .stroke(Color.clear,lineWidth: 2)
                        )
                        HStack {
                            Image(systemName: "calendar")
                            DatePicker("", selection: $newData.date, in: ...Date(), displayedComponents: .date).position(x: 70, y: 16).labelsHidden()
                                .accentColor(Color("AuthorizationColor"))
                        }
                        HStack {
                            Image(systemName: "text.bubble")
                            TextField("Commentary", text: $newData.commentary)
                        }
                    }.listStyle(GroupedListStyle())
                    if self.alert{
                        ErrorView(alert: self.$alert, error: self.$error)
                    }
                }
            }
        }
        .onAppear() {
            refreshCategory()
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .accentColor(Color("AuthorizationColor"))
        .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack (spacing: 30) {
                        Button(action: {
                            if (Double(newData.sum) ?? 0) == 0 {
                                self.error = "Enter correct sum"
                                self.alert.toggle()
                            } else {
                                if choiceFilter == 0 {
                                    self.addNewIncome()
                                } else {
                                    self.addNewExpenses()
                                }
                            }
                            
                        }) {
                            Text("Save").bold()
                        }.padding(.trailing, 5)
                    }
                }
            ToolbarItem(placement: .navigationBarLeading) {
                HStack (spacing: 30) {
                    Button(action: {
                        addNewPresented.toggle()
                    }) {
                        Image(systemName: "chevron.backward").frame(width: 10, height: 10)
                    }.padding(.trailing, 5)
                }
            }
            ToolbarItem(placement: .navigation) {
                HStack {
                    Picker("Another one", selection: $choiceFilter, content: {
                        Text("Income").tag(0)
                        Text("Expense").tag(1)
                    }).pickerStyle(SegmentedPickerStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 10).stroke(Color.clear,lineWidth: 2)
                    )
                }.frame(width: UIScreen.screenWidth-130)
            }
        }
    }
    func button() -> some View {
        HStack(alignment: .center, content: {
            Button(action: {
                self.addNewCategory = true
            }) {
                Image(systemName: "plus")
            }.sheet(isPresented: $addNewCategory) {
                AddCategoryPicker().onDisappear() {
                    refreshCategory()
                }
            }
        })
    }
    func addNewExpenses() {
            if cashFilter == 0 {
                newData.creditCard = false
            } else if cashFilter == 1 {
                newData.creditCard = true
            }
            if categoryVM.categories.count > 0 && selectedFrameworkIndex >= 0 {
                let transaction23 = TransactionViewModel(id: UUID(), sum: Double(newData.sum) ?? 0, date: newData.date, category: categoryVM.categories[selectedFrameworkIndex].name, commentary: newData.commentary, userEmail: user, card: newData.creditCard)
                viewModelExpensen.addTransaction(transaction: transaction23)
            }else {
                let transaction23 = TransactionViewModel(id: UUID(), sum: Double(newData.sum) ?? 0, date: newData.date, category: "No category", commentary: newData.commentary, userEmail: user, card: newData.creditCard)
                viewModelExpensen.addTransaction(transaction: transaction23)
            }
            addNewPresented.toggle()
    }
    
    func addNewIncome() {
            if cashFilter == 0 {
                newData.creditCard = false
            } else if cashFilter == 1 {
                newData.creditCard = true
            }
            let transaction23 = TransactionViewModel(id: UUID(), sum: Double(newData.sum) ?? 0, date: newData.date, category: "Income", commentary: newData.commentary, userEmail: user, card: newData.creditCard)
            viewModelIncome.addTransaction(transaction: transaction23)
            addNewPresented.toggle()
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            self.categoryVM.removeCategory(at: index)
        }
        refreshCategory()
    }
    func refreshCategory() {
        self.categoryVM.fetchAllCategory(userEmail: user)
    }
}
