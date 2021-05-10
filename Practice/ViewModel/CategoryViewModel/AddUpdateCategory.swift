//
//  AddCategory\.swift
//  Practice
//
//  Created by Andrew Landiak on 30.04.2021.
//

import SwiftUI

class AddUpdateCategory {
    
    func addCategory(category: CategoryViewModel) {
        ManageData.shared.addCategory(id: category.id, name: category.name, userEmail: category.userEmail)
    }
    
    func updateCategory(category: CategoryViewModel) {
        ManageData.shared.updateCategory(id: category.id, name: category.name)
    }
    
    func addDefaultCategoryForUser(userEmail: String) {
        let array:[String] = ["Cafe & Restaurant", "Product", "Education", "Public transport",
                    "Store", "Fitness", "Kid", "Else"]
        for el in array {
            let c = CategoryViewModel(id: UUID(), name: el, userEmail: userEmail)
            addCategory(category: c)
        }
    }
}
