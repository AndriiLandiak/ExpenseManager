//
//  AccountView.swift
//  Practice
//
//  Created by Andrew Landiak on 03.05.2021.
//

import SwiftUI

struct AccountView: View {
    @State var addNewCategory: Bool
    var body: some View {
        HStack {
            Button(action: {
                self.addNewCategory = true
            }) {
                Image(systemName: "plus.circle")
                    .font(.title)
                    .foregroundColor(.black)
            }.sheet(isPresented: $addNewCategory) {
                CategoryView()
            }
        }
    }
}

