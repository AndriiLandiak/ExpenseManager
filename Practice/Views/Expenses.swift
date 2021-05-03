//
//  Income.swift
//  Practice
//
//  Created by Andrew Landiak on 23.04.2021.
//

import SwiftUI
import UIKit

class AddNewIncome: ObservableObject {
    @Published var commentary: String = ""
    @Published var sum: String = ""
    @Published var date = Date()
}

struct Expenses: View {
    
    @Binding var addNewPresented: Bool
    @State var addNewCategory: Bool
    
    private let viewModel = AddExpensesViewModel()
    @ObservedObject var newData = AddNewIncome()
    
    @ObservedObject var categoryVM = CategoryListViewModel()
    var check: Int = 0
    @State private var selectedFrameworkIndex = 0 // pick category we want

    
    var body: some View {
        Form {
            Text("Витрати | Прибуток | Борг")
            HStack {
                Image(systemName: "bag")
                TextField("0", text: $newData.sum).keyboardType(.numberPad).multilineTextAlignment(.trailing)
            }
            VStack {
                Picker("Category: ", selection: $selectedFrameworkIndex) {
                    ForEach(categoryVM.categories.indices, id: \.self) { idx in
                        if idx == categoryVM.categories.indices.last {
                            CategoryCell(transactionVM: categoryVM.categories[idx])
                                .navigationBarTitle("Select")
                                .navigationBarItems(trailing: button())
                        } else {
                            CategoryCell(transactionVM: categoryVM.categories[idx])
                        }
                    }
                }.labelsHidden()
                .background(Color.white)
            }.background(Color.white)
            HStack {
                Image(systemName: "calendar")
                DatePicker("", selection: $newData.date, in: ...Date(), displayedComponents: .date).position(x: 70, y: 16).labelsHidden()
            }
            HStack {
                Image(systemName: "text.bubble")
                TextField("Коментар", text: $newData.commentary)
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
        let transaction23 = TransactionViewModel(id: UUID(), sum: Double(newData.sum) ?? 0, date: newData.date, category: categoryVM.categories[selectedFrameworkIndex].name, commentary: newData.commentary)
        viewModel.addTransaction(transaction: transaction23)
        addNewPresented.toggle()
    }
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    func delete(at offsets: IndexSet) {
        for index in offsets {
            self.categoryVM.removeCategory(at: index)
        }
        refreshCategory()
    }
    func refreshCategory() {
        self.categoryVM.fetchAllCategory()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
