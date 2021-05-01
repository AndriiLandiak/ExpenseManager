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
            VStack {
                Image(systemName: "book").font(.system(size: 30)).position(x: 35,y: 40)
            }.frame(width: 50, height: 50, alignment: .leading).position(x: 0, y: 11)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    Text("Cafe & restaurant").font(.system(size: 18))
                    Spacer()
                    Text(String(transactionVM.sum))
                        .frame(minWidth:50, maxWidth: 100)
                        .font(.system(size: 18))
                        .frame(alignment: .trailing)
                }.frame(width: UIScreen.screenWidth-50, height: 20)
                VStack {
                    HStack(alignment: .top, spacing: 0) {
                        Image(systemName: "bag").font(.system(size: 13))
                        Text("  Готівка").foregroundColor(.gray)
                    }.frame(minWidth: 80, maxWidth: UIScreen.screenWidth-110, alignment: .leading)
                    HStack(alignment: .center, spacing: 0) {
                        if transactionVM.commentary != "" {
                            Image(systemName: "text.bubble").font(.system(size:12))
                            Text("  " + transactionVM.commentary).foregroundColor(.gray).multilineTextAlignment(.leading).lineLimit(1)
                        }
                    }.frame(minWidth: 80, maxWidth: UIScreen.screenWidth-110, alignment: .leading)
                }.position(x: 190, y: 22)
            }.frame(width: UIScreen.screenWidth-50)
        }.frame(height: 62)
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
