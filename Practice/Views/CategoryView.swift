//
//  Category.swift
//  Practice
//
//  Created by Andrew Landiak on 30.04.2021.
//

import SwiftUI

struct CategoryView: View {
    var idx: Int = 0
    
    @Binding var addNewCategory: Bool
    
    @ObservedObject var categoryVM = CategoryListViewModel()
    private let viewModel = AddUpdateCategory()
    
    @State var newCategory = ""
    
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
            
        }
    }
//        List {
//            ForEach(self.categoryVM.categories.indices, id: \.self) { idx in
//                NavigationLink(
//                    destination: Edit(transactionVM: transactionVM, idx: idx)) {
//                    MenuCell(transactionVM: self.transactionVM.transactions[idx]).shadow(radius:10)
//                }
//            }.onDelete(perform: delete(at:))
//        }
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
