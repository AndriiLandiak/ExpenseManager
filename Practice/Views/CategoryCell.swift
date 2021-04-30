//
//  CategoryCell.swift
//  Practice
//
//  Created by Andrew Landiak on 30.04.2021.
//

import Foundation
import SwiftUI

struct CategoryCell: View {
    var transactionVM: CategoryViewModel
    var body: some View {
        HStack {
            Image(systemName: "house")
            Text(transactionVM.name)
        }
    }
}
//
//extension UIScreen{
//   static let screenWidth2 = UIScreen.main.bounds.size.width
//   static let screenHeight2 = UIScreen.main.bounds.size.height
//   static let screenSize2 = UIScreen.main.bounds.size
//}
