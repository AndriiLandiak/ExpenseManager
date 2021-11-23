//
//  AccountViewModel.swift
//  Practice
//
//  Created by Данило Бойко on 22.11.2021.
//

import Foundation
import SwiftUI


class AccountViewModel: ObservableObject {
    func getPhoto(user :String  ) -> UIImage {
        print("check")
        let fileName = user + ".txt"
        let data = self.read(fromDocumentsWithFileName: fileName)
        if data == "" {
            return UIImage(systemName: "person.circle")!
        }
        return data.toImage()!
    }
    
    func savePhoto(photo: UIImage, user :String ){
        let fileName = user + ".txt"
        self.save(text: photo.toPngString() ?? "",
                      toDirectory: self.documentDirectory(),
                      withFileName: fileName)
    }
    
    private func save(text: String,
                      toDirectory directory: String,
                      withFileName fileName: String) {
        guard let filePath = self.append(toPath: directory,
                                         withPathComponent: fileName) else {
            return
        }
        
        do {
            try text.write(toFile: filePath,
                           atomically: true,
                           encoding: .utf8)
        } catch {
            print("Error", error)
            return
        }
        
        print("Save successful")
    }
    
    private func append(toPath path: String,
                        withPathComponent pathComponent: String) -> String? {
        if var pathURL = URL(string: path) {
            pathURL.appendPathComponent(pathComponent)
            
            return pathURL.absoluteString
        }
        
        return nil
    }
    
    private func documentDirectory() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                    .userDomainMask,
                                                                    true)
        return documentDirectory[0]
    }
    
    private func read(fromDocumentsWithFileName fileName: String)-> String {
        guard let filePath = self.append(toPath: self.documentDirectory(),
                                         withPathComponent: fileName) else {
                                            return ""
        }
        
        do {
            let savedString = try String(contentsOfFile: filePath)
            return savedString
        
        } catch {
            return ""
        }
    }
    
    
}

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}

extension UIImage {
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
  
    func toJpegString(compressionQuality cq: CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: cq)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
