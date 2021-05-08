//
//  Login.swift
//  Practice
//
//  Created by Andrew Landiak on 07.05.2021.
//

import SwiftUI
import Firebase 
struct Login : View {
    
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var visible = false
    @State var alert = false
    @State var error = ""
    
    @State var show = false
    
    var body: some View{
        
        ZStack{
            
            ZStack(alignment: .topTrailing) {
                
                GeometryReader{_ in
                    
                    VStack{
                    
                        VStack {
                            Image("logo").frame(width: 100, height: 100)
                        }.frame(width: 100, height: 170)
                        .padding(.top, 15)
                        
                        Text("Login")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 20)
                        
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
                        
                        HStack{
                            
                            Spacer()
                            
                            Button(action: {
                                
                                self.reset()
                                
                            }) {
                                
                                Text("Forget password")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.gray)
                            }
                        }
                        .padding(.top, 20)
                        
                        Button(action: {
                            
                            self.verify()
                            
                        }) {
                            
                            Text("Sign in")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("AuthorizationColor"))
                        .cornerRadius(30)
                        .padding(.top, 85)
                        
                        Text("OR").padding(.top, 5).font(.system(size: 15))
                        
                        Button(action: {
                            
                            self.show.toggle()
                        }) {
                            
                            Text("Sign up")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .sheet(isPresented: self.$show) { SignUp(show: self.$show)
                        }
                        .background(Color("AuthorizationColor"))
                        .cornerRadius(30)
                        .padding(.top, 5)
                        
                    }
                    .padding(.horizontal, 25)
                }
            }
            
            if self.alert{
                
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
    }
    
    func verify(){
        if self.email != "" && self.pass != "" {

            Auth.auth().signIn(withEmail: self.email, password: self.pass) { (res, err) in

                if err != nil{

                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }

                print("success")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        }
        else{

            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
    
    func reset(){

        if self.email != ""{

            Auth.auth().sendPasswordReset(withEmail: self.email) { (err) in

                if err != nil{

                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }

                self.error = "RESET"
                self.alert.toggle()
            }
        }
        else{

            self.error = "Email Id is empty"
            self.alert.toggle()
        }
    }
}
