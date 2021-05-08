//
//  AccountView.swift
//  Practice
//
//  Created by Andrew Landiak on 03.05.2021.
//

import Foundation
import SwiftUI
import Firebase

struct AccountView: View {
    
    @State var showActionSheet: Bool = false
    @State var showImagePicker: Bool = false
    @State var selectedImage: Image? = Image("")
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var addNewCategory: Bool
    
    
    var body: some View {
        VStack {
            
            Button {
                self.showActionSheet = true
            } label: {
                if selectedImage != Image("") {
                    self.selectedImage?.resizable().clipShape(Circle()).frame(width: 100, height: 100).overlay(Circle().stroke(Color.black, lineWidth: 5))
                }else {
                    Image(systemName: "person.crop.circle").resizable().frame(width: 100, height: 100).clipShape(Circle()).overlay(Circle().stroke(Color.clear, lineWidth: 0))
                }
            }
            .frame(width:100, height: 100)
            .padding(.top, 30)
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Add photo"), buttons: [
                                .default(Text("Choose from library"), action: {
                                    self.showImagePicker = true
                                    self.sourceType = .photoLibrary
                                }),
                    .cancel()
                ])
            }.accentColor(Color("AuthorizationColor"))
            
            

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
            .background(Color("LoginColor"))
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
            .background(Color("LoginColor"))
            .cornerRadius(10)
            .padding(.top, 25)
        }.sheet(isPresented: $showImagePicker, content: {
            ImagePicker(image: self.$selectedImage)
        })
    }
}

struct ImagePicker: UIViewControllerRepresentable {
 
    @Environment(\.presentationMode)
    var presentationMode
 
    @Binding var image: Image?
 
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
 
        @Binding var presentationMode: PresentationMode
        @Binding var image: Image?
 
        init(presentationMode: Binding<PresentationMode>, image: Binding<Image?>) {
            _presentationMode = presentationMode
            _image = image
        }
 
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            image = Image(uiImage: uiImage)
            presentationMode.dismiss()
 
        }
 
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }
 
    }
 
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image)
    }
 
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
 
    }
 
}

