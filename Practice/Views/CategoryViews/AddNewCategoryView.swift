//
//  AddNewCategoryView.swift
//  Practice
//
//  Created by Andrew Landiak on 01.05.2021.
//

import SwiftUI
import Firebase
struct AddNewCategoryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var detName: String = ""
    private let viewModel = AddUpdateCategory()
    let user = Auth.auth().currentUser?.email ?? ""
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
            TextField("Category", text: $detName)
            }
        }.navigationTitle("Update")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: {
                if detName != ""  {
                    let categoryNew = CategoryViewModel(id: UUID(), name: detName, userEmail: user)
                    viewModel.addCategory(category: categoryNew)
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

