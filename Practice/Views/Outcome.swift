//
//  Outcome.swift
//  Practice
//
//  Created by Andrew Landiak on 23.04.2021.
//

import SwiftUI
import UIKit

class AddNewOutcome: ObservableObject {
    @Published var commentary: String = ""
    @Published var sum: String = ""
    @Published var date = Date()
    @Published var category: String = ""
}

struct Outcome: View {
    
    @Binding var addNewPresented: Bool
    private let viewModel = AddOutcomeViewModel()
    @ObservedObject var newData = AddNewOutcome()
    
    var body: some View {
        Form {
            Text("Витрати | Прибуток | Борг")
            HStack {
                Image(systemName: "bag")
                TextField("0", text: $newData.sum).keyboardType(.numberPad).multilineTextAlignment(.trailing)
            }
            HStack {
                Text("Різні категорії")
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

}
