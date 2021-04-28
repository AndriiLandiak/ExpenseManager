//
//  MenuCell.swift
//  Practice
//
//  Created by Andrew Landiak on 21.04.2021.
//

import Foundation

import SwiftUI

struct MenuCell: View {
    var transactionVM: TransactionViewModel
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("\u{1F4F0}").padding(.leading).font(.system(size: 30))
            VStack(alignment: .leading, spacing: -5) {
                Text("Платежі, комісії").font(.system(size: 18))
                HStack(alignment: .center, spacing: 0) {
                    Text("\u{1F4F0}").font(.system(size: 11))
                    Text("Готівка").foregroundColor(.gray)
                }
                HStack(alignment: .bottom, spacing: 0) {
                    Text("\u{1F4CD}").font(.system(size: 12))
                    Text("Apple").foregroundColor(.gray)
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
            Spacer()
            Text(String(transactionVM.sum))
        }
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
