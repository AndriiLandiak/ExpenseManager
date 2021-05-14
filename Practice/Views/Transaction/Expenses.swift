//
//  Income.swift
//  Practice
//
//  Created by Andrew Landiak on 23.04.2021.
//

import SwiftUI
import UIKit
import Firebase

class AddNewIncome: ObservableObject {
    @Published var commentary: String = ""
    @Published var sum: String = ""
    @Published var date = Date()
}

struct Expenses: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var newData = AddNewIncome()
    @ObservedObject var categoryVM = CategoryListViewModel()
    private let viewModel = AddExpensesViewModel()
    private let user = Auth.auth().currentUser?.email ?? ""
    @Binding var addNewPresented: Bool
    @State var addNewCategory: Bool
    @State private var selectedFrameworkIndex = -1 // pick category we want
    
    var body: some View {
        NavigationView {
            Form {
                Text("Expenses").frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                HStack {
                    Image(systemName: "bag")
                    TextField("0", text: $newData.sum).keyboardType(.numberPad).multilineTextAlignment(.trailing)
                }
                VStack {
                    Picker("Category: ", selection: $selectedFrameworkIndex) {
                        ForEach(categoryVM.categories.indices, id: \.self) { idx in
                            if idx == categoryVM.categories.indices.last {
                                Text(categoryVM.categories[idx].name)
                                    .navigationBarTitle("Select category", displayMode: .inline)
                                    .navigationBarItems(trailing: button())
                            } else {
                                Text(categoryVM.categories[idx].name)
                            }
                        }
                    }
                    .background(Color.white)
                }.background(Color.white)
                HStack {
                    Image(systemName: "calendar")
                    DatePicker("", selection: $newData.date, in: ...Date(), displayedComponents: .date).position(x: 70, y: 16).labelsHidden()
                }
                HStack {
                    Image(systemName: "text.bubble")
                    TextField("Commentary", text: $newData.commentary)
                }
                HStack (spacing: 30) {
                    Button(action: {presentationMode.wrappedValue.dismiss()}) {
                        Text("Cancel")
                        .bold()
                    }.padding()
                }
                HStack (spacing: 30) {
                    Button(action: {self.addNew()}) {
                        Text("Save")
                        .bold()
                    }.padding()
                }
            }
            .onAppear() {
                refreshCategory()
            }
        }.navigationBarHidden(true)
        .navigationBarTitle("")
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        
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
    func addNew() {
        if categoryVM.categories.count > 0 && selectedFrameworkIndex >= 0 {
            let transaction23 = TransactionViewModel(id: UUID(), sum: Double(newData.sum) ?? 0, date: newData.date, category: categoryVM.categories[selectedFrameworkIndex].name, commentary: newData.commentary, userEmail: user)
            viewModel.addTransaction(transaction: transaction23)
        }else {
            let transaction23 = TransactionViewModel(id: UUID(), sum: Double(newData.sum) ?? 0, date: newData.date, category: "No category", commentary: newData.commentary, userEmail: user)
            viewModel.addTransaction(transaction: transaction23)
        }
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
