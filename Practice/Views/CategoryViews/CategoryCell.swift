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
            if transactionVM.name.contains("Restaurant") || transactionVM.name.contains("Cafe") {
                HStack {
                    Image("cafe").resizable().frame(width:20, height:20)
                }.frame(width:30)
                Text(transactionVM.name)
            }else if transactionVM.name.contains("Store") {
                HStack {
                    Image("mall").resizable().frame(width:20, height:20)
                }.frame(width:30)
                Text(transactionVM.name)
            }else if transactionVM.name.contains("Product") {
                HStack {
                    Image(systemName: "cart")
                }.frame(width:30)
                Text(transactionVM.name)
            }else if transactionVM.name.contains("Edu") {
                HStack {
                    Image(systemName: "book")
                }.frame(width:30)
                Text(transactionVM.name)
            }else if transactionVM.name.contains("trans") {
                HStack {
                    Image(systemName: "bus")
                }.frame(width:30)
                Text(transactionVM.name)
            }else if transactionVM.name.contains("Fit") {
                HStack {
                    Image("fitness").resizable().frame(width:20, height:20)
                }.frame(width:30)
                Text(transactionVM.name)
            }else if transactionVM.name.contains("Child") || transactionVM.name.contains("Kid") {
                HStack {
                    Image(systemName: "face.smiling.fill")
                }.frame(width:30)
                Text(transactionVM.name)
            }else if transactionVM.name == "IT" {
                HStack {
                    Image(systemName: "display")
                }.frame(width:30)
                Text(transactionVM.name)
            }else if transactionVM.name.contains("Phone"){
                HStack {
                    Image(systemName: "iphone")
                }.frame(width:30)
                Text(transactionVM.name)
            }else {
                HStack {
                    Image(systemName: "questionmark").resizable().frame(width:15, height:15)
                }.frame(width:30)
                Text(transactionVM.name)
            }
        }
    }
}

