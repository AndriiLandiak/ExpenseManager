import SwiftUI

class AddUpdateCategory {
    
    func addCategory(category: CategoryViewModel) {
        ManageData.shared.addCategory(id: category.id, name: category.name, userEmail: category.userEmail, imageName: category.imageName)
    }
    
    func updateCategory(category: CategoryViewModel) {
        ManageData.shared.updateCategory(id: category.id, name: category.name, imageName: category.imageName)
    }
    
    func addDefaultCategoryForUser(userEmail: String) {
        let array:[String] = ["Cafe & Restaurant", "Product", "Education", "Public transport",
                    "Store", "Fitness", "Kid", "Else"]
        let images:[String] = ["bookmark", "cart", "book", "bus", "cart", "cross", "face.smiling", "alarm"]
        for el in array.enumerated() {
            let c = CategoryViewModel(id: UUID(), name: el.element, userEmail: userEmail, imageName: images[el.offset])
            addCategory(category: c)
        }
    }
}


