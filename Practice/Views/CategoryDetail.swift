//
//  CategoryDetail.swift
//  Practice
//
//  Created by Andrew Landiak on 30.04.2021.
//

import SwiftUI

struct CategoryDetail: View {
    var transactionVM: CategoryViewModel
    private let viewModel = AddUpdateCategory()
    @State var detName: String = ""
    var categoryName: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
            TextField(categoryName, text: $detName)
            }
        }.navigationTitle("Category of spending")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            self.detName = categoryName
        }
        .toolbar {
            Button(action: {
                if detName != categoryName && detName != ""  {
                    let categoryNew = CategoryViewModel(id: transactionVM.id, name: detName)
                    viewModel.updateCategory(category: categoryNew)
                }
            }) {
                HStack(spacing: 3) {
                    Image(systemName: "pencil")
                    Text("Edit")
                }
            }
           }
    }
}
