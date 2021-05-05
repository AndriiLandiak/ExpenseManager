//
//  CategoryListViewModel.swift
//  Practice
//
//  Created by Andrew Landiak on 30.04.2021.
//

import Foundation
import SwiftUI
import Combine

class CategoryListViewModel: ObservableObject {
    @Published var categories = [CategoryViewModel]()

    func fetchAllCategory() {
        self.categories = ManageData.shared.getAllCategory().map(CategoryViewModel.init)
    }
    
    func removeCategory(at index: Int) {
        let bday = categories[index]
        ManageData.shared.removeCategory(id: bday.id)
    }
}

