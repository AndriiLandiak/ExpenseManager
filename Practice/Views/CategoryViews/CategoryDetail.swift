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
    @State var editModal: Bool = false
    @State var caterogyImageName = "book"
    let user = Auth.auth().currentUser?.email ?? ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
            Image(systemName: caterogyImageName)
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .padding(.top,50)
            CustonTextField(text: $detName)
            CategoryIconCell(imageName: $caterogyImageName)
            Spacer()
        }
        .padding(.top, 50)
        .navigationTitle("Сost category")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            self.detName = transactionVM.name
            self.caterogyImageName = transactionVM.imageName
        }
        .toolbar {
            Button(action: {
                if (detName != transactionVM.name && detName != "") || caterogyImageName != transactionVM.imageName  {
                    let categoryNew = CategoryViewModel(id: transactionVM.id, name: detName, userEmail: user, imageName: caterogyImageName)
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
