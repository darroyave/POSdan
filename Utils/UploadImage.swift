//
//  UploadImage.swift
//  POSdan
//
//  Created by Dannover Arroyave on 7/01/21.
//

import SwiftUI
import Firebase

func UploadImage(imageData: Data, path: String, completion: @escaping (String) -> ()){
    
    let storage = Storage.storage().reference()
    
    let uid = UUID().uuidString
    
    storage.child(path).child(uid).putData(imageData, metadata: nil) { (_, err) in
        
        if err != nil {
            
            completion("")
            return
            
        }
        
        // Downloading Url And Sending Back...
        
        storage.child(path).child(uid).downloadURL { (url, err) in
            
            if err != nil {
                
                completion("")
                return
                
            }
            
            completion("\(url!)")
        }
    }
}
