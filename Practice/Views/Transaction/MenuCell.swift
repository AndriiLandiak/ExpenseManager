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
        HStack(alignment: .center, spacing: 50) {
            VStack {
                Image(systemName: "book").font(.system(size: 30))
            }.frame(width: 70, height: 50, alignment: .center)
            .position(x: 15, y: 25)
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center) {
                    HStack() {
                        Text(transactionVM.category).font(.system(size: 18))
                    }.frame(minWidth: 0, maxWidth: UIScreen.screenWidth-50, alignment: .leading)
                    HStack {
                        Text(String(transactionVM.sum))
                            .frame(minWidth:50, maxWidth: 100)
                            .font(.system(size: 18))
                            .frame(alignment: .trailing)
                    }.frame(minWidth: 0, maxWidth: 170)
                }.frame(width: UIScreen.screenWidth-50, height: 20)
                VStack {
                    HStack(alignment: .top, spacing: 0) {
                        Image(systemName: "bag").font(.system(size: 13)).padding(.top, 5)
                        Text("  Cash").foregroundColor(.gray).padding(.top, 2)
                    }.frame(minWidth: 0, maxWidth: 370, alignment: .leading)
                    HStack(alignment: .center, spacing: 0) {
                        if transactionVM.commentary != "" {
                            Image(systemName: "text.bubble").font(.system(size:12))
                            Text("  " + transactionVM.commentary).foregroundColor(.gray).fixedSize(horizontal: false, vertical: true).lineLimit(1).frame(width: 250, alignment: .leading)
                        }
                    }.frame(minWidth: 0, maxWidth: UIScreen.screenWidth, alignment: .leading)
                }
            }.frame(width: UIScreen.screenWidth-50)
        }.frame(width: UIScreen.screenWidth, height: 62)
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
