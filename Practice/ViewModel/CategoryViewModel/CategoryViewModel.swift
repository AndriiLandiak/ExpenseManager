//
//  CategoryViewModel.swift
//  Practice
//
//  Created by Andrew Landiak on 30.04.2021.
//


import Foundation
import SwiftUI
import Combine


struct CategoryViewModel {
    var id: UUID
    var name: String
    var userEmail: String

    
    init(category: CatEntity) {
        self.id = category.id ?? UUID()
        self.name = category.name ?? ""
        self.userEmail = category.userEmail ?? ""
    }
    
    init(id: UUID, name: String, userEmail: String) {
        self.id = id
        self.name = name
        self.userEmail = userEmail
    }
}
