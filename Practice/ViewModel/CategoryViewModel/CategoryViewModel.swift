import Foundation
import SwiftUI
import Combine


struct CategoryViewModel {
    var id: UUID
    var name: String
    var userEmail: String
    var imageName: String

    
    init(category: CatEntity) {
        self.id = category.id ?? UUID()
        self.name = category.name ?? ""
        self.userEmail = category.userEmail ?? ""
        self.imageName = category.imageName ?? ""
    }
    
    init(id: UUID, name: String, userEmail: String, imageName: String) {
        self.id = id
        self.name = name
        self.userEmail = userEmail
        self.imageName = imageName
    }
}
