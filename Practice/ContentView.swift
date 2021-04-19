//
//  ContentView.swift
//  Practice
//
//  Created by Andrew Landiak on 19.04.2021.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
//    @FetchRequest(entity: Transaction.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.sumTotal, ascending: true)])
//    var transactions: FetchedResults<Transaction>
    
    @FetchRequest(fetchRequest: Transaction.getAllTransactions()) var transactions:
    FetchedResults<Transaction>
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Test")) {
                    VStack {
                        Button(action: {
                            let trans = Transaction(context: self.managedObjectContext)
                            trans.date = Date()
                            trans.sumTotal = -25.3
                            trans.category = "Fish"
                            trans.commentary = "Good job"
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                        })
                        Text("Hello, world!")
                            .padding()
                    }
                }
                Section(header: Text("Answers")) {
                    ForEach(self.transactions, id: \.self) { trans in
                        MenuCell(category: trans.category, sumTotal: trans.sumTotal)
                    }.onDelete(perform: removeTransaction)
                }
            }.navigationBarTitle(Text("Order view")).padding(.top)
             .navigationBarItems(trailing: EditButton())
        }
    }
    
    func removeTransaction(at offset: IndexSet) {
        for index in offset {
            let man = transactions[index]
            managedObjectContext.delete(man)
            do {
                try self.managedObjectContext.save()
            }catch {
                print(error)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
