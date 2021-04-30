//
//  AddCategory\.swift
//  Practice
//
//  Created by Andrew Landiak on 30.04.2021.
//

import SwiftUI

class AddUpdateCategory {
    
    func addCategory(category: CategoryViewModel) {
        ManageData.shared.addCategory(id: category.id, name: category.name)
    }
    
    func updateCategory(category: CategoryViewModel) {
        ManageData.shared.updateCategory(id: category.id, name: category.name)
    }
}
