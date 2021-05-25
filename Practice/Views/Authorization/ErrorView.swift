//
//  ErrorView.swift
//  Practice
//
//  Created by Andrew Landiak on 07.05.2021.
//

import SwiftUI

struct ErrorView : View {
    
    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error : String
    
    var body: some View{
        GeometryReader{_ in
            VStack{
                
                HStack{
                    
                    Text(self.error == "RESET" ? "Message" : "Error")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                    
                    Spacer()
                }
                .padding(.horizontal, 25)
                
                Text(self.error == "RESET" ? "Password reset link has been sent successfully" : self.error)
                .foregroundColor(self.color)
                .padding(.top)
                .padding(.horizontal, 25)
                
                Button(action: {
                    
                    self.alert.toggle()
                    
                }) {
                    
                    Text(self.error == "RESET" ? "Ok" : "Cancel")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 120)
                }
                .background(Color("LoginColor"))
                .cornerRadius(10)
                .padding(.top, 25)
                
            }
            .padding(.vertical, 20)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(Color.white)
            .cornerRadius(15)
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 50)
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}
