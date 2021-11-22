//
//  SignUp.swift
//  Practice
//
//  Created by Andrew Landiak on 07.05.2021.
//

import SwiftUI
import Firebase

struct SignUp : View {

    
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    @State var visible = false
    @State var revisible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""

    let category = AddUpdateCategory()
    
    var body: some View{
        
        ZStack{
                GeometryReader{_ in
                    VStack{
                        VStack {
                            Image("logo").frame(width: 100, height: 100)
                        }.padding(.top, 50)
                        
                        Text("Register")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 45)
                        
                        TextField("Email", text: self.$email)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("AuthorizationColor") : self.color,lineWidth: 2))
                        .padding(.top, 25)
                        
                        HStack(spacing: 15){
                            
                            VStack{
                                
                                if self.visible{
                                    
                                    TextField("Password", text: self.$pass)
                                    .autocapitalization(.none)
                                }
                                else{
                                    
                                    SecureField("Password", text: self.$pass)
                                    .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                
                                self.visible.toggle()
                                
                            }) {
                                
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("AuthorizationColor") : self.color,lineWidth: 2))
                        .padding(.top, 25)
                        
                        HStack(spacing: 15){
                            
                            VStack{
                                
                                if self.revisible{
                                    
                                    TextField("Re-password", text: self.$repass)
                                    .autocapitalization(.none)
                                }
                                else{
                                    
                                    SecureField("Re-password", text: self.$repass)
                                    .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                
                                self.revisible.toggle()
                                
                            }) {
                                
                                Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.repass != "" ? Color("AuthorizationColor") : self.color,lineWidth: 2))
                        .padding(.top, 25)
                        
                        Button(action: {
                            self.register()
                        }) {
                            
                            Text("Sign up")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("AuthorizationColor"))
                        .cornerRadius(30)
                        .padding(.top, 75)
                        
                        Button(action: {
                            self.show.toggle()
                            
                        }) {
                            
                            Text("Cancel")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("AuthorizationColor"))
                        .cornerRadius(30)
                        .padding(.top, 5)
                        
                    }
                    .padding(.horizontal, 25)
                }
            
            if self.alert{
                
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func register(){
        if self.email != ""{
            if self.pass == self.repass{
                        Auth.auth().createUser(withEmail: self.email, password: self.pass) { (res, err) in
                            if err != nil{
                                self.error = err!.localizedDescription
                                self.alert.toggle()
                                return
                            }
                            category.addDefaultCategoryForUser(userEmail: self.email)
                            
                            UserDefaults.standard.set(true, forKey: "status")
                            NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                        }
            }
            else{
                self.error = "Password mismatch"
                self.alert.toggle()
            }
        }
        else{
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
    
    
    
}
