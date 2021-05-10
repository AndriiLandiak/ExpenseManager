//
//  CategoryDetail.swift
//  Practice
//
//  Created by Andrew Landiak on 30.04.2021.
//

import SwiftUI
import Firebase

struct CategoryDetail: View {
    var transactionVM: CategoryViewModel
    private let viewModel = AddUpdateCategory()
    @State var detName: String = ""
    var categoryName: String = ""
    let user = Auth.auth().currentUser?.email ?? ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
            TextField(categoryName, text: $detName)
            }
        }.navigationTitle("Сost category")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            self.detName = categoryName
        }
        .toolbar {
            Button(action: {
                if detName != categoryName && detName != ""  {
                    let categoryNew = CategoryViewModel(id: transactionVM.id, name: detName, userEmail: user)
                    viewModel.updateCategory(category: categoryNew)
                    presentationMode.wrappedValue.dismiss()
                } else {
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                HStack(spacing: 3) {
                    Text("Save")
                }
            }
           }
    }
}
