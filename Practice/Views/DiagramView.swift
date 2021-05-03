//
//  DiagramView.swift
//  Practice
//
//  Created by Andrew Landiak on 03.05.2021.
//

import SwiftUI

struct DiagramView: View {
    
    @ObservedObject var transactionVM = TransactionListViewModel()
    @State var choice = 0
    
    var body: some View {
        VStack {
            Picker("Zalupa", selection: $choice, content: {
                Text("All statistics").tag(0)
                Text("Per month").tag(1)
            })
            .pickerStyle(SegmentedPickerStyle())
            
            if choice == 0 {
                PieChartView(
                            values: Array(transactionVM.takeDictionary().values),
                            names: Array(transactionVM.takeDictionary().keys),
                            formatter: {value in String(format: "%.2f", value)})
            } else if choice == 1 {
                Print("1 for tag")
            }
        }
        .onAppear() {
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
