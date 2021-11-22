//
//  CategoryIconCell.swift
//  Practice
//
//  Created by Yuliia Sorokopud on 18.11.2021.
//

import SwiftUI

struct CategoryColorCell: View {
    let colors: [Color] = [.blue, .red, .orange, .yellow, .green, .pink, .purple]
    var body: some View {
        HStack{
            ForEach(colors, id: \.self) { colo in
                Button(""){

                }
                .frame(width: 50, height: 50)
                .cornerRadius(50)
                .background(colo)
            }
        }
    }
}

struct CategoryIconCell: View {
    @Binding var imageName: String
    let images: [String] = ["bus", "person.2.fill", "cart", "cross", "alarm", "face.smiling", "book", "bookmark"]
    var body: some View {
        HStack{
            ForEach(images, id: \.self) { image in
                Button {
                    imageName = image
                } label: {
                    Image(systemName: image)
                        .scaledToFit()
                }
                .frame(width: 35, height: 35)
            }
        } .padding(.horizontal, 10)
        
    }
}
