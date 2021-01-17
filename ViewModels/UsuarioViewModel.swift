//
//  UsuarioViewModel.swift
//  POSdan
//
//  Created by Dannover Arroyave on 1/01/21.
//

import SwiftUI
import Firebase

class UsuarioViewModel : ObservableObject {
    
    @Published var isNewData = false
    
    @Published var usuarios: [UsuarioModel] = []
    
    @Published var noData = false
    
    @Published var id = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var tipo = ""
    
    init() {
        
        fetchData()
        
    }
    
    func fetchData() {
        
        COLLECTION_USERS.order(by: "email").addSnapshotListener({ (snap, err) in
            
            if err != nil {
                print(err!.localizedDescription)
                self.noData = true
                return
            }
            
            guard let data = snap else {
                self.noData = true
                return
            }
            
            if data.documentChanges.isEmpty{
                
                self.noData = true
                return
                
            }
            
            data.documentChanges.forEach { (doc) in
                
                if doc.type == .added {
                    
                    let user = try! doc.document.data(as: UsuarioModel.self)!
                    
                    DispatchQueue.main.async {
                        self.usuarios.append(user)
                    }
                }
                
                if doc.type == .removed {
                    
                    let id = doc.document.documentID
                    
                    self.usuarios.removeAll { (cat) -> Bool in
                        return cat.id == id
                    }
                }
                
                if doc.type == .modified {
                    
                    let id = doc.document.documentID
                    
                    let index = self.usuarios.firstIndex { (user) -> Bool in
                        return user.id == id
                    } ?? -1
                    
                    if index != -1 {
                        
                        self.usuarios[index].email = doc.document.data()["email"] as! String
                        self.usuarios[index].phone = doc.document.data()["phone"] as! String
                        self.usuarios[index].tipo = doc.document.data()["tipo"] as! String
                        
                    }
                    
                }
            }
        })
    }
    
    func saveData() {
        
        // Updating Item.....
        
        if id != "" {
            
            COLLECTION_USERS.document(id).updateData([
                
                "email": self.email,
                "phone": self.phone,
                "tipo": self.tipo
                
            ]) { (err) in
                
                self.id = ""
                
                self.isNewData.toggle()
                
                self.phone = ""
                self.email = ""
                self.tipo = ""
            }
            
            return
        }
        
        let user = UsuarioModel(email: self.email, phone: self.email, tipo: self.tipo)
        
        let _ = try! COLLECTION_USERS.addDocument(from: user) { (err) in
            
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            self.isNewData.toggle()
            
            self.phone = ""
            self.email = ""
            self.tipo = ""
        }
        
    }
    
    func EditItem(item: UsuarioModel){
        
        self.id = item.id!
        self.email = item.email
        self.tipo = item.tipo
        self.phone = item.phone
        
        self.isNewData.toggle()
    }
    
    func DeleteItem(id: String){
        
        COLLECTION_USERS.document(id).delete { (err) in
            
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
        }
        
    }
    
    func cancel() {
        
        self.id = ""
        self.email = ""
        self.tipo = ""
        self.phone = ""
        
    }
}
