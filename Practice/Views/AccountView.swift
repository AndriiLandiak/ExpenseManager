//
//  AccView.swift
//  Practice
//
//  Created by Andrew Landiak on 03.05.2021.
//

import Foundation
import SwiftUI
import Firebase

struct AccountView: View {
    
    @ObservedObject var balanceVM = TransactionListViewModel()

    @State var showActionSheet: Bool = false
    @State var showImagePicker: Bool = false
    @State var selectedImage: Image? = Image("")
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var addNewCategory: Bool
    @State var notDeleted: Bool = true
    private let user = Auth.auth().currentUser?.email ?? ""
    
    var body: some View {
        VStack {
            Button {
                self.showActionSheet = true
            } label: {
                if selectedImage != Image("") {
                    self.selectedImage?.resizable().clipShape(Circle()).frame(width: 150, height: 150).overlay(Circle().stroke(Color("AuthorizationColor"), lineWidth: 3))
                }else if user == "andriylandiak@gmail.com" && notDeleted && selectedImage == Image("") {
                    Image("me").resizable().frame(width: 150, height: 150).clipShape(Circle()).overlay(Circle().stroke(Color("AuthorizationColor"), lineWidth: 3))
                } else {
                    Image(systemName: "person.circle").resizable().frame(width: 150, height: 150).clipShape(Circle()).overlay(Circle().stroke(Color("AuthorizationColor"), lineWidth: 0))
                }
            }
            .frame(width:200, height: 200)
            .padding(.top, 20)
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Add photo"), buttons: [
                                .default(Text("Choose from library"), action: {
                                    self.showImagePicker = true
                                    self.sourceType = .photoLibrary
                                }),
                                .default(Text("Delete photo"), action: {
                                    notDeleted = false
                                    self.selectedImage = Image("")
                                }),
                    .cancel()
                ])
            }.accentColor(Color("AuthorizationColor"))
            Text(Auth.auth().currentUser?.email ?? "").foregroundColor(Color("AuthorizationColor"))
                .font(.system(size: 25))
                .padding(.top, 10)
            Spacer()
            AccountHeader(balance: balanceVM.getBalance())
            Spacer()
            VStack {
                Button(action: {
                    self.addNewCategory = true
                }) {
                    Text("Categories")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                }
                .sheet(isPresented: $addNewCategory) {
                    CategoryView()
                }
                .background(Color("AuthorizationColor"))
                .cornerRadius(10)
                .padding(.top, 25)
                
                Button(action: {
                    
                    try! Auth.auth().signOut()
                    UserDefaults.standard.set(false, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    
                }) {
                    
                    Text("Log out")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                }
                .background(Color("AuthorizationColor"))
                .cornerRadius(10)
                .padding(.top, 35)
            }.padding(.bottom, 40)
        }
        .onAppear() {
            refreshData()
        }
        .sheet(isPresented: $showImagePicker, content: {
            ImagePicker(image: self.$selectedImage)
        })
    }
    func refreshData() {
        self.balanceVM.fetchAllTransaction(userEmail: user)
    }
}

struct AccountManagerHeader: View {

    var body: some View {
        VStack {
            Text("Account manager")
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(.system(size: 25))
        }.frame(width: UIScreen.screenWidth, height: 80)
        .padding(.top, 0)
    }
}

struct AccountHeader: View {
    let balance: Double
    var body: some View {
        ZStack {
            HStack {
                Text("Balance:")
                    .multilineTextAlignment(.center)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 25))
                    .foregroundColor(Color("AuthorizationColor"))
                Text(String(balance.rounded(2)) + " $ ")
                    .multilineTextAlignment(.trailing)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 25))
                    .foregroundColor(Color("AuthorizationColor"))
            }
            .frame(width: UIScreen.screenWidth-60, height: 80, alignment: .trailing)
            .overlay(
                RoundedRectangle(cornerRadius: 10)                    .stroke(Color("AuthorizationColor"),lineWidth: 2)
            )
            .background(Color.white)
        }.frame(width: UIScreen.screenWidth, height: 150)
        .padding(.top, 0)
    }
}

extension Double {
    func rounded(_ digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}
