//
//  Category.swift
//  Practice
//
//  Created by Andrew Landiak on 30.04.2021.
//

import SwiftUI
import Firebase
struct CategoryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var idx: Int = 0
    @ObservedObject var categoryVM = CategoryListViewModel()
    private let viewModel = AddUpdateCategory()
    private let user = Auth.auth().currentUser?.email ?? ""
    @State var isPlaying : Bool = false //for image pencil
    @State var addNewCat : Bool = false
    
    @State private var selectedFrameworkIndex = 0 // pick category we want

    var body: some View {
        NavigationView {
            List() {
                ForEach(self.categoryVM.categories.indices, id: \.self) { idx in
                           NavigationLink(
                            destination: CategoryDetail(transactionVM: categoryVM.categories[idx])) {
                                HStack{
                                    Image(systemName: categoryVM.categories[idx].imageName)
                                    Text(categoryVM.categories[idx].name)
                                }
                           }
                    }.onDelete(perform:delete(at:))
            }.onAppear() {
                refreshCategory()
            }.navigationBarTitle(Text("Categories"), displayMode: .inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    HStack {
                        NavigationLink(destination: AddNewCategoryView()) {
                            Image(systemName: "plus")
                        }
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "multiply")
                    }
                }
              }
        }.accentColor(.black)
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            self.categoryVM.removeCategory(at: index)
        }
        refreshCategory()
    }
    func refreshCategory() {
        self.categoryVM.fetchAllCategory(userEmail: user)
    }
}
