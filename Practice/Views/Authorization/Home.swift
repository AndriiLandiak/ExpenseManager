//
//  Home.swift
//  Practice
//
//  Created by Andrew Landiak on 07.05.2021.
//

import SwiftUI
import Firebase


struct Home : View {
    
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View{
        VStack {
            if self.status {
                Homescreen()
            }else{
                Login()
            }
        }
            .onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                    
                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
    }
}


struct Homescreen : View {
    
    var body: some View{
            
            TabView {
             AccountView(addNewCategory: false)
                 .tabItem { Label("Account", systemImage: "house")}
             ContentView()
                 .tabItem { Label("Transaction", systemImage: "arrow.left.arrow.right.circle")}
             DiagramView(changeFilter: false, value: 2)
                 .tabItem { Label("Analytics", systemImage: "banknote") }
                
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .colorMultiply(.white)
            .edgesIgnoringSafeArea(.top)
            .accentColor(.black)
    }
}
