//
//  CategoryViewModel.swift
//  Practice
//
//  Created by Andrew Landiak on 30.04.2021.
//


import Foundation
import SwiftUI
import Combine


class CategoryViewModel {
    var id: UUID
    var name: String
    
    init(category: CatEntity) {
        self.id = category.id ?? UUID()
        self.name = category.name ?? ""
        
    }
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
