//
//  AddNewCategoryView.swift
//  Practice
//
//  Created by Andrew Landiak on 01.05.2021.
//

import SwiftUI

struct AddNewCategoryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var detName: String = ""
    private let viewModel = AddUpdateCategory()
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
            TextField("Category", text: $detName)
            }
        }.navigationTitle("Сost category")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: {
                if detName != ""  {
                    let categoryNew = CategoryViewModel(id: UUID(), name: detName)
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

