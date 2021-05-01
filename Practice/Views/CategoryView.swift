//
//  Category.swift
//  Practice
//
//  Created by Andrew Landiak on 30.04.2021.
//

import SwiftUI

struct CategoryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var idx: Int = 0
    @ObservedObject var categoryVM = CategoryListViewModel()
    private let viewModel = AddUpdateCategory()
    
    @State var isPlaying : Bool = false //for image pencil
    @State var addNewCat : Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(self.categoryVM.categories.indices, id: \.self) { idx in
                       NavigationLink(
                        destination: CategoryDetail(transactionVM: categoryVM.categories[idx], categoryName:  categoryVM.categories[idx].name)) {
                        CategoryCell(transactionVM: categoryVM.categories[idx])
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
                    HStack {
                        Button(action: {
                           self.isPlaying.toggle()
                        }) {
                            Image(systemName: self.isPlaying == true ? "pencil.slash" : "pencil")
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
        self.categoryVM.fetchAllCategory()
    }
}
