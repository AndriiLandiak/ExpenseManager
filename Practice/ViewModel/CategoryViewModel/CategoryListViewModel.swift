import Foundation
import SwiftUI
import Combine

class CategoryListViewModel: ObservableObject {
    @Published var categories = [CategoryViewModel]()

    func fetchAllCategory(userEmail: String) {
        self.categories = ManageData.shared.getAllUserCategory(userEmail: userEmail).map(CategoryViewModel.init)
    }
    
    func removeCategory(at index: Int) {
        let bday = categories[index]
        ManageData.shared.removeCategory(id: bday.id)
    }
    init(){}
    
    convenience init(userMail: String){
        self.init()
        fetchAllCategory(userEmail: userMail)
    }
}

