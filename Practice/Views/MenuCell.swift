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
                Text(transactionVM.category).font(.system(size: 18))
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: "bag").font(.system(size: 13))
                    Text("  Готівка").foregroundColor(.gray)
                }
                HStack(alignment: .bottom, spacing: 0) {
                    if transactionVM.commentary != "" {
                        Image(systemName: "text.bubble").font(.system(size:12))
                        Text("  " + transactionVM.commentary).foregroundColor(.gray).multilineTextAlignment(.leading).lineLimit(1)
                    }
                }
            }.frame(width: 200, height: 70)
            Spacer()
            Text(String(transactionVM.sum)).frame(minWidth:50, maxWidth: 50)
        }
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
