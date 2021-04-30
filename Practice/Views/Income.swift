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
    @Published var category: String = ""
}

struct Income: View {
    
    @Binding var addNewPresented: Bool
    @State var addNewCategory: Bool
    private let viewModel = AddIncomeViewModel()
    @ObservedObject var newData = AddNewIncome()
    
    var body: some View {
        Form {
            Text("Витрати | Прибуток | Борг")
            HStack {
                Image(systemName: "bag")
                TextField("0", text: $newData.sum).keyboardType(.numberPad).multilineTextAlignment(.trailing)
            }
            HStack {
                Button(action: {
                    self.addNewCategory = true
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title)
                        .foregroundColor(.black)
                }.sheet(isPresented: $addNewCategory) {
                    CategoryView(addNewCategory: self.$addNewCategory)
                }
            }
                
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
        
        }
    func addNew() {
        let transaction23 = TransactionViewModel(id: UUID(), sum: Double(newData.sum) ?? 0, date: newData.date, category: newData.category, commentary: newData.commentary)
        viewModel.addTransaction(transaction: transaction23)
        addNewPresented.toggle()
    }
    private func endEditing() {
        UIApplication.shared.endEditing()
    }

}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
