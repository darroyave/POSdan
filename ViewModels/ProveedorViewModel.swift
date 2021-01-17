//
//  SuppliersViewModel.swift
//  POSdan
//
//  Created by Dannover Arroyave on 2/01/21.
//

import SwiftUI
import Firebase

class ProveedorViewModel : ObservableObject {
    
    @Published var isNewData = false
    
    @Published var proveedores: [ProveedorModel] = []
    
    @Published var noData = false
    
    @Published var id = ""
    @Published var name = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var contactperson = ""
    @Published var address = ""
    
    init() {
        
        fetchData()
        
    }
    
    func fetchData() {
        
        COLLECTION_SUPPLIER.order(by: "name").addSnapshotListener({ (snap, err) in
            
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
                    
                    let user = try! doc.document.data(as: ProveedorModel.self)!
                    
                    DispatchQueue.main.async {
                        self.proveedores.append(user)
                    }
                }
                
                if doc.type == .removed {
                    
                    let id = doc.document.documentID
                    
                    self.proveedores.removeAll { (prov) -> Bool in
                        return prov.id == id
                    }
                }
                
                if doc.type == .modified {
                    
                    let id = doc.document.documentID
                    
                    let index = self.proveedores.firstIndex { (prov) -> Bool in
                        return prov.id == id
                    } ?? -1
                    
                    if index != -1 {
                        
                        self.proveedores[index].name = doc.document.data()["name"] as! String
                        self.proveedores[index].email = doc.document.data()["email"] as! String
                        self.proveedores[index].phone = doc.document.data()["phone"] as! String
                        self.proveedores[index].contactperson = doc.document.data()["contactperson"] as! String
                        self.proveedores[index].address = doc.document.data()["address"] as! String
                    }
                    
                }
            }
        })
    }
    
    func saveData() {
        
        // Updating Item.....
        
        if id != "" {
            
            COLLECTION_SUPPLIER.document(id).updateData([
                
                "name": self.name,
                "email": self.email,
                "phone": self.phone,
                "contactperson": self.contactperson,
                "address": self.address
                
            ]) { (err) in
                
                self.id = ""
                
                self.isNewData.toggle()
                
                self.name = ""
                self.email = ""
                self.phone = ""
                self.contactperson = ""
                self.address = ""
            }
            
            return
        }
        
        let prov = ProveedorModel(address: self.address, contactperson: self.contactperson, email: self.email, name: self.name, phone: self.phone)
        
        let _ = try! COLLECTION_SUPPLIER.addDocument(from: prov) { (err) in
            
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            self.isNewData.toggle()
            
            self.name = ""
            self.email = ""
            self.phone = ""
            self.contactperson = ""
            self.address = ""
            
        }
        
    }
    
    func EditItem(item: ProveedorModel){
        
        self.id = item.id!
        self.name = item.name
        self.email = item.email
        self.phone = item.phone
        self.contactperson = item.contactperson
        self.address = item.address
        
        self.isNewData.toggle()
    }
    
    func DeleteItem(id: String){
        
        COLLECTION_SUPPLIER.document(id).delete { (err) in
            
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
        }
        
    }
    
    func cancel() {
        
        self.id = ""
        self.name = ""
        self.email = ""
        self.phone = ""
        self.contactperson = ""
        self.address = ""
    }
}
